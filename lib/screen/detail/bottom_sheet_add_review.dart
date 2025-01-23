import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_review_state.dart';

class BottomSheetAddReview extends StatefulWidget {
  const BottomSheetAddReview({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  State<BottomSheetAddReview> createState() => _BottomSheetAddReviewState();
}

class _BottomSheetAddReviewState extends State<BottomSheetAddReview> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  void _onType() {
    final nameText = _nameController.text;
    final reviewText = _reviewController.text;

    if (nameText.isNotEmpty && reviewText.isNotEmpty) {
      context
          .read<RestaurantDetailProvider>()
          .addReview(widget.restaurantId, nameText, reviewText);
      Future.microtask(() {
        context
            .read<RestaurantDetailProvider>()
            .fetchRestaurantDetail(widget.restaurantId);
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Successfully added a review!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_onType);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Add your review here...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: _reviewController,
                          decoration: const InputDecoration(
                            labelText: 'Review',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please enter your review';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    FormState? form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      _onType();
                    }
                  },
                  child: Text(
                    'Add Review',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget addReview(RestaurantReviewState state) {
    return switch (state) {
      RestaurantReviewLoadingState() => const Center(
          child: CircularProgressIndicator(),
        ),
      RestaurantReviewLoadedState() => const Center(),
      RestaurantReviewErrorState(error: var message) => Center(
          child: Text(message),
        ),
      _ => const SizedBox(),
    };
  }
}
