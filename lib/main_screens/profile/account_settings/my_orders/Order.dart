import 'package:flutter/material.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_orders/Order_list.dart';
import 'package:onboarding/appbar/appbar.dart';
import 'package:onboarding/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /// --AppBor
      appBar: TAppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        ///-- Orders
        child: TOrderListItems(),
      ),
    );
  }
}
