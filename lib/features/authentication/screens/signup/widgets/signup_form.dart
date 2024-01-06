import 'package:APPE/features/authentication/screens/signup/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

void registerUser(String firstName, String lastName, String username,
    String email, String phoneNo, String password) async {
  final url = Uri.parse('http://10.37.16.144:5000/api/register');
  final response = await http.post(
    url,
    body: {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "email": email,
      "phoneNo": phoneNo,
      "password": password,
    },
  );

  if (response.statusCode == 201) {
    // User registered successfully
    print('User registered successfully!');
  } else {
    // Registration failed
    print('Registration failed. Error: ${response.body}');
  }
}

class TSignupForm extends StatelessWidget {
  TSignupForm({
    super.key,
  });

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // Username
          TextFormField(
            controller: usernameController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Term&Conditions Checkbox
          const TTermsAndConditionCheckbox(),

          const SizedBox(height: TSizes.spaceBtwSections),

          // Sign Up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                registerUser(
                  firstNameController.text,
                  lastNameController.text,
                  usernameController.text,
                  emailController.text,
                  phoneNoController.text,
                  passwordController.text,
                );
              },
              child: const Text(TTexts.createAccount),
            ),
            // child: ElevatedButton(
            //   onPressed: () => Get.to(() => const VerifyEmailScreen()),
            //   child: const Text(TTexts.createAccount),
            // ),
          ),
        ],
      ),
    );
  }
}

class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Flexible(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: '${TTexts.iAgreeTo}',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '${TTexts.privacyPolicy}',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      )),
              TextSpan(
                  text: '${TTexts.and}',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '${TTexts.termsOfUse}',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      )),
            ]),
          ),
        ),
      ],
    );
  }
}
