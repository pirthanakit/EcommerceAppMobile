import 'dart:convert';

import 'package:APPE/common/widgets/icons/t_circular_icon.dart';
import 'package:APPE/utils/constants/colors.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/api.dart';
import '../../../../../utils/helpers/helper_functions.dart';

import 'package:http/http.dart' as http;

import '../../../../authentication/screens/login/login.dart';
import '../../home/home.dart';

class TBottomAddToCart extends StatefulWidget {
  final String imageUrl;
  final String price;
  final String productId; // เพิ่มตัวแปร productId
  final String userId; // เพิ่มตัวแปร productId
  final List<dynamic> userData;

  TBottomAddToCart({
    Key? key,
    required this.imageUrl,
    required this.price,
    required this.productId,
    required this.userId, required this.userData, // รับค่า productId มาจากภายนอก
  }) : super(key: key);

  @override
  _TBottomAddToCartState createState() => _TBottomAddToCartState();
}

class _TBottomAddToCartState extends State<TBottomAddToCart> {
  int quantity = 1; // จำนวนสินค้าเริ่มต้น

  Future<void> addToCart() async {
    int userId = int.parse(widget.userData[0]['user_id'].toString());
    Map<String, dynamic> userData = {
      'product_id': widget.productId,
      'user_id': userId,
      'quantity': quantity,
    };
    try {
      // ส่งข้อมูลไปยัง API เพื่อเพิ่มสินค้าลงในตะกร้า
      final response = await http.post(
        Uri.parse(API.apiaddtocart),
        body: jsonEncode(userData), // แปลงข้อมูลเป็น JSON ก่อนส่ง
        headers: {
          'Content-Type':
              'application/json', // ต้องระบุ Content-Type เป็น application/json
        },
      );
      print(widget.productId);
      print(widget.userId);
      print(quantity);
      print(userData);

      // ตรวจสอบการส่งข้อมูล
      if (response.statusCode == 200) {
        print('Product added to cart successfully!');
        // ทำอย่างอื่นตามที่ต้องการ เช่น นำผู้ใช้ไปยังหน้าที่ต้องการ
        Get.back();
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (quantity > 1) {
                    // ตรวจสอบว่าจำนวนมากกว่า 1 หรือไม่
                    setState(() {
                      quantity--; // ลบจำนวนลง 1
                    });
                  }
                },
                child: TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(quantity.toString(),
                  style: Theme.of(context).textTheme.titleSmall), // แสดงจำนวน
              const SizedBox(width: TSizes.spaceBtwItems),
              GestureDetector(
                onTap: () {
                  setState(() {
                    quantity++; // เพิ่มจำนวนขึ้น 1
                  });
                },
                child: TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: addToCart,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: const BorderSide(color: TColors.black),
            ),
            child: const Text('ซื้อเลย'),
          ),
        ],
      ),
    );
  }
}
