import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  get signupFormKey => null;

  ///  -- SIGNUP
  Future<void> signup() async {
    // Register user
    String url = "http://10.37.0.206/flutter_data/register.php";

    final response = await http.post(Uri.parse(url), body: {
      'firstname': firstName.text,
      'lastname': lastName.text,
      'username': username.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'password': password.text,
    });

    var data = json.decode(response.body);
    // ตรวจสอบว่าการส่งข้อมูลสำเร็จหรือไม่
    if (response.statusCode == 200) {
      // ถ้าสำเร็จ, ทำตามลำดับของคุณ
      print('Registration successful!');
      // นำผู้ใช้ไปยังหน้า VerifyEmailScreen หรือทำอย่างอื่นตามที่คุณต้องการ
      // Get.to(() => const VerifyEmailScreen());
    } else {
      // ถ้าไม่สำเร็จ, แสดงข้อความผิดพลาด
      print('Error: ${response.reasonPhrase}');
    }

    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      // if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check
      // if (!privacyPolicy.value) {
      //   TLoaders.warningSnackBar(
      //       title: 'Accept Privacy Poloicy',
      //       message:
      //           'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
      //   return;
      // }

      // Register user
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
