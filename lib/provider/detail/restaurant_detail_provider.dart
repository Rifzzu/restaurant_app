import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_state.dart';
import 'package:restaurant_app/static/restaurant_review_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiService;

  RestaurantDetailProvider(this._apiService);

  RestaurantDetailState _resultState = RestaurantDetailNoneState();
  RestaurantDetailState get resultState {
    return _resultState;
  }

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantDetail(restaurantId);
      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }

  RestaurantReviewState _reviewState = RestaurantReviewNoneState();
  RestaurantReviewState get reviewState {
    return _reviewState;
  }

  Future<dynamic> addReview(
    String id,
    String name,
    String reviewText,
  ) async {
    try {
      _reviewState = RestaurantReviewLoadingState();
      notifyListeners();

      final addReviewResult = await _apiService.addReviewRestaurant(
        id: id,
        name: name,
        reviewText: reviewText,
      );
      if (addReviewResult.error) {
        _reviewState = RestaurantReviewErrorState(addReviewResult.message);
        notifyListeners();
      } else {
        _reviewState =
            RestaurantReviewLoadedState(addReviewResult.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
