import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/services/favourite_service.dart';
import 'package:sales_app/features/sign_page/services/auth_service.dart';
import 'package:sales_app/features/sign_page/view/sign_view.dart';
import '../../sign_page/view_model/user_info_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  FavouriteService favouriteService = FavouriteService();
  AuthService authService = AuthService();
  List<Product> favourites = [];

  bool _pageIsLoading = false;
  bool get pageIsLoading => this._pageIsLoading;
  set pageIsLoading(bool value) => this._pageIsLoading = value;

  bool _favsIsLoading = false;
  bool get favsIsLoading => this._favsIsLoading;
  set favsIsLoading(bool value) => this._favsIsLoading = value;

  TabController? _tabController;
  TabController get tabController => _tabController!;
  set tabController(TabController value) {
    _tabController = value;
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    _tabChange(_currentIndex);
    notifyListeners();
  }

  _tabChange(int index) {
    _tabController?.animateTo(index);
    notifyListeners();
  }

  gettingFavourites({required String token}) async {
    favsIsLoading = true;
    // if (isReloadable == true) {
    //   notifyListeners();
    // }
    List result = await favouriteService.getFavourites(token: token);
    print("Favs r " + result.toString());
    favourites.clear();
    result.forEach((element) {
      print("element " + element["id"].toString());
      Product product = Product.fromMap(element);
      print("element2 " + product.id.toString());
      favourites.add(product);
    });

    favsIsLoading = false;
    notifyListeners();
  }

  loadPage({required String token}) async {
    pageIsLoading = true;
    gettingFavourites(token: token);
    pageIsLoading = false;
  }

  signOut({required BuildContext context}) {
    Provider.of<UserInfoViewModel>(context, listen: false).signOut();
    print(Provider.of<UserInfoViewModel>(context, listen: false).toString());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignView()),
      (route) => false,
    );
  }
}
