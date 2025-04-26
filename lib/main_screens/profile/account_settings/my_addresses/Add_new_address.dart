import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address_controller.dart';
import 'package:onboarding/utils/constants/sizes.dart';
import 'package:onboarding/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('Add New Address'),
        onClickEvent: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                /// Name Field
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      TValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Phone Number Field (Number Keyboard Only)
                TextFormField(
                  controller: controller.phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      TValidator.validateEmptyText('Phone Number', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// Street Address (Separate Row)
                TextFormField(
                  controller: controller.street,
                  validator: (value) =>
                      TValidator.validateEmptyText('Street', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_31),
                    labelText: 'Street',
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// City & Postal Code (Side by Side)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            TValidator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            TValidator.validateEmptyText('Postal Code', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                /// State & Country (Side by Side)
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            TValidator.validateEmptyText('State', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.country,
                        validator: (value) =>
                            TValidator.validateEmptyText('Country', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.global),
                          labelText: 'Country',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.defaultSpace),

                /// Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
