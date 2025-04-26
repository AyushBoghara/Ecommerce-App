import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/general_bindings.dart';
import 'package:onboarding/routes/app_routes.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/theme.dart';
import 'package:onboarding/ad_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdManager()); // Initialize Ad Manager

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
