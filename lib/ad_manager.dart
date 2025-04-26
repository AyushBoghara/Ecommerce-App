import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onboarding/beginning/user_controller.dart';

class AdManager extends GetxController {
  InterstitialAd? _interstitialAd;
  Timer? _adTimer;
  final UserController userController = Get.put(UserController()); // Get UserController instance

  @override
  void onInit() {
    super.onInit();
    _checkAndStartAds();
    ever(userController.user, (_) => _checkAndStartAds()); // React to user login changes
  }

  /// Check if ads should start based on login status
  void _checkAndStartAds() {
    if (userController.user.value.id.isNotEmpty) {
      _loadAd();
      _scheduleFirstAd();
    } else {
      _cancelAdTimer();
    }
  }

  /// Load an Interstitial Ad
  void _loadAd() {
    print("🔄 Requesting Ad...");
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test Ad ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("✅ Ad Loaded Successfully");
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("❌ Ad Failed to Load: ${error.message}");
        },
      ),
    );
  }

  /// Schedule the first ad after 45 seconds
  void _scheduleFirstAd() {
    if (!_shouldShowAds()) return;

    print("⏳ First Ad Scheduled after 45 seconds...");
    _adTimer = Timer(Duration(seconds: 45), () {
      print("🚀 Trying to Show First Ad...");
      _showAd();
    });
  }

  /// Schedule recurring ads every 4 minutes
  void _scheduleRecurringAds() {
    if (!_shouldShowAds()) return;

    _adTimer = Timer.periodic(Duration(minutes: 4), (timer) {
      _showAd();
    });
  }

  /// Show the Interstitial Ad
  void _showAd() {
    if (!_shouldShowAds()) {
      print("⚠ Ad Blocked on Restricted Screens!");
      return;
    }

    if (_interstitialAd != null) {
      print("🎬 Showing Ad...");
      _interstitialAd!.show();
      _interstitialAd = null;
      _loadAd(); // Load the next ad
    } else {
      print("⚠ Ad Not Ready!");
    }
    _scheduleRecurringAds();
  }

  /// Cancel scheduled ads
  void _cancelAdTimer() {
    _adTimer?.cancel();
    _adTimer = null;
  }

  /// Prevent ads on login, onboarding, or signup screens
  bool _shouldShowAds() {
    String currentRoute = Get.currentRoute;
    List<String> restrictedRoutes = ['/login', '/signup', '/onboarding'];
    return userController.user.value.id.isNotEmpty && !restrictedRoutes.contains(currentRoute);
  }

  @override
  void onClose() {
    _cancelAdTimer();
    _interstitialAd?.dispose();
    super.onClose();
  }
}
