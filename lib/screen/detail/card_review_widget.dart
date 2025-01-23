import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';

class CardReviewWidget extends StatelessWidget {
  const CardReviewWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: restaurant.customerReviews.length,
      itemBuilder: (context, index) {
        final review = restaurant.customerReviews[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(review.name),
                subtitle: Text(review.date),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(
                  review.review,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
