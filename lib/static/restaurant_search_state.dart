import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantSearchState {}

class RestaurantSearchNoneState extends RestaurantSearchState {}

class RestaurantSearchLoadingState extends RestaurantSearchState {}

class RestaurantSearchErrorState extends RestaurantSearchState {
  final String error;
  RestaurantSearchErrorState(this.error);
}

class RestaurantSearchLoadedState extends RestaurantSearchState {
  final List<Restaurant> data;
  RestaurantSearchLoadedState(this.data);
}
