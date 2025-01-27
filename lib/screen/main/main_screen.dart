import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/favorite/restaurant_favorite_screen.dart';
import 'package:restaurant_app/screen/home/restaurant_home_screen.dart';
import 'package:restaurant_app/screen/search/restaurant_search_screen.dart';
import 'package:restaurant_app/screen/setting/restaurant_setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            1 => const RestaurantSearchScreen(),
            2 => const RestaurantFavoriteScreen(),
            3 => const RestaurantSettingScreen(),
            _ => const RestaurantHomeScreen(),
          };
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
          onTap: (index) {
            context.read<IndexNavProvider>().setIndexBottomNavBar = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              tooltip: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
              tooltip: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              tooltip: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
