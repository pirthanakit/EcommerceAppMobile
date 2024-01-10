import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/custom_shapes/curved_edges/cerved_edges_widget.dart';
import 'package:APPE/common/widgets/icons/t_circular_icon.dart';
import 'package:APPE/common/widgets/images/t_rounded_image.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:APPE/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:APPE/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:APPE/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:APPE/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:APPE/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:APPE/utils/constants/colors.dart';
import 'package:APPE/utils/constants/image_strings.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:APPE/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            TProductlmageSlider(),

            /// 2 - Product Image Slider
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// - Rating & Share Button
                  TRatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  TProductMetaData(),

                  /// -- Attributes
                  TProductAttributes(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// -- Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Checkout'))),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// - Description
                  const TSectionHeading(
                      title: 'รายละเอียดสินค้า', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSectionHeading(
                    title: 'Reviews(199)',
                    showActionButton: false,
                  ),
                  IconButton(
                      icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
