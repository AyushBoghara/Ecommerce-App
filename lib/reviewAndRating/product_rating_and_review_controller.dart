import 'package:get/get.dart';
import 'package:onboarding/loaders.dart';
import 'package:onboarding/reviewAndRating/product_rating_review_repository.dart';
import 'package:onboarding/reviewAndRating/review_model.dart';

class ProductRatingAndReviewController extends GetxController {
  static ProductRatingAndReviewController get instance => Get.find();
  RxBool isLoading = true.obs;
  final repository = Get.put(ProductRatingReviewRepository());
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;

  /// Fetch Product Reviews by Product ID
  Future<void> fetchReviews(String productId) async {
    try {
      final fetchedReviews = await repository.getProductReview(productId);
      reviews.assignAll(fetchedReviews); // Update observable list
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Add a New Review
  Future<void> addReview(String productId, ReviewModel review) async {
    try {
      await repository.addReview(productId, review);

      await fetchReviews(productId); // Refresh reviews after adding

      TLoaders.successSnackBar(
          title: 'Success', message: 'Review added successfully!');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
