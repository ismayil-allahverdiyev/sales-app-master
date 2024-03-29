import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/basket/models/basket_product_model.dart';
import 'package:sales_app/features/basket/view_model/basket_view_model.dart';
import 'package:sales_app/features/product/view/product_view.dart';
import 'package:sales_app/features/sign_page/view_model/user_info_view_model.dart';

import '../../product/model/product_model.dart';

class BasketProductView extends StatelessWidget {
  const BasketProductView({Key? key, required this.reloadableProduct})
      : super(key: key);
  final ReloadableProductModel reloadableProduct;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ProductView(reloadableProduct: reloadableProduct),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Container(
                      width: 140,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 2,
                        ),
                        itemCount: reloadableProduct.image.length,
                        itemBuilder: (context, index) => CachedNetworkImage(
                          imageUrl: reloadableProduct.image[index],
                          imageBuilder: (context, imageProvider) => Container(
                            width:
                                reloadableProduct.image.length > 1 ? 69 : 140,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: reloadableProduct.image.length > 1
                                  ? index == 0
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        )
                                      : const BorderRadius.only(
                                          bottomRight: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        )
                                  : BorderRadius.circular(16),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<BasketViewModel>(context, listen: false)
                          .removeProductFromBasket(
                        context: context,
                        posterId: reloadableProduct.id,
                        token: Provider.of<UserInfoViewModel>(
                          context,
                          listen: false,
                        ).user.token,
                      );
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Text(
                    reloadableProduct.description,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    width: width / 4,
                  ),
                  Text(
                    "${reloadableProduct.price}\$",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          indent: 8,
          endIndent: 8,
          thickness: 2,
          color: Colors.grey[300],
        )
      ],
    );
  }
}
