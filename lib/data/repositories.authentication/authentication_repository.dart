import 'package:APPE/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/authentication/screens/login/login.dart';
import '../../features/authentication/screens/signup/signup.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// main.dart
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function
  screenRedirect() async {
    // Local Storage
    // deviceStorage.writeIfNull('IsFirstTime', true);
    // deviceStorage.read('IsFirstTime') != true
    //     ? Get.offAll(() => const LoginScreen())
    //     : Get.offAll(const LoginScreen());
    deviceStorage.writeIfNull('IsFirstTime', true);

    // Read the value from storage
    bool isFirstTime = deviceStorage.read('IsFirstTime') ?? true;

    // Redirect to the appropriate screen based on the condition
    isFirstTime
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const SignupScreen());
  }

  /**-------------------------------------------- Email & Password sign-in-----------------------------------------------*/
  
}
