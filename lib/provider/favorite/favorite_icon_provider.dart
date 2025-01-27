import 'package:flutter/widgets.dart';

class FavoriteIconProvider extends ChangeNotifier {
  bool _isFavorited = false;

  bool get isFavorited {
    return _isFavorited;
  }

  set isFavorited(bool value) {
    _isFavorited = value;
    notifyListeners();
  }
}