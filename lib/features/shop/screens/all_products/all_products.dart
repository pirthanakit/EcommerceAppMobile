import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';

class AllProducts extends StatelessWidget {
  final List<dynamic> userData;
  AllProducts({
    super.key, required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:
           TAppBar(title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: TSortableProducts(userData: [],),
        ),
      ),
    );
  }
}
