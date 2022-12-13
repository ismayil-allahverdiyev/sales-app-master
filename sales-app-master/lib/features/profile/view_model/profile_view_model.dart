import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{

  int _currentIndex = 0;

  TabController? _tabController;


  TabController get tabController => _tabController!;

  set tabController(TabController value) {
    _tabController = value;
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    _tabChange(_currentIndex);
    notifyListeners();
  }

  _tabChange(int index){
    _tabController?.animateTo(index);
    notifyListeners();
  }
}