import 'package:get/get.dart';
import 'package:onboarding/beginning/log/forget_password.dart';
import 'package:onboarding/beginning/log/login.dart';
import 'package:onboarding/beginning/log/login_controller.dart';
import 'package:onboarding/beginning/log/verify_email.dart';
import 'package:onboarding/beginning/onboarding/onBoarding.dart';
import 'package:onboarding/beginning/register_user/signup.dart';
import 'package:onboarding/checkout/checkout.dart';
import 'package:onboarding/main_screens/home/cart/Cart.dart';
import 'package:onboarding/main_screens/home/home.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_addresses/address.dart';
import 'package:onboarding/main_screens/profile/account_settings/my_orders/Order.dart';
import 'package:onboarding/main_screens/profile/setting.dart';
import 'package:onboarding/main_screens/profile/user_info/Profile.dart';
import 'package:onboarding/main_screens/store/wishlist/wishlist.dart';
import 'package:onboarding/routes/routes.dart';

import '../reviewAndRating/product_reviews.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),

    GetPage(name: TRoutes.settings, page: ()=> const SettingsScreen()),
    GetPage(name: TRoutes.productReview, page: ()=> const ProductReviewsScreen()),
    GetPage(name: TRoutes.order, page: ()=> const OrderScreen()),
    GetPage(name: TRoutes.checkOut, page: ()=> const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: ()=> const CartScreen()),
    GetPage(name: TRoutes.userAddress, page: ()=> const UserAddressScreen()),
    GetPage(name: TRoutes.userProfile, page: ()=> const ProfileScreen()),
    GetPage(name: TRoutes.signIn, page: ()=> const LoginScreen()),

    GetPage(name: TRoutes.signup, page: ()=> const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: ()=> const VerifyEmailScreen()),
    GetPage(name: TRoutes.forgotPassword, page: ()=> const ForgetPassword()),
    GetPage(name: TRoutes.onBoarding, page: ()=> const OnBoarding()),




  ];
}
