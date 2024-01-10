import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:APPE/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:APPE/utils/constants/colors.dart';
import 'package:APPE/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/ratings/rating_indicator.dart';

import '../../../../utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Appbar
      appBar:
          const TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const Text(
                  "คะแนนและรีวิวได้รับการยืนยันแล้วและมาจากผู้ที่ใช้อุปกรณ์ ประเภทเดียวกับคุณ"),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Ratings
              const TOverallProductRating(),
              const RatingBarIndicator(rating: 3.5),
            ],
          ),
        ),
      ),
    );
  }
}
