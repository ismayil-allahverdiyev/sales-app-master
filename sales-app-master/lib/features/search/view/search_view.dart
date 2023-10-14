import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/addPage/view_model/add_page_view_model.dart';
import 'package:sales_app/features/category/view/category_product_loading.dart';
import 'package:sales_app/features/category/view/category_product_view.dart';
import 'package:sales_app/features/search/view/category_loading_view.dart';
import 'package:sales_app/features/search/view_model/search_view_model.dart';
import '../../../core/constants/app_constants.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Scaffold(
        endDrawer: SearchDrawer(width: width, height: height),
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
                        return const CategoryLoadingView();
                      } else {
                        return const CategoriesWidget();
                      }
                    },
                  ),
                ),
                Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    return viewModel.productLoading
                        ? const CategoryProductLoading()
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: viewModel.searchIsOn
                                ? viewModel.searchedProducts.length
                                : viewModel.allProducts.length,
                            itemBuilder: (context, index) =>
                                CategoryProductView(
                              product: viewModel.searchIsOn
                                  ? viewModel.searchedProducts[index]
                                  : viewModel.allProducts[index],
                            ),
                          );
                  },
                ),
                SizedBox(
                  height: height * 0.2,
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

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, viewModel, _) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            spacing: 10,
            runSpacing: -8,
            children: List.generate(
              viewModel.searchIsOn
                  ? viewModel.searchedCategories.length
                  : viewModel.allCategories.length,
              (index) => GestureDetector(
                onTap: () {
                  viewModel.selectCategory(index);
                },
                child: Chip(
                  backgroundColor: !viewModel.selectedCategories.contains(index)
                      ? Color(0xffB6CAFF)
                      : AppConstants.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  label: Text(
                    viewModel.searchIsOn
                        ? viewModel.searchedCategories[index].getTitle
                        : viewModel.allCategories[index].getTitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
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
                MinMaxSelector(width: width),
                const MinMaxSlider(),
                const Divider(
                  indent: 8,
                  endIndent: 8,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                  child: Text(
                    textAlign: TextAlign.end,
                    "Color selector",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Consumer<SearchViewModel>(
                          builder: (context, viewModel, _) {
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            height: viewModel.isColorListOn ? height * 0.4 : 0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.colors.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return PaletteWidget(
                                  color: Color(
                                    0xFF000000 +
                                        int.parse(
                                          viewModel.colors[index].hexCodes[0]
                                              .substring(0, 6),
                                          radix: 16,
                                        ),
                                  ),
                                  colorName: viewModel.colors[index].colorName,
                                  isSearch: true,
                                  index: index,
                                );
                              },
                            ),
                          ),
                        );
                      }),
                      Consumer<SearchViewModel>(
                          builder: (context, viewModel, _) {
                        return InkWell(
                          onTap: () {
                            viewModel.turnColorListOnOff();
                          },
                          child: Container(
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(
                                  viewModel.isColorListOn ? 0 : 8,
                                ),
                                topRight: Radius.circular(
                                  viewModel.isColorListOn ? 0 : 8,
                                ),
                              ),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                viewModel.isColorListOn
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 58,
              left: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  Provider.of<SearchViewModel>(context, listen: false)
                      .getAllPosters();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: const Drawer().width,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MinMaxSlider extends StatelessWidget {
  const MinMaxSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, viewModel, _) {
      return StatefulBuilder(
        builder: (context, state) {
          return RangeSlider(
            values: viewModel.currentRangeValues,
            max: 100000,
            min: 0,
            activeColor: AppConstants.secondaryColor,
            inactiveColor: AppConstants.secondaryColor!.withOpacity(0.3),
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
            onChanged: (value) {
              viewModel.currentRangeValues = value;
              Provider.of<SearchViewModel>(context, listen: false)
                  .setRangeValues(value);

              state(() {});
            },
          );
        },
      );
    });
  }
}

class MinMaxSelector extends StatelessWidget {
  const MinMaxSelector({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
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
    );
  }
}
