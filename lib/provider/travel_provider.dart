import 'package:flutter/material.dart';

class TravelProvider extends ChangeNotifier {
  // Store liked status by destination title
  final Map<String, bool> _likedDestinations = {
    "Brazil": false,
    "Japan": false,
    "France": false,
  };

  bool isLiked(String title) => _likedDestinations[title] ?? false;

  void toggleLike(String title) {
    _likedDestinations[title] = !isLiked(title);
    notifyListeners();
  }
}
