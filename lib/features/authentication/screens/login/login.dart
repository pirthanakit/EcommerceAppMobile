import 'dart:math';

import 'package:APPE/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:APPE/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:APPE/features/authentication/screens/signup/signup.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../controllers/api.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../utils/popups/loaders.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //logo
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(
                        dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                  ),
                  Text(TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.sm),
                  Text(TTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),

              //form
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      //Username
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: TTexts.username,
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwInputFields),

                      //Password
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: TTexts.password,
                          suffixIcon: Icon(Iconsax.eye_slash),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                      //Remember Me or Forgot
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // re
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text(TTexts.rememberMe),
                            ],
                          ),
                          // forget password
                          TextButton(
                              onPressed: () =>
                                  Get.to(() => const ForgetPassword()),
                              child: const Text(TTexts.forgetPassword)),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      //sign in button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (usernameController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              Map<String, dynamic> userData = {
                                'username': usernameController.text,
                                'password': passwordController.text,
                              };
                              // print(userData);

                              try {
                                var response = await http.post(
                                  Uri.parse(API.apilogin),
                                  body: jsonEncode(userData),
                                  headers: {"Content-Type": "application/json"},
                                );

                                if (response.statusCode == 200) {
                                  var data = json.decode(response.body);
                                  if (data['loginStatus'] == true) {
                                    print('Login successful!');
                                    // เมื่อเข้าสู่ระบบสำเร็จ นำผู้ใช้ไปยังหน้าที่ต้องการ
                                    // Get.to(() => NavigationMenu(userData: userData));
                                    // print(data);

                                    // ดึงข้อมูลผู้ใช้จาก API โดยใช้ user_id ที่ได้จากการ login
                                    var userId = data['userInfo']['user_id'];
                                    // print(userId);
                                    try {
                                      var userDataResponse = await http.get(
                                          Uri.parse(
                                              'http://192.168.77.14:5000/users/$userId'));
                                      if (userDataResponse.statusCode == 200) {
                                        var userData =
                                            json.decode(userDataResponse.body);
                                        print('User data: $userData');
                                        Get.to(() =>
                                            NavigationMenu(userData: userData));
                                        // ทำตามการจัดการข้อมูลผู้ใช้ต่อไป เช่น แสดงบนหน้าเว็บหรือประมวลผลต่อ
                                        TLoaders.successSnackBar(
                                            title: 'Login Success',
                                            message: e.toString());
                                      } else {
                                        print(
                                            'Error retrieving user data: ${userDataResponse.reasonPhrase}');
                                      }
                                    } catch (e) {
                                      print('Error retrieving user data: $e');
                                    }
                                  } else {
                                    print('Error: ${data['message']}');
                                    TLoaders.errorSnackBar(
                                        title: 'At least one of the fields above contains an error. ',
                                        message: e.toString());
                                  }
                                } else {
                                  print('Error: ${response.reasonPhrase}');
                                }
                              } catch (e) {
                                print('Error: $e');
                              }
                            } else {
                              print('Error: Username or password is empty');
                            }
                          },
                          child: const Text(TTexts.signIn),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),
                      //create acc
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => const SignupScreen());
                          },
                          child: Text(TTexts.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? TColors.darkGrey : TColors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    TTexts.orSignInWith.capitalize!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Flexible(
                    child: Divider(
                      color: dark ? TColors.darkGrey : TColors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 60,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              //footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: TSizes.iconMd,
                        height: TSizes.iconMd,
                        image: AssetImage(TImages.google),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: TSizes.iconMd,
                        height: TSizes.iconMd,
                        image: AssetImage(TImages.facebook),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
