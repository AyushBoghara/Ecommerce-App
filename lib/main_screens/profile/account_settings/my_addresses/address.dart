import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/Add_new_address.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/Single_address.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
        onClickEvent: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () {
              return FutureBuilder(
                key: Key(controller.refreshDate.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  final response =
                      TCloudHelperFunctions.checkMultipleRecordState(
                          snapshot: snapshot);
                  if (response != null) return response;
                  final addresses = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (_, index) => TSingleAddress(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
