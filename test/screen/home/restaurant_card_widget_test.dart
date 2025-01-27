import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';

void main() {
  late Restaurant testRestaurant;

  setUp(() {
    testRestaurant = const Restaurant(
      id: "1",
      name: "Test Restaurant",
      description: "Test description",
      pictureId: "test_picture",
      city: "Test City",
      rating: 4.5,
    );
  });

  testWidgets('Displays restaurant card details correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RestaurantCard(
            restaurant: testRestaurant,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Test Restaurant'), findsOneWidget);
    expect(find.text('Test City'), findsOneWidget);
  });

  testWidgets('onTap on RestaurantCard', (WidgetTester tester) async {
    var wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RestaurantCard(
            restaurant: testRestaurant,
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    // Find the InkWell by its unique Key
    final restaurantCardFinder = find.byKey(Key('restaurant_card_${testRestaurant.id}'));

    // Tap the specific InkWell
    await tester.tap(restaurantCardFinder);
    await tester.pumpAndSettle();

    // Verify the onTap callback was called
    expect(wasTapped, isTrue);
  });
}
