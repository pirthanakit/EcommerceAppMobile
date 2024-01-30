import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class TCategorTab extends StatelessWidget {
  const TCategorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              const TBrandShowcase(images: [
                TImages.productImage3,
                TImages.productImage2,
                TImages.productImage1
              ]),
              const TBrandShowcase(images: [
                TImages.productImage3,
                TImages.productImage2,
                TImages.productImage1
              ]),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Products
              TSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(
                itemCount: products.length,
                itemBuilder: (_, index) => TProductCardVertical(
                  imageUrl: products[index]['imageUrl']!,
                  title: products[index]['title']!,
                  brand: products[index]['brand']!,
                  price: products[index]['price']!,
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
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
