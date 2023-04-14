import 'package:flutter/cupertino.dart';
import '../../basket/view/basket_view.dart';
import '../../home/view/home_page.dart';
import '../../profile/view/profile_view.dart';
import '../../search/view/search_view.dart';

class PagesViewModel extends ChangeNotifier {
  int _index = 0;
  Container _page = Container(child: HomePageView());

  int get index => _index;

  set index(int value) {
    _index = value;
    if (_index == 0) {
      page = Container(child: HomePageView());
    }
    if (_index == 1) {
      page = Container(child: SearchView());
    }
    if (_index == 2) {
      page = Container(child: BasketView());
    }
    if (_index == 3) {
      page = Container(child: ProfileView());
    }
    print(index);
    notifyListeners();
  }

  Container get page => _page;

  set page(Container value) {
    _page = value;
  }
}
