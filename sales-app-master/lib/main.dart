import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';
import 'package:sales_app/features/base/view_model/base_view_model.dart';
import 'package:sales_app/features/home/view/home_page.dart';
import 'package:sales_app/features/pagenav/view/pages.dart';
import 'package:sales_app/features/pagenav/view_model/pages_view_model.dart';
import 'package:sales_app/features/product/view_model/product_view_model.dart';
import 'package:sales_app/features/profile/view_model/profile_view_model.dart';
import 'package:sales_app/features/search/view_model/search_view_model.dart';
import 'package:sales_app/features/sign_page/services/auth_service.dart';
import 'package:sales_app/features/sign_page/view/sign_view.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

import 'core/constants/app_constants.dart';
import 'features/basket/view_model/basket_view_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BaseViewModel()),
      ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ChangeNotifierProvider(create: (_) => BasketViewModel()),
      ChangeNotifierProvider(create: (_) => UserInfoViewModel()),
      ChangeNotifierProvider(create: (_) => SearchViewModel()),
      ChangeNotifierProvider(create: (_) => PagesViewModel()),
      ChangeNotifierProvider(create: (_) => AddPageViewModel()),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserInfoViewModel>(context).user.token.isNotEmpty
        ? Pages()
        : SignView();
  }
}
