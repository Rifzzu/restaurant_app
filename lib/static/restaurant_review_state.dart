import 'package:restaurant_app/data/model/restaurant_detail_response.dart';

sealed class RestaurantReviewState {}

class RestaurantReviewNoneState extends RestaurantReviewState {}

class RestaurantReviewLoadingState extends RestaurantReviewState {}

class RestaurantReviewErrorState extends RestaurantReviewState {
  final String error;
  RestaurantReviewErrorState(this.error);
}

class RestaurantReviewLoadedState extends RestaurantReviewState {
  final List<CustomerReview> customerReview;
  RestaurantReviewLoadedState(this.customerReview);
}
