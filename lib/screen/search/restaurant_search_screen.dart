import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/search/search_widget.dart';
import 'package:restaurant_app/static/restaurant_search_state.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/component/message_widget.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({super.key});

  @override
  State<RestaurantSearchScreen> createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantSearchProvider>().searchRestaurant('');
    });
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      context.read<RestaurantSearchProvider>().searchRestaurant(query);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Search(controller: _searchController),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Consumer<RestaurantSearchProvider>(
                    builder: (context, value, child) {
                      final state = value.resultState;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Results for your search!',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: searchRestaurant(state),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchRestaurant(RestaurantSearchState state) {
    return switch (state) {
      RestaurantSearchLoadingState() => const Center(
          child: CircularProgressIndicator(),
        ),
      RestaurantSearchLoadedState(
        data: var restaurantList,
      ) =>
        restaurantList.isNotEmpty
            ? ListView.builder(
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
              )
            : const MessageWidget(
                title: 'Restaurant not found!',
                subtitle: 'Try another keyword',
              ),
      RestaurantSearchErrorState() => const Center(
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
