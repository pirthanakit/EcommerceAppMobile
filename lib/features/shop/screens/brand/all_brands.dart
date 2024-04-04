import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/brands/brand_card.dart';
import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/sortable/sortable_products.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:APPE/features/shop/screens/brand/brand_products.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../controllers/api.dart';

class AllBrandsScreen extends StatelessWidget {
  AllBrandsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Type'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              TSectionHeading(title: 'Type', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Brands
              FutureBuilder<List<String>>(
                future: fetchTypes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<String> typeNames = snapshot.data!;
                    return TGridLayout(
                      itemCount: typeNames.length,
                      mainAxisExtent: 80,
                      itemBuilder: (context, index) => TBrandCard(
                        showBorder: true,
                        onTap: () => Get.to(() => BrandProducts()),
                        typeName: typeNames[index],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> fetchTypes() async {
    final response = await http.get(Uri.parse(API.apitype));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<String> typeNames =
          responseData.map((type) => type['type_name'] as String).toList();
      return typeNames;
    } else {
      throw Exception('Failed to load types');
    }
  }
}
