import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../controllers/api.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class TCategorTab extends StatefulWidget {
  final List<dynamic> userData;
  final int typeId;

  TCategorTab({Key? key, required this.typeId, required this.userData});

  @override
  _TCategorTabState createState() => _TCategorTabState();
}

class _TCategorTabState extends State<TCategorTab> {
  List<dynamic> products = [];
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
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              TBrandShowcase(
                images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1
                ],
              ),
              TBrandShowcase(
                images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Products
              TSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final product = products[index];
                  final userId = index < widget.userData.length
                      ? widget.userData[index]['user_id'].toString()
                      : '';
                  return TProductCardVertical(
                    imageUrl:
                        'http://192.168.77.14/flutter_data/${product['image']}',
                    title: product['product_name'],
                    brand: product['brand'],
                    price: product['price'].toString(),
                    productId: product['productId'].toString(),
                    amount: product['amount'].toString(),
                    userId: userId,
                    userData: widget.userData
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
