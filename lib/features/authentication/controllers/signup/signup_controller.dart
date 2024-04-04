import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/api.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  get signupFormKey => formKey;

  ///  -- SIGNUP
  Future<void> signup() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!formKey.currentState!.validate()) return;

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create an account, you must read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        TImages.docerAnimation,
      );

      // Register user
      String url = API.apiregister;
      final response = await http.post(Uri.parse(url), body: {
        'firstname': firstname.text,
        'lastname': lastname.text,
        'username': username.text,
        'email': email.text,
        'phone': phone.text,
        'password': password.text,
      });

      // Decode response
      var data = json.decode(response.body);

      // Check if the registration is successful
      if (response.statusCode == 200) {
        print('Registration successful!');
        // Navigate to the next screen
        // Get.to(() => const VerifyEmailScreen());
      } else {
        // Handle error if registration fails
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle exceptions
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop Loading
      TFullScreenLoader.stopLoading();
    }
  }
}
