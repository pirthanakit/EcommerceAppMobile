import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:APPE/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:APPE/features/personalizetion/screens/address/address.dart';
import 'package:APPE/features/shop/screens/order/order.dart';
import 'package:APPE/utils/constants/colors.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../authentication/screens/login/login.dart';
import '../../../shop/screens/cart/cart.dart';
import '../profile/profile.dart';

class SettingsController extends GetxController {
  // สร้าง observable variable สำหรับเก็บค่าการเปิด/ปิดของโหมดทั้งหมด
  final RxBool geographicLocation = true.obs;
  final RxBool safeMode = true.obs;
  final RxBool hdImageQuality = true.obs;

  // ฟังก์ชันสำหรับการเปลี่ยนค่าของ geographicLocation
  void toggleGeographicLocation() {
    geographicLocation.value = !geographicLocation.value;
  }

  // ฟังก์ชันสำหรับการเปลี่ยนค่าของ safeMode
  void toggleSafeMode() {
    safeMode.value = !safeMode.value;
  }

  // ฟังก์ชันสำหรับการเปลี่ยนค่าของ hdImageQuality
  void toggleHDImageQuality() {
    hdImageQuality.value = !hdImageQuality.value;
  }
}

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());
  final List<dynamic> userData;

  SettingsScreen({Key? key, required this.userData,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
              userData: userData,
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                    title: Text(
                      'บัญชีผู้ใช้',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: TColors.white,
                      ),
                    ),
                  ),

                  /// -- User Profile Card
                  TUserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen(userData: userData)), userData: userData,
                  ),
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
                  TSectionHeading(
                    title: 'การตั้งค่าบัญชี',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'ที่อยู่ของฉัน',
                    subTite: 'Set Shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'ตะกร้า',
                    subTite: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => CartScreen(userData: userData,)),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'คำสั่งซื้อ',
                    subTite: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'บัญชีธนาคาร',
                    subTite: 'Withdraw balance to registered bank account',
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'คูปองของฉัน',
                    subTite: 'List of all the discounred coupons',
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'การแจ้งเตือน',
                    subTite: 'Set any kind of notifications message',
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'ความเป็นส่วนตัวของบัญชี',
                    subTite: 'Manage data usage and connected accounts',
                  ),

                  /// -- App Settings
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'การตั้งค่า',
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'โหลดข้อมูล',
                    subTite: 'Upload Data to your Cloud Firebase',
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'ตำแหน่งทางภูมิศาสตร์',
                    subTite: 'Set recommendation based on location',
                    trailing: Switch(
                      value: controller.geographicLocation.value,
                      onChanged: (value) => controller.toggleGeographicLocation(),
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'โหมดปลอดภัย',
                    subTite: 'Search result is safe for all ages',
                    trailing: Switch(
                      value: controller.safeMode.value,
                      onChanged: (value) => controller.toggleSafeMode(),
                    ),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'คุณภาพของภาพระดับ HD',
                    subTite: 'Set image quality to be seen',
                    trailing: Switch(
                      value: controller.hdImageQuality.value,
                      onChanged: (value) => controller.toggleHDImageQuality(),
                    ),
                  ),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        // เมื่อเสร็จสิ้นการออกจากระบบ แสดง Dialog แจ้งเตือน
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Logout Successfully"),
                              content: Text("You have been logged out successfully."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // เมื่อผู้ใช้คลิกปุ่ม "OK" บน Dialog ทำการเปลี่ยนหน้าไปยังหน้าล็อกอินหรือหน้าหลักของแอปพลิเคชัน
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (c) => LoginScreen(),
                                      ),
                                      (r) => false,
                                    );
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Logout'),
                    ),
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

