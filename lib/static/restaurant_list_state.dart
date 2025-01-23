import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantListState {}

class RestaurantListNoneState extends RestaurantListState {}

class RestaurantListLoadingState extends RestaurantListState {}

class RestaurantListErrorState extends RestaurantListState {
  final String error;
  RestaurantListErrorState(this.error);
}

class RestaurantListLoadedState extends RestaurantListState {
  final List<Restaurant> restaurants;
  RestaurantListLoadedState(this.restaurants);
}
