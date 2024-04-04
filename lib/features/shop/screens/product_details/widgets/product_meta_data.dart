import 'package:flutter/material.dart';
import 'package:APPE/common/widgets/images/t_circular_image.dart';
import 'package:APPE/common/widgets/texts/product_price_text.dart';
import 'package:APPE/common/widgets/texts/product_title_text.dart';
import 'package:APPE/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:APPE/utils/constants/enums.dart';
import 'package:APPE/utils/constants/image_strings.dart';
import 'package:APPE/utils/helpers/helper_functions.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:APPE/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class TProductMetaData extends StatelessWidget {
  final String price;
  const TProductMetaData({
    Key? key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var devices;
    
    final double originalPrice = double.parse(price);
    final double increasedPrice = originalPrice * 1.25; // เพิ่มราคา 25%
    final String formattedIncreasedPrice = increasedPrice.toStringAsFixed(2); // รูปแบบราคาเพิ่มขึ้นให้มีทศนิยม 2 ตำแหน่ง
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Price
            Text('\฿$formattedIncreasedPrice',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(price: price, isLarge: true), // แสดงราคาที่เพิ่มขึ้น 25%
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        // const TProductTitleText(title: 'RAM'),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'สถานะ :'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('มีสินค้า', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Brand
        // Row(
        //   children: [
        //     TCircularImage(
        //       image: TImages.computer,
        //       width: 32,
        //       height: 32,
        //       overlayColor: darkMode ? TColors.white : TColors.black,
        //     ),
        //     const TBrandTitleWithVerifiendIcon(
        //         title: 'RAM', brandTextSizes: TextSizes.medium),
        //   ],
        // ),
      ],
    );
  }
}
