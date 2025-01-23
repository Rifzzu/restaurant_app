import 'package:restaurant_app/data/model/restaurant_detail_response.dart';

sealed class RestaurantDetailState {}

class RestaurantDetailNoneState extends RestaurantDetailState {}

class RestaurantDetailLoadingState extends RestaurantDetailState {}

class RestaurantDetailErrorState extends RestaurantDetailState {
  final String error;
  RestaurantDetailErrorState(this.error);
}

class RestaurantDetailLoadedState extends RestaurantDetailState {
  final Restaurant restaurant;
  RestaurantDetailLoadedState(this.restaurant);
}
