import 'dart:convert';

import 'package:APPE/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:APPE/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:APPE/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:APPE/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:APPE/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:APPE/navigation_menu.dart';
import 'package:APPE/utils/constants/image_strings.dart';
import 'package:APPE/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../controllers/api.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class CheckoutScreen extends StatelessWidget {
  final List<dynamic> userData;
  CheckoutScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Order Review',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Items in Cart
              TCartItems(showAddRemoveButtons: false),
              SizedBox(height: TSizes.spaceBtwSections),

              /// -- Coupon TextField
              TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// -- Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddresstSection(), // แก้ชื่อ 'Address'
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () async {
            try {
              await orderItems(userData); // ส่ง userData ไปในฟังก์ชัน orderItems
              await deleteAllCartItems(context); // เรียกใช้ deleteAllCartItems
              // เมื่อการลบทั้งหมดสำเร็จ ให้เปลี่ยนหน้าไปยัง SuccessScreen
              Get.to(() => SuccessScreen(
                    image: TImages.successfulPaymentIcon,
                    title: 'Payment Success!',
                    subtitle: 'Your items will be shipped soon!',
                    onPressed: () =>
                        Get.offAll(() => NavigationMenu(userData: userData)),
                  ));
            } catch (error) {
              print('Error deleting all items: $error');
            }
          },
          child: const Text('ยืนยันการชำระเงิน'),
        ),
      ),
    );
  }
}

Future<void> orderItems(List<dynamic> userData) async { // รับ userData เป็น parameter
  try {
    // ส่งคำขอ order ไปยังเซิร์ฟเวอร์
    // ตัวอย่างเช่น: http.post หรือ http.put กับ URL ที่เหมาะสมสำหรับการสั่งซื้อสินค้า
    final response = await http.post(
      Uri.parse(API.apiaddtoorder),
      body: jsonEncode(userData), // แปลง userData เป็น JSON ก่อนส่ง
      headers: {
        'Content-Type': 'application/json', // ต้องระบุ Content-Type เป็น application/json
      },
    );
    print('Items ordered successfully');
  } catch (error) {
    throw Exception('Failed to order items: $error');
  }
}

Future<void> deleteAllCartItems(BuildContext context) async {
  try {
    final response = await http.delete(Uri.parse('${API.apicart}'));
    if (response.statusCode == 200) {
      print('All items deleted successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('ลบรายการสินค้าทั้งหมดเรียบร้อย'),
      ));
    }
  } catch (error) {
    throw Exception('Failed to delete all items: $error');
  }
}