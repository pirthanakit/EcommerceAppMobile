import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      reting: 3.5,
      itemSize: 20,
      unratedColor: TColors.grey,
      itemBuildet: (_, __) => Icon(Iconsax.star, color: TColors.primary),
    );
  }
}
