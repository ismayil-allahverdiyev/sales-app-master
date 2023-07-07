import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/category/view/category_product_loading.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/product/services/poster_service.dart';
import 'package:sales_app/features/search/view/category_loading_view.dart';
import 'package:sales_app/features/search/view_model/search_view_model.dart';

import '../../../core/constants/app_constants.dart';
import '../../product/model/product_model.dart';

class SearchView extends StatelessWidget {
  PosterService posterService = PosterService();

  List<String> list = [
    "Nature",
    "Animals",
    "Food",
    "Travel",
    "Drawings",
    "Sale",
    "Education",
    "Furniture",
    "Stickers",
    "Key chains"
  ];

  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Provider.of<SearchViewModel>(context, listen: false).handleInitPage();

    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Scaffold(
        endDrawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: [
                ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                      child: Text(
                        textAlign: TextAlign.end,
                        "Price Range",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Consumer<SearchViewModel>(
                      builder: (context, viewModel, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width / 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    viewModel.minValue,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              " - ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: width / 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    viewModel.maxValue,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    StatefulBuilder(
                      builder: (context, state) {
                        return RangeSlider(
                          values: _currentRangeValues,
                          max: 100,
                          activeColor: AppConstants.secondaryColor,
                          inactiveColor:
                              AppConstants.secondaryColor!.withOpacity(0.3),
                          // divisions: 100,
                          labels: RangeLabels(
                            Provider.of<SearchViewModel>(context, listen: false)
                                .currentRangeValues
                                .start
                                .round()
                                .toString(),
                            Provider.of<SearchViewModel>(context, listen: false)
                                .currentRangeValues
                                .end
                                .round()
                                .toString(),
                          ),
                          min: 0,
                          onChanged: (value) {
                            _currentRangeValues = value;
                            Provider.of<SearchViewModel>(context, listen: false)
                                .setRangeValues(value);

                            state(() {});
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 58,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 58,
                  left: 8,
                  right: 8,
                  child: Container(
                    height: 50,
                    width: Drawer().width,
                    decoration: BoxDecoration(
                        color: AppConstants.secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[Container()],
          title:
              Consumer<SearchViewModel>(builder: (context, viewModel, child) {
            return CupertinoTextField(
              controller: viewModel.searchController,
              placeholder: "Search...",
              onChanged: (value) {
                viewModel.handleStaticSearch(value);
              },
              prefix: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("assets/icons/searchNav.png"),
                  color: Colors.grey,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                    width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              cursorColor: AppConstants.primaryColor,
            );
          }),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: width / 3,
                  child: Consumer<SearchViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.categoryLoading) {
                        return CategoryLoadingView();
                      } else {
                        if (viewModel.searchIsOn) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: -8,
                              children: List.generate(
                                viewModel.searchedCategories.length,
                                (index) => Chip(
                                  backgroundColor: Color(0xffB6CAFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelPadding:
                                      EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  label: Text(
                                    viewModel
                                        .searchedCategories[index].getTitle,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: -8,
                              children: List.generate(
                                viewModel.allCategories.length,
                                (index) => Chip(
                                  backgroundColor: Color(0xffB6CAFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelPadding:
                                      EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  label: Text(
                                    viewModel.allCategories[index].getTitle,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.productLoading) {
                      return CategoryProductLoading();
                    } else {
                      if (viewModel.searchIsOn) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.searchedProducts.length,
                          itemBuilder: (context, index) => CategoryProductView(
                              product: viewModel.searchedProducts[index]),
                        );
                      } else {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.allProducts.length,
                          itemBuilder: (context, index) => CategoryProductView(
                              product: viewModel.allProducts[index]),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
            Positioned(
              top: width / 3,
              right: 0,
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppConstants.secondaryColor),
                      shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/icons/filter-add.png",
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
