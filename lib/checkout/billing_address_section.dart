import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(
              title: 'Shipping Address',
              buttonTitle: 'Change',
              onPressed: () => addressController.selectNewAddressPopup(context),
            ),
            addressController.selectedAddress.value.id.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addressController.selectedAddress.value.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Icon(Icons.phone,
                              color: Colors.grey, size: 16),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text(
                            addressController.selectedAddress.value.phoneNumber,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.grey, size: 16),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: Text(
                              '${addressController.selectedAddress.value.street}, '
                              '${addressController.selectedAddress.value.city}, '
                              '${addressController.selectedAddress.value.state}, '
                              '${addressController.selectedAddress.value.postalCode}, '
                              '${addressController.selectedAddress.value.country}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Text(
                    "Select Address",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ],
        ));
  }
}
