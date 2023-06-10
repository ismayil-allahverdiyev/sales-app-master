import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/core/constants/utils.dart';
import 'package:sales_app/features/basket/models/basket_product_model.dart';
import 'package:sales_app/features/basket/services/basket_service.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/services/favourite_service.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/profile/view_model/profile_view_model.dart';
import 'package:sales_app/features/sign_page/model/user.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

import '../model/comment_model.dart';
import '../services/comment_service.dart';

class ProductViewModel extends ChangeNotifier {
  CommentService commentService = CommentService();
  BasketService basketService = BasketService();
  PosterService posterService = PosterService();
  FavouriteService favouriteService = FavouriteService();
  TextEditingController commentController = TextEditingController();

  bool isFavouritedAtDispose = false;

  bool _checkingTheFavourites = false;
  bool get checkingTheFavourites => this._checkingTheFavourites;
  set checkingTheFavourites(bool value) => this._checkingTheFavourites = value;

  Product? currentProduct;
  Product? get getCurrentProduct => this.currentProduct;
  set setCurrentProduct(Product? currentProduct) =>
      this.currentProduct = currentProduct;

  bool productIsLoading = false;
  bool get getProductIsLoading => this.productIsLoading;
  set setProductIsLoading(bool productIsLoading) =>
      this.productIsLoading = productIsLoading;

  bool _inTheFavourites = false;
  bool get inTheFavourites => this._inTheFavourites;
  set inTheFavourites(bool value) => this._inTheFavourites = value;

  bool _inTheBasket = false;
  bool get inTheBasket => this._inTheBasket;
  set inTheBasket(bool value) => this._inTheBasket = value;

  bool _checkingTheBasket = false;
  bool get checkingTheBasket => this._checkingTheBasket;
  set checkingTheBasket(bool value) => this._checkingTheBasket = value;

  ScrollController? _controller;
  ScrollController? get controller => this._controller;
  set controller(ScrollController? value) => this._controller = value;

  bool _commentsLoading = false;
  bool get commentsLoading => this._commentsLoading;
  set commentsLoading(bool value) => this._commentsLoading = value;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  List<Comment> _commentList = [];
  List<Comment> get commentList => this._commentList;
  set commentList(List<Comment> value) => this._commentList = value;

  List<Image>? _imageWidgets;
  List<Image> get imageWidgets => _imageWidgets!;
  set imageWidgets(List<Image> value) {
    _imageWidgets = value;
  }

  List<Icon> _rateList = [];
  List<Icon> get rateList => _rateList;
  set rateList(List<Icon> value) {
    _rateList = value;
  }

  Future<void> getComments({required String posterId}) async {
    resetTheComments();
    print("size check " + commentList.length.toString());
    commentsLoading = true;
    List<dynamic> res = await commentService.getComments(posterId);
    for (int i = 0; i < res.length; i++) {
      print("COMMM  " + res[i].toString());
      Comment comment = Comment.fromMap(res[i]);
      print(comment);
      _commentList.add(comment);
    }
    print("size check " + commentList.length.toString());

    commentsLoading = false;
    notifyListeners();
  }

  void sendComment({
    required String description,
    required String posterId,
    required BuildContext context,
  }) async {
    User currentUser =
        Provider.of<UserInfoViewModel>(context, listen: false).user;
    await commentService.sendComment(
      description: description,
      token: currentUser.token,
      posterId: posterId,
      email: currentUser.email,
    );
    await getComments(posterId: posterId).then((value) {
      scrollDown();
    });
  }

  setImageWidgets(List value) {
    List<Image> listOfWidgets = [];
    var logicalScreenSize = window.physicalSize / window.devicePixelRatio;
    var width = logicalScreenSize.width;
    var height = logicalScreenSize.height;
    value.forEach((element) {
      listOfWidgets.add(
        Image.network(
          element,
          fit: BoxFit.cover,
        ),
      );
    });

    imageWidgets = listOfWidgets;
  }

  addCommentToTheList(Comment comment) {
    _commentList.add(comment);
  }

  resetTheComments() {
    _commentList = [];
  }

  ratingSystem(double value) {
    int intOfValue = value.toInt();

    List<Icon> list = [];

    for (int i = 0; i < intOfValue; i++) {
      list.add(
        const Icon(
          Icons.star,
          color: AppConstants.primaryColor,
        ),
      );
    }
    if (value - intOfValue >= 0.5) {
      list.add(
        const Icon(
          Icons.star_half,
          color: AppConstants.primaryColor,
        ),
      );
    } else {
      list.length != 5
          ? list.add(
              const Icon(
                Icons.star_border,
                color: AppConstants.primaryColor,
              ),
            )
          : list;
    }
    var length = list.length;
    for (int i = 0; i < (5 - length).toInt(); i++) {
      print((0.5).toInt());
      list.add(
        const Icon(
          Icons.star_border,
          color: AppConstants.primaryColor,
        ),
      );
    }
    rateList = list;
  }

