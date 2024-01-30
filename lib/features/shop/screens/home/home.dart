import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header --
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // -- Appbar --
                  THomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // -- Searchbar --
                  TSearchContainer(
                    text: 'Search in Store',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // -- Categories --
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // -- Heading --
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // -- Categories --
                        THomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // -- Body --
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // ----- Promo Slider ------
                  const TPromoSlider(banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3,
                  ]),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // ----- Heading
                  TSectionHeading(
                      title: 'Popular Categories',
                      onPressed: () => Get.to(() => const AllProducts())),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // ----- Popular Product ------
                  TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => TProductCardVertical(
                      imageUrl: products[index]['imageUrl']!,
                      title: products[index]['title']!,
                      brand: products[index]['brand']!,
                      price: products[index]['price']!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// สร้าง list ของข้อมูลสินค้า
List<Map<String, String>> products = [
  {
    'imageUrl': TImages.productImage47,
    'title': 'Notebook Gameming',
    'brand': 'Acer',
    'price': '19,900',
  },
  {
    'imageUrl': TImages.productImage48,
    'title': 'New Laptop 1',
    'brand': 'Brand XYZ',
    'price': '25,000',
  },
  {
    'imageUrl': TImages.productImage49,
    'title': 'New Laptop 2',
    'brand': 'Brand ABC',
    'price': '30,000',
  },
  {
    'imageUrl': TImages.productImage50,
    'title': 'New Laptop 3',
    'brand': 'Brand DEF',
    'price': '22,500',
  },
];
