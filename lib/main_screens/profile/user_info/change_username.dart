import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/beginning/user_controller.dart';
import 'package:onboarding/main_screens/profile/user_info/update_name_controller.dart';
import 'package:onboarding/main_screens/profile/user_info/update_user_name_controller.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/constants/text_strings.dart';
import 'package:onboarding/utils/validators/validation.dart';

class ChangeProfileName extends StatelessWidget {
  const ChangeProfileName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserNameController());
    final userController = UserController.instance;

    // Fetch user data and set it in the text fields
    if (userController.user.value.id.isNotEmpty) {
      controller.username.text = userController.user.value.username;
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Change UserName',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use your real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(children: [
                TextFormField(
                  controller: controller.username,
                  validator: (value) =>
                      TValidator.validateEmptyText('Username', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.userName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
              ]),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.updateUserNameFormKey.currentState!
                      .validate()) {
                    await controller.updateUserName(
                      controller.username.text.trim()
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
