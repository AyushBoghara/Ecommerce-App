import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/cmn_files/rounded_container.dart';
import 'package:onboarding/cmn_files/section_heading.dart';
import 'package:onboarding/features/shop/controllers/product/checkout_controller.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/helpers/helper_functions.dart';

import '../../utils/constants/images_file.dart';
import '../../utils/constants/sizes.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        /// Payment Section Heading
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Selected Payment Method
        Obx(
          () => Row(
            children: [
              /// Payment Method Icon
              TRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? TColors.light : TColors.white,
                padding: const EdgeInsets.all(TSizes.sm),
                child: Image(
                  image: AssetImage(controller.selectedPaymentMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),

              /// Payment Method Name (Prevents Overflow)
              Expanded(
                child: Text(
                  controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2, // Limit to 2 lines
                  overflow: TextOverflow.ellipsis, // Show "..." if too long
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
