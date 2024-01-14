import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/icons/t_circular_icon.dart';
import 'package:APPE/common/widgets/images/t_rounded_image.dart';
import 'package:APPE/common/widgets/texts/product_price_text.dart';
import 'package:APPE/common/widgets/texts/product_title_text.dart';
import 'package:APPE/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:APPE/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:APPE/features/shop/screens/checkout/checkout.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:APPE/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),

        /// -- Items in Cart
        child: TCartItems(),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: Text('สั่งซื้อ'),
        ),
      ),
    );
  }
}
