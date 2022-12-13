import 'package:flutter/cupertino.dart';
import '../../basket/view/basket_view.dart';
import '../../home/view/home_page.dart';
import '../../profile/view/profile_view.dart';
import '../../search/view/search_view.dart';

class PagesViewModel extends ChangeNotifier {
  int _index = 0;
  StatefulWidget _page = HomePageView();

  int get index => _index;

  set index(int value) {
    _index = value;
    if (_index == 0) {
      page = const HomePageView();
    }
    if (_index == 1) {
      page = const SearchView();
    }
    if (_index == 2) {
      page = const BasketView();
    }
    if (_index == 3) {
      page = const ProfileView();
    }
    print(index);
    notifyListeners();
  }

  StatefulWidget get page => _page;

  set page(StatefulWidget value) {
    _page = value;
  }
}
