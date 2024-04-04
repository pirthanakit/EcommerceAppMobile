import 'package:APPE/common/widgets/chips/choice_chip.dart';
import 'package:APPE/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:APPE/common/widgets/texts/product_price_text.dart';
import 'package:APPE/common/widgets/texts/product_title_text.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  final String price;
  final String amount;
  const TProductAttributes({super.key, required this.price, required this.amount});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final double originalPrice = double.parse(price);
    final double increasedPrice = originalPrice * 1.25; // เพิ่มราคา 25%
    final String formattedIncreasedPrice = increasedPrice
        .toStringAsFixed(2); // รูปแบบราคาเพิ่มขึ้นให้มีทศนิยม 2 ตำแหน่ง
    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              /// Title, Price and Stock Staus
              Row(
                children: [
                  TSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'ราคา: ', smallSize: true),

                          /// Actual Price
                          Text(
                            '\฿$formattedIncreasedPrice',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          TProductPriceText(price: price),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'คลังสินค้า: ', smallSize: true),
                          Text(amount,
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// Variation Description
              // TProductTitleText(
              //   title: '',
              //   smallSize: true,
              //   maxLines: 4,
              // ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Attributes
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const TSectionHeading(title: 'สี', showActionButton: false),
        //     const SizedBox(height: TSizes.spaceBtwItems / 2),
        //     Wrap(
        //       spacing: 2,
        //       children: [
        //         TChoiceChip(
        //             text: 'Blcak', selected: false, onSelected: (value) {}),
        //         TChoiceChip(
        //             text: 'While', selected: false, onSelected: (value) {}),
        //       ],
        //     )
        //   ],
        // ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const TSectionHeading(title: 'ขนาด'),
        //     const SizedBox(height: TSizes.spaceBtwItems / 2),
        //     Wrap(
        //       spacing: 3,
        //       children: [
        //         TChoiceChip(
        //             text: '8GB', selected: true, onSelected: (value) {}),
        //         TChoiceChip(
        //             text: '16GB(2)', selected: false, onSelected: (value) {}),
        //         TChoiceChip(
        //             text: '32GB(4)', selected: false, onSelected: (value) {}),
        //       ],
        //     )
        //   ],
        // ),
      ],
    );
  }
}
