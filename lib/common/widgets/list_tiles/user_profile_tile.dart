import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  final List<dynamic> userData;
  TUserProfileTile({
    Key?key,
    required this.onPressed,
    required this.userData,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const TCircularImage(
          image: TImages.user,
          width: 50,
          height: 50,
          padding: 0,
        ),
        title: Text(
          'Username: ${userData[0]['username']}',
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: TColors.white,
              ),
        ),
        subtitle: Text(
          'Email: ${userData[0]['email']}',
          style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: TColors.white,
              ),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          ),
        ));
  }
}
