import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_button.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Form
               TSignupForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Social Button
              const TSocialButtons(),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}

// class TSignupForm extends StatelessWidget {
//   const TSignupForm({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Form(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.firstName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: TSizes.spaceBtwInputFields),
//               Expanded(
//                 child: TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.lastName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//             ],
//           ),
    
//           const SizedBox(
//             height: TSizes.spaceBtwInputFields,
//           ),
    
//           // Username
//           TextFormField(
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: TTexts.username,
//               prefixIcon: Icon(Iconsax.user_edit),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
          
//           // Email
//           TextFormField(
//             decoration: const InputDecoration(
//               labelText: TTexts.email,
//               prefixIcon: Icon(Iconsax.direct),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
    
//           // Phone Number
//           TextFormField(
//             decoration: const InputDecoration(
//               labelText: TTexts.phoneNo,
//               prefixIcon: Icon(Iconsax.call),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
    
//           // Password
//           TextFormField(
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: TTexts.password,
//               prefixIcon: Icon(Iconsax.password_check),
//               suffixIcon: Icon(Iconsax.eye_slash),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
    
//           // Term&Conditions Checkbox
//           Row(
//             children: [
//               SizedBox(width: 24, height: 24,child: Checkbox(value: true, onChanged: (value){})),
//               const SizedBox(width: TSizes.spaceBtwItems,),
//               Flexible(
//                 child: Text.rich(
//                   TextSpan(children: [
//                     TextSpan(text: '${TTexts.iAgreeTo}', style: Theme.of(context).textTheme.bodySmall),
//                     TextSpan(text: '${TTexts.privacyPolicy}', style: Theme.of(context).textTheme.bodyMedium!.apply(
//                       color: dark ? TColors.white : TColors.primary,
//                       decoration: TextDecoration.underline,
//                       decorationColor: dark ? TColors.white : TColors.primary, 
//                     )),
//                     TextSpan(text: '${TTexts.and}', style: Theme.of(context).textTheme.bodySmall),
//                     TextSpan(text: '${TTexts.termsOfUse}', style: Theme.of(context).textTheme.bodyMedium!.apply(
//                       color: dark ? TColors.white : TColors.primary,
//                       decoration: TextDecoration.underline,
//                       decorationColor: dark ? TColors.white : TColors.primary, 
//                     )),
//                     ]),
//                 ),
//               ),
//             ],
//           ),
    
//           const SizedBox(height: TSizes.spaceBtwSections),
    
//           // Sign Up button
//           SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {},child: const Text(TTexts.createAccount),),),
//         ],
//       ),
//     );
//   }
// }
