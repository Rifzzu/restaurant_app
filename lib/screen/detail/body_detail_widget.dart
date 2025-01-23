import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/screen/detail/bottom_sheet_add_review.dart';
import 'package:restaurant_app/screen/detail/card_menu.dart';
import 'package:restaurant_app/screen/detail/card_review_widget.dart';

class BodyDetailWidget extends StatelessWidget {
  const BodyDetailWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final heightImage = MediaQuery.of(context).size.height * 0.4;
    final widthImage = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                    fit: BoxFit.cover,
                    height: heightImage,
                    width: widthImage,
                    errorBuilder: (_, __, ___) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 34,
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(restaurant.city,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium),
                        Text(restaurant.address,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Category :',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.categories.map((category) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            category.name,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Description :',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Foods :',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.menus.foods.map((food) {
                      return CardMenu(
                        name: food.name,
                        id: 'assets/images/pexels-ella-olsson-572949-1640772.jpg',
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Drinks :',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.menus.drinks.map((drink) {
                      return CardMenu(
                        name: drink.name,
                        id: 'assets/images/pexels-isabella-mendes-107313-338713.jpg',
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rating & Reviews :',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RatingStars(
                        value: restaurant.rating,
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return BottomSheetAddReview(
                            restaurantId: restaurant.id,
                          );
                        },
                      );
                    },
                    child: Text(
                      'Add Reviews',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                CardReviewWidget(restaurant: restaurant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
