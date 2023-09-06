import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/add_page_view_model.dart';

class CategorySelectionWidget extends StatelessWidget {
  const CategorySelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<AddPageViewModel>(builder: (context, viewModel, _) {
      viewModel.menuItemsLoaded == false
          ? Provider.of<AddPageViewModel>(context).updateCategories()
          : null;
      return Column(
        children: [
          viewModel.selectionIsOpen
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 0))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: ListView(
                              children: viewModel.menuItems,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            viewModel.closeCategories();
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 14,
                        right: 14,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: const Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.arrow_downward_rounded,
                              size: 15,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: GestureDetector(
                      onTap: () {
                        viewModel.openCategories();
                      },
                      child: Container(
                        height: CupertinoTextField().cursorHeight,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[300]!,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              Text(
                                viewModel.chosenCategory != null
                                    ? viewModel.chosenCategory!
                                    : "Choose category",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                viewModel.selectionIsOpen == false
                                    ? Icons.arrow_drop_down_rounded
                                    : Icons.arrow_drop_up_rounded,
                                color: viewModel.chosenCategory != null
                                    ? Colors.black
                                    : Colors.grey[800],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    });
  }
}
