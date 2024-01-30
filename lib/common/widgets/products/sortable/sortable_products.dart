import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: [
            'ชื่อสินค้า',
            'ราคาที่สูงขึ้น',
            'ราคาถูก',
            'ขาย',
            'มาใหม่',
            'ความนิยม'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products
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
