import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/images_file.dart';
import 'package:onboarding/cmn_files/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    
    return Obx(() {
      final String networkImage = controller.user.value.profilePicture;
      final String image = networkImage.isNotEmpty ? networkImage : TImages.user;

      return ListTile(
        leading: TCircularImage(
          image: image,
          width: 50,
          height: 50,
          padding: 0,
          isNetworkImage: networkImage.isNotEmpty, // Pass true if it's a network image
        ),
        title: Text(
          controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: TColors.white),
        ),
        subtitle: Text(
          controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: TColors.white),
        ),
      );
    });
  }
}
