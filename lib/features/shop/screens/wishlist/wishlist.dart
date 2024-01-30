import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/icons/t_circular_icon.dart';
import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/features/shop/screens/home/home.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          TGridLayout(
            itemCount: products.length,
            itemBuilder: (_, index) => TProductCardVertical(
              imageUrl: products[index]['imageUrl']!,
              title: products[index]['title']!,
              brand: products[index]['brand']!,
              price: products[index]['price']!,
            ),
          ),
        ]),
      )),
    );
  }
}
