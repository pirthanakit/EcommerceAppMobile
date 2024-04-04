import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../controllers/api.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final List<dynamic> userData;
  HomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> products = [];
  List<String> banners = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(API.apiproducts));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        products = responseData.cast<Map<String, dynamic>>();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load products'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> productIdToUserId = {};
    for (var userData in widget.userData) {
      String productId = userData['product_id'].toString();
      String userId = userData['user_id'].toString();
      productIdToUserId[productId] = userId;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header --
            TPrimaryHeaderContainer(
              userData: [],
              child: Column(
                children: [
                  // -- Appbar --
                  THomeAppBar(
                    userData: [],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // -- Searchbar --
                  TSearchContainer(
                    text: 'Search in Store',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // -- Categories --
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // -- Heading --
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // -- Categories --
                        THomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // -- Body --
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // ----- Promo Slider ------
                  TPromoSlider(
                    banners: [
                      'http://192.168.77.14/flutter_data/banners/469.jpg',
                      'http://192.168.77.14/flutter_data/banners/470_0.jpg',
                      'http://192.168.77.14/flutter_data/banners/471_0.jpg',
                      'http://192.168.77.14/flutter_data/banners/472_0.jpg',
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // ----- Heading
                  TSectionHeading(
                    title: 'Popular Categories',
                    onPressed: () => Get.to(() => AllProducts(
                          userData: [],
                        )),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // ----- Popular Product ------
                  if (products.isNotEmpty)
                    TGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        final product = products[index];
                        final productId = product['product_id'].toString();
                        final userId = productIdToUserId[productId] ?? '';

                        return TProductCardVertical(
                          imageUrl:
                              'http://192.168.77.14/flutter_data/${product['image']}',
                          title: product['product_name'],
                          brand: product['brand'],
                          price: product['price'].toString(),
                          productId: productId,
                          amount: product['amount'].toString(),
                          userId: userId,
                          userData: widget.userData, // ส่ง userData ไปยัง TProductCardVertical
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
