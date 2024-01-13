import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:APPE/common/widgets/images/t_circular_image.dart';
import 'package:APPE/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:APPE/features/personalizetion/screens/address/address.dart';
import 'package:APPE/utils/constants/colors.dart';
import 'package:APPE/utils/constants/image_strings.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: TColors.white,
                          ),
                    ),
                  ),

                  /// -- User Profile Card
                  TUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),

            /// -- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account settings
                  const TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTite: 'Set Shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  const TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTite: 'Add, remove products and move to checkout'),
                  const TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTite: 'In-progress and Completed Orders'),
                  const TSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTite: 'Withdraw balance to registered bank account'),
                  const TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTite: 'List of all the discounred coupons'),
                  const TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTite: 'Set any kind of notifications message'),
                  const TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTite: 'Manage data usage and connected accounts'),

                  /// -- App Settings
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTite: 'Upload Data to your Cloud Firebase'),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolcation',
                    subTite: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTite: 'Search rasult is safe for all ages',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTite: 'Set image quality to be seen',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
