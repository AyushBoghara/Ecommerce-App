import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:onboarding/checkout/checkout.dart';
import 'package:onboarding/main_screens/home/cart/cart_controller.dart';
import 'package:onboarding/main_screens/home/home.dart';
import 'package:onboarding/main_screens/home/navigation_menu.dart';
import 'package:onboarding/beginning/log/login.dart';
import 'package:onboarding/beginning/onboarding/onBoarding.dart';
import 'package:onboarding/beginning/register_user/signup.dart';
import 'package:onboarding/myApp.dart';
import 'package:onboarding/repositories/authentication_repository.dart';
import 'package:onboarding/utils/constants/colors.dart';
import 'package:onboarding/utils/constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'main_screens/store/brands/brand_Repository.dart';
import 'main_screens/store/brands/brand_controller.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
 
  MobileAds.instance.initialize();
  runApp(const MyApp());
}
