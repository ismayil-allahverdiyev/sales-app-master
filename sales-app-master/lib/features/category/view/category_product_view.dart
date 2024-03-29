import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/basket/models/basket_product_model.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/product_view.dart';
import 'package:sales_app/features/profile/view_model/profile_view_model.dart';

import '../../product/view_model/product_view_model.dart';
import '../../sign_page/view_model/user_info_view_model.dart';

class CategoryProductView extends StatelessWidget {
  const CategoryProductView(
      {Key? key,
      required this.product,
      this.isReloadable = false,
      this.bought = false})
      : super(key: key);

  final Product product;
  final bool isReloadable;
  final bool bought;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer2<ProductViewModel, ProfileViewModel>(
        builder: (context, productViewModel, profileViewModel, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    print("reloadableProduct pre pre " + product.id.toString());
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => isReloadable
                            ? ProductView(
                                reloadableProduct: ReloadableProductModel(
                                  description: product.title,
                                  id: product.id,
                                  price: product.price,
                                  colors: product.colors,
                                  image: product.images![0],
                                ),
                              )
                            : ProductView(
                                product: product,
                              ),
                      ),
                    )
                        .then((value) {
                      // productViewModel.isFavouritedAtDispose == false
                      //     ? profileViewModel.gettingFavourites(
                      //         token: Provider.of<UserInfoViewModel>(context,
                      //                 listen: false)
                      //             .user
                      //             .token)
                      //     : null;
                      // if (productViewModel.isFavouritedAtDispose == false) {
                      //   profileViewModel.notifyListeners();
                      // }
                    });
                  },
                  child: CachedNetworkImage(
                    imageUrl: product.images![0],
                    imageBuilder: (context, imageProvider) => Container(
                      width: (width - 16) / 2,
                      height: (width - 16) / 3 * 2,
                      decoration: BoxDecoration(
                        boxShadow: [],
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      width: (width - 16) / 2,
                      height: (width - 16) / 3 * 2,
                      decoration: BoxDecoration(
                        boxShadow: [],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (width - 16) / 2 - 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.categorie,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          product.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        bought == false
                            ? Text(
                                "${product.price}\$",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            : RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "bought at ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: "06/06/2023",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  for (int i = 0;
                      i <
                          ((product.colors!.length >= 3)
                              ? 3
                              : product.colors!.length);
                      i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                          color: product.colors![i],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
