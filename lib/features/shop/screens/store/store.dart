import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/appbar/tabbar.dart';
import 'package:APPE/common/widgets/brands/brand_show_case.dart';
import 'package:APPE/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:APPE/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:APPE/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:APPE/features/shop/screens/brand/all_brands.dart';
import 'package:APPE/features/shop/screens/store/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../controllers/api.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreScreen extends StatelessWidget {
  StoreScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
              iconColor: const Color.fromARGB(255, 0, 0, 0), userData: [],
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // --- Search Bar
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const TSearchContainer(
                        text: 'Search In Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // --- Featured Brands
                      TSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () => Get.to(() => AllBrandsScreen())),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),

                      FutureBuilder<List<String>>(
                        future: fetchTypes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<String> typeNames = snapshot.data!;
                            return TGridLayout(
                              itemCount: typeNames.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                return TBrandCard(
                                  showBorder: false,
                                  typeName: typeNames[index],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: [
                    Tab(child: Text('All')),
                    Tab(child: Text('CPU')),
                    Tab(child: Text('RAM')),
                    Tab(child: Text('Notebook')),
                    Tab(child: Text('HDD')),
                    Tab(child: Text('Power Supply')),
                    Tab(child: Text('Monitor')),
                    Tab(child: Text('Mainboard')),
                    Tab(child: Text('Graphic Card')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TCategorTab(typeId: 0, userData: [],), // All
              TCategorTab(typeId: 1, userData: [],), // CPU
              TCategorTab(typeId: 2, userData: [],), // RAM
              TCategorTab(typeId: 3, userData: [],), // Notebook
              TCategorTab(typeId: 4, userData: [],), // HDD
              TCategorTab(typeId: 5, userData: [],), // Power Supply
              TCategorTab(typeId: 6, userData: [],), // Monitor
              TCategorTab(typeId: 7, userData: [],), // Mainboard
              TCategorTab(typeId: 8, userData: [],), // Graphic Card
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
