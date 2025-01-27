import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/component/message_widget.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_icon_provider.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_state.dart';
import 'body_detail_widget.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Detail'),
        actions: [
          ChangeNotifierProvider(
            create: (context) => FavoriteIconProvider(),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadedState(restaurant: var restaurant) =>
                      FavoriteIconWidget(
                          restaurant: Restaurant(
                            id: restaurant.id,
                            name: restaurant.name,
                            description: restaurant.description,
                            pictureId: restaurant.pictureId,
                            city: restaurant.city,
                            rating: restaurant.rating,
                          ),
                      ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(restaurant: var restaurant) =>
              BodyDetailWidget(restaurant: restaurant),
            RestaurantDetailErrorState() => const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MessageWidget(
                  title: 'Oops, something went wrong!',
                  subtitle: 'Unable to load data, please check your internet connection',
                ),
              ),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
