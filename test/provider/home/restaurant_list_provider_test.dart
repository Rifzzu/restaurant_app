import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_state.dart';
import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main(){
  late MockApiServices mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestaurantListProvider(mockApiService);
  });

  group('Test RestaurantListProvider', () {
    test('Initialization provider', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Return list of restaurants when response is successful', () async {
      final mockResponse = RestaurantListResponse(
        error: false,
        message: "success",
        count: 20,
        restaurants: [
          const Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
            pictureId: "14",
            city: "Medan",
            rating: 4.2,
          ),
        ],
      );

      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => mockResponse);
      await provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantListLoadedState>());
      final state = provider.resultState as RestaurantListLoadedState;
      expect(state.restaurants.length, mockResponse.restaurants.length);
    });

    test('Return message when response is unsuccessful', () async {
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception("Failed to load list restaurants"));

      await provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantListErrorState>());
      final state = provider.resultState as RestaurantListErrorState;
      expect(state.error, contains("Failed to load list restaurants"));
    });
  });
}