import 'package:APPE/features/personalizetion/screens/settings/settings.dart';
import 'package:APPE/features/shop/screens/home/home.dart';
import 'package:APPE/features/shop/screens/store/store.dart';
import 'package:APPE/features/shop/screens/wishlist/wishlist.dart';
import 'package:APPE/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  final List<dynamic> userData;

  NavigationMenu({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController(userData: userData)); // สร้าง NavigationController และส่ง userData ไปยัง constructor
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final List<dynamic> userData;

  NavigationController({required this.userData}) {
    // สร้าง instance ของ screens และส่ง userData ไปยังแต่ละหน้าจอ
    screens = [
      HomeScreen(userData: userData),
      StoreScreen(),
      FavouriteScreen(userData: userData),
      SettingsScreen(userData: userData),
    ];
  }

  late final List<Widget> screens; // ประกาศ List ของ Widget ซึ่งจะกำหนดค่าใน constructor
}
