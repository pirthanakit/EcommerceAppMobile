import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../sub_category/sub_categories.dart';

class THomeCategories extends StatelessWidget {

  const THomeCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return TVerticalImagesText(
            image: category['image']!,
            title: category['title']!,
            onTap: () => Get.to(() => SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}

List<Map<String, String>> categories = [
  {'image': TImages.acerlogo, 'title': 'ACER'},
  {'image': TImages.asuslogo, 'title': 'ASUS'},
  // เพิ่มหมวดหมู่เพิ่มเติมตามต้องการ
];