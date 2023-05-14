import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/sign_page/model/user.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

import '../model/comment_model.dart';
import '../services/comment_service.dart';

class ProductViewModel extends ChangeNotifier {
  CommentService commentService = CommentService();
  TextEditingController commentController = TextEditingController();

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
      list.add(Icon(
        Icons.star,
        color: AppConstants.primaryColor,
      ));
    }
    if (value - intOfValue >= 0.5) {
      list.add(
        Icon(
          Icons.star_half,
          color: AppConstants.primaryColor,
        ),
      );
    } else {
      list.length != 5
          ? list.add(
              Icon(
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
        Icon(
          Icons.star_border,
          color: AppConstants.primaryColor,
        ),
      );
    }
    rateList = list;
  }

  loadThePage(Product product) {
    setImageWidgets(product.images!);
    ratingSystem(product.rate);
    getComments(posterId: product.id);
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
  }
}
