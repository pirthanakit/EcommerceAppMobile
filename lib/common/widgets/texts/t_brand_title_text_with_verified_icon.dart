import 'package:APPE/common/widgets/texts/t_brand_title_text.dart';
import 'package:APPE/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TBrandTitleWithVerifiendIcon extends StatelessWidget {
  const TBrandTitleWithVerifiendIcon({
    super.key,
    this.textColor,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
    this.iconColor = TColors.primary,
  });

  final Color? textColor, iconColor;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSizes: brandTextSizes,
          ),
        ),
        const SizedBox(width: TSizes.xs,),
        Icon(Iconsax.verify5, color: iconColor, size: TSizes.iconXs,),
      ],
    );
  }
}
