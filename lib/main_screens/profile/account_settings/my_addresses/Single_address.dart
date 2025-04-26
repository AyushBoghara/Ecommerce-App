import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_model.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/edit_address_screen.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress
              ? TColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? TColors.darkerGrey
                  : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems / 2),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Address Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '(${address.phoneNumber})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: TSizes.sm / 2),
                      Text(
                        '${address.street}, ${address.city}, ${address.state}, ${address.country}, ${address.postalCode}',
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                /// Action Buttons (Edit and Delete)
                Column(
                  children: [
                    // Edit Button
                    IconButton(
                      icon: Icon(Iconsax.edit, color: TColors.primary),
                      onPressed: () {
                        Get.to(() => EditAddressScreen(address: address));
                      },
                    ),
                    const SizedBox(height: 4),

                    // Delete Button with Confirmation Dialog
                IconButton(
  icon: const Icon(Iconsax.trash, color: Colors.red),
  onPressed: () {
    // Show confirmation dialog
    Get.defaultDialog(
      title: "Delete Address",
      middleText: "Are you sure you want to delete this address?",
      contentPadding: const EdgeInsets.all(20), // Add padding to the dialog container
      confirm: TextButton(
        onPressed: () async {
          try {
            // Call the delete method from the controller
            await controller.deleteAddress(address.id);
            print("Address deleted, closing dialog"); // Debugging
            Get.back(); // Close the dialog
            Get.snackbar("Success", "Address deleted successfully");
          } catch (e) {
            print("Error deleting address: $e"); // Debugging
            Get.back(); // Close the dialog
            Get.snackbar("Error", "Failed to delete address: $e");
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.red, // Red background
          foregroundColor: Colors.white, // White text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Slightly rounded edges
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Button padding
        ),
        child: const Text("Delete"),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey[300], // Light grey background
          foregroundColor: Colors.black, // Black text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Slightly rounded edges
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Button padding
        ),
        child: const Text("Cancel"),
      ),
    );
  },
),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
