import 'package:restaurant_app/data/model/restaurant_detail_response.dart';

class RestaurantAddReviewResponse {
  RestaurantAddReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory RestaurantAddReviewResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantAddReviewResponse(
      error: json["error"],
      message: json["message"],
      customerReviews: List<CustomerReview>.from(
        json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
      ),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "message": message,
      "customerReviews":
      List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
  }
}