  loadThePage(Product? product, BuildContext context,
      ReloadableProductModel? reloadableProduct) async {
    setProductIsLoading = true;
    controller = ScrollController();
    commentController = TextEditingController();

    if (reloadableProduct != null) {
      print("reloadableProduct id is " + reloadableProduct.id);
      await getTheProduct(context: context, posterId: reloadableProduct.id)
          .then((value) {
        setImageWidgets(currentProduct!.images!);
        ratingSystem(currentProduct!.rate);
        getComments(posterId: currentProduct!.id);
        checkIfInTheBasket(context: context, posterId: currentProduct!.id);
        print("checkingTheFavourites started");
        checkIfInTheFavourites(context: context, posterId: currentProduct!.id);
      });
    } else {
      currentProduct = product;
      setProductIsLoading = false;
      setImageWidgets(currentProduct!.images!);
      ratingSystem(currentProduct!.rate);
      getComments(posterId: currentProduct!.id);
      checkIfInTheBasket(context: context, posterId: currentProduct!.id);
      print("checkingTheFavourites started");
      checkIfInTheFavourites(context: context, posterId: currentProduct!.id);
      // notifyListeners();
    }
  }

  addProductToTheBasket({
    required BuildContext context,
    required String posterId,
    required String token,
  }) async {
    try {
      _checkingTheBasket = true;
      notifyListeners();
      var request =
          await basketService.addToBasket(token: token, posterId: posterId);
      print("Checkeeer after remove the basket");

      if (request.statusCode == 404) {
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        checkIfInTheBasket(context: context, posterId: posterId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  removeProductFromBasket({
    required BuildContext context,
    required String posterId,
    required String token,
  }) async {
    try {
      _checkingTheBasket = true;
      notifyListeners();
      var request = await basketService.removeFromBasket(
          token: token, posterId: posterId);
      print("Checkeeer after remove the basket");

      if (request.statusCode == 404) {
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        checkIfInTheBasket(context: context, posterId: posterId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  checkIfInTheBasket({
    required BuildContext context,
    required String posterId,
  }) async {
    inTheBasket = false;
    _checkingTheBasket = true;
    // notifyListeners();
    String token =
        Provider.of<UserInfoViewModel>(context, listen: false).user.token;
    Response response =
        await basketService.isInTheBasket(token: token, posterId: posterId);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["msg"] == "Poster is in the basket!") {
        inTheBasket = true;
        // notifyListeners();
      } else if (jsonDecode(response.body)["msg"] ==
          "Poster is not in the basket!") {
        inTheBasket = false;
        // notifyListeners();
      }
    } else if (response.statusCode == 500) {
      inTheBasket = false;
      // notifyListeners();
    }
    _checkingTheBasket = false;
    notifyListeners();
  }

  checkIfFavourited() {
    if (!checkingTheFavourites) {
      isFavouritedAtDispose = !isFavouritedAtDispose;
      notifyListeners();
    }
  }

  checkIfInTheFavourites({
    required BuildContext context,
    required String posterId,
  }) async {
    inTheFavourites = false;
    _checkingTheFavourites = true;
    String token =
        Provider.of<UserInfoViewModel>(context, listen: false).user.token;
    Response response = await favouriteService.isInTheFavourites(
        token: token, posterId: posterId);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["inFavourites"] == true) {
        inTheFavourites = true;
        isFavouritedAtDispose = true;
      } else if (jsonDecode(response.body)["inFavourites"] == false) {
        inTheFavourites = false;
        isFavouritedAtDispose = false;
      }
    } else if (response.statusCode == 500) {
      inTheFavourites = false;
    }
    _checkingTheFavourites = false;
    notifyListeners();
    print("checkingTheFavourites = " + checkingTheFavourites.toString());
  }

  addProductToFavourites({
    required String posterId,
    required String token,
  }) async {
    try {
      var request = await favouriteService.addToFavourites(
        token: token,
        posterId: posterId,
      );

      if (request.statusCode == 404) {
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  removeProductFromFavourites({
    required String posterId,
    required String token,
  }) async {
    try {
      var request = await favouriteService.removeFromFavourites(
        token: token,
        posterId: posterId,
      );

      if (request.statusCode == 404) {
        return false;
      } else if (request.statusCode == 200 &&
          jsonDecode(request.body)["modifiedCount"] > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void scrollDown() {
    controller!.animateTo(
      controller!.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  disposeWidgets() {
    if (controller != null) {
      controller!.dispose();
    }
    commentController.dispose();
    commentController = TextEditingController();
    inTheBasket = false;
    setProductIsLoading = true;
    notifyListeners();
  }

  getTheProduct({
    required BuildContext context,
    required String posterId,
  }) async {
    var body =
        await posterService.getPosterById(context: context, posterId: posterId);
    print("Body is " + body.toString());
    currentProduct = Product.fromMap(body);
    print("Body is product now");
    productIsLoading = false;
    notifyListeners();
  }

  void customDispose({
    required String posterId,
    required String token,
    required ProfileViewModel profileViewModel,
  }) async {
    print("At dispose " +
        inTheFavourites.toString() +
        "/" +
        isFavouritedAtDispose.toString());
    if (inTheFavourites != isFavouritedAtDispose) {
      if (isFavouritedAtDispose) {
        addProductToFavourites(
          posterId: posterId,
          token: token,
        );
      } else {
        await removeProductFromFavourites(
          posterId: posterId,
          token: token,
        ).then((value) {
          profileViewModel.gettingFavourites(token: token);
        });
      }
    }
  }
}
