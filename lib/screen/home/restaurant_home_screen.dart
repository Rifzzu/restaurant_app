import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/component/message_widget.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_state.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Recommendation restaurant for you!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: restaurantList(value, context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget restaurantList(RestaurantListProvider value, BuildContext context) {
    return switch (value.resultState) {
      RestaurantListLoadingState() => const Center(
          child: CircularProgressIndicator(),
        ),
      RestaurantListLoadedState(restaurants: var restaurantList) =>
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurantList.length,
          itemBuilder: (context, index) {
            final restaurant = restaurantList[index];
            return RestaurantCard(
              restaurant: restaurant,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NavigationRoute.detailRoute.name,
                  arguments: restaurant.id,
                );
              },
            );
          },
        ),
      RestaurantListErrorState() => const Center(
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
  }
}
