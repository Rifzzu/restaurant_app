import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/component/message_widget.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class RestaurantFavoriteScreen extends StatefulWidget {
  const RestaurantFavoriteScreen({super.key});

  @override
  State<RestaurantFavoriteScreen> createState() => _FavoriteFavoriteScreenState();
}

class _FavoriteFavoriteScreenState extends State<RestaurantFavoriteScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurantValue();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final favoriteList = value.restaurantList ?? [];
          return switch (favoriteList.isNotEmpty) {
            true => ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final restaurant = favoriteList[index];

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
            _ => const MessageWidget(
                title: "No favorite yet",
                subtitle: "Tap favorite icon to your library"
            )
          };
        },
      ),

    );
  }
}