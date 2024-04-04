import 'package:APPE/controllers/api.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatefulWidget {
  final List<dynamic> userData;
  const TSortableProducts({Key? key, required this.userData}) : super(key: key);

  @override
  _TSortableProductsState createState() => _TSortableProductsState();
}

class _TSortableProductsState extends State<TSortableProducts> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(API.apiproducts));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        products = responseData.cast<Map<String, dynamic>>();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load products'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: [
            'ชื่อสินค้า',
            'ราคาที่สูงขึ้น',
            'ราคาถูก',
            'ขาย',
            'มาใหม่',
            'ความนิยม'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products
        TGridLayout(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            final userId = index < widget.userData.length
                ? widget.userData[index]['user_id'].toString()
                : '';
            return TProductCardVertical(
              imageUrl: 'http://192.168.77.14/flutter_data/${product['image']}',
              title: product['product_name'],
              brand: product['brand'],
              price: product['price'].toString(),
              productId: product['productId'].toString(),
              amount: product['amount'].toString(),
              userId: userId,
              userData: widget.userData
            );
          },
        ),
      ],
    );
  }
}
