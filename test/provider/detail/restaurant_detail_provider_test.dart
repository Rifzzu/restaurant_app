import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_state.dart';
import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main(){
  late MockApiServices mockApiService;
  late RestaurantDetailProvider provider;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestaurantDetailProvider(mockApiService);
  });

  group('Test RestaurantDetailProvider', () {
    test('Initialization provider', () {
      expect(provider.resultState, isA<RestaurantDetailNoneState>());
    });

    test('Return detail of restaurants when response is successful', () async {
      final mockResponse = RestaurantDetailResponse(
          error: false,
          message: "success",
          restaurant: Restaurant(
              id: "rqdv5juczeskfw1e867",
              name: "Melting Pot",
              description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit...",
              pictureId: "14",
              city: "Medan",
              rating: 4.2,
              address: "Jln. Pandeglang no 19",
              categories: [],
              menus: Menus(foods: [], drinks: []),
              customerReviews: []
          )
      );

      when(mockApiService.getRestaurantDetail("rqdv5juczeskfw1e867"))
          .thenAnswer((_) async => mockResponse);

      await provider.fetchRestaurantDetail("rqdv5juczeskfw1e867");
      expect(provider.resultState, isA<RestaurantDetailLoadedState>());

      final state = provider.resultState as RestaurantDetailLoadedState;
      expect(state.restaurant.id, mockResponse.restaurant.id);
    });

    test('Return message when response is unsuccessful', () async {
      when(mockApiService.getRestaurantDetail("rqdv5juczeskfw1e867"))
          .thenThrow(Exception("Failed to load detail restaurants"));

      await provider.fetchRestaurantDetail("rqdv5juczeskfw1e867");
      expect(provider.resultState, isA<RestaurantDetailErrorState>());
      final state = provider.resultState as RestaurantDetailErrorState;
      expect(state.error, contains("Failed to load detail restaurants"));
    });
  });
}
