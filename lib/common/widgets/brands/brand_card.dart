import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../controllers/api.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/t_circular_image.dart';
import '../texts/t_brand_title_text_with_verified_icon.dart';

class TBrandCard extends StatelessWidget {
  final bool showBorder;
  final void Function()? onTap;
  final String typeName;

  TBrandCard({
    Key? key,
    required this.showBorder,
    this.onTap,
    required this.typeName, // เพิ่มพารามิเตอร์ typeName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return FutureBuilder<List<dynamic>>(
      future: fetchTypes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final types = snapshot.data;

          return GestureDetector(
            onTap: onTap,
            child: TRoundedContainer(
              showBorder: showBorder,
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(TSizes.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image
                  Flexible(
                    child: TCircularImage(
                      isNetworkImage: true,
                      image:
                          "http://192.168.77.14/flutter_data/icons_type/1689137.png", // รูปภาพจาก URL
                      backgroundColor: Colors.transparent,
                      overlayColor: isDark ? TColors.white : TColors.black,
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),

                  // Text
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display type name from snapshot data
                        TBrandTitleWithVerifiendIcon(
                          title:
                              typeName, // ใช้ชื่อประเภทที่ได้รับมาจากพารามิเตอร์
                          brandTextSizes: TextSizes.large,
                        ),
                        Text(
                          '23 products', // จำนวนสินค้า (ตัวอย่างเท่านี้)
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
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
