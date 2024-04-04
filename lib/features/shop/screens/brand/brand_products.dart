import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/brands/brand_card.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {

  BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Type')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              TBrandCard(showBorder: true, typeName: '',),
              SizedBox(height: TSizes.spaceBtwSections),
              TSortableProducts(userData: [],),
            ],
          ),
        ),
      ),
    );
  }
}
