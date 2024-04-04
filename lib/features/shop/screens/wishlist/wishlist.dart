import 'dart:convert';

import 'package:APPE/common/widgets/appbar/appbar.dart';
import 'package:APPE/common/widgets/icons/t_circular_icon.dart';
import 'package:APPE/common/widgets/layouts/grid_layout.dart';
import 'package:APPE/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:APPE/features/shop/screens/home/home.dart';
import 'package:APPE/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import '../../../../controllers/api.dart';

class FavouriteScreen extends StatefulWidget {
  final List<dynamic> userData;
  FavouriteScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<dynamic> products = [];

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
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add,
              onPressed: () => Get.to(HomeScreen(
                    userData: [],
                  ))),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
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
                    userId: userId, userData: widget.userData,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
