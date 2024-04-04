import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../controllers/api.dart';

class TCartItems extends StatefulWidget {
  TCartItems({
    Key? key,
    this.showAddRemoveButtons = true,
  }) : super(key: key);

  final bool showAddRemoveButtons;

  @override
  _TCartItemsState createState() => _TCartItemsState();
}

class _TCartItemsState extends State<TCartItems> {
  Future<List<Map<String, dynamic>>> fetchCartItems() async {
    final response = await http.get(Uri.parse(API.apicart));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  Future<void> deleteCartItem(cart_id) async {
    try {
      final response = await http.delete(Uri.parse('${API.apicart}/$cart_id'));
      if (response.statusCode == 200) {
        // สามารถทำอย่างอื่นตามที่ต้องการหลังจากลบรายการสินค้าได้
        print('Item deleted successfully');
        // รีเฟรชหน้าจอเมื่อลบสินค้าเสร็จสมบูรณ์
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('ลบสินค้าเรียบร้อยแล้ว'),
        ));
        // เรียกใช้ setState เพื่อรีเฟรชหน้าจอ
        setState(() {});
      } else {
        throw Exception('Failed to delete item: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete item: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCartItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('ไม่มีรายการสินค้า'));
        } else {
          final List<Map<String, dynamic>> products = snapshot.data!;

          // สร้างตัวแปรสำหรับเก็บราคายอดรวมสุทธิทั้งหมด
          int totalAmount = 0;

          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final product = products[index];

                  // คำนวณราคายอดรวมสุทธิของแต่ละรายการสินค้า
                  int subtotal = product['price'] * product['quantity'];

                  // เพิ่มราคายอดรวมสุทธิของแต่ละรายการสินค้าเข้าไปยังราคายอดรวมสุทธิทั้งหมด
                  totalAmount += subtotal;
                  print(totalAmount);

                  return Column(
                    children: [
                      TCartItem(
                        imageUrl:
                            'http://192.168.77.14/flutter_data/${product['image']}',
                        quantity: product['quantity'],
                        product: product['product_name'],
                      ),
                      if (widget.showAddRemoveButtons)
                        const SizedBox(height: 10),
                      if (widget.showAddRemoveButtons)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ราคาสุทธิ: $subtotal บาท'),
                            ElevatedButton(
                              onPressed: () async {
                                await deleteCartItem(product['cart_id']);
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                'ลบสินค้า',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
