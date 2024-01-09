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
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
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
                  const TSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'ราคา :', smallSize: true),

                          /// Actual Price
                          Text(
                            '\฿500',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          const TProductPriceText(price: '450'),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'คลังสินค้า :', smallSize: true),
                          Text('มีสินค้า',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// Variation Description
              TProductTitleText(
                title: '',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'สี', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 3,
              children: [
                TChoiceChip(
                    text: 'Green', selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Blue', selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Yellow', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'ขนาดจอ'),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 3,
              children: [
                TChoiceChip(
                    text: 'นิ้ว24', selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: 'นิ้ว27', selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: 'นิ้ว32', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
      ],
    );
  }
}
