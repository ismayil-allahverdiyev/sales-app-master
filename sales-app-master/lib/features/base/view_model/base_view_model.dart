import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier{

  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    _pageController.jumpToPage(value);
    print(value.toDouble());
    notifyListeners();
  }

  PageController get pageController => _pageController;

}