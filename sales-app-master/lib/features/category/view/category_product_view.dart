import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/product_view.dart';

class CategoryProductView extends StatelessWidget {
  const CategoryProductView(
      {Key? key, required this.product, this.bought = false})
      : super(key: key);

  final Product product;
  final bool bought;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("CategoryProductView " + product.toMap().toString());

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  print("Clicked one is " + product.id);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductView(
                            product: product,
                          )));
                },
                child: Container(
                  width: (width - 16) / 2,
                  height: (width - 16) / 3 * 2,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                                AppConstants.secondaryColor!.withOpacity(0.5),
                            blurRadius: 2,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: 0.01,
                            offset: Offset(2, 2))
                      ],
                      image: DecorationImage(
                          image: NetworkImage(product.images![0]),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    SizedBox(
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
                          SizedBox(
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
                          SizedBox(
                            height: 2,
                          ),
                          bought == false
                              ? Text(
                                  "${product.price}\$",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              : RichText(
                                  text: TextSpan(children: [
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
                                  ]),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: width * 0.1,
              height: width * 0.1,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("assets/icons/heart.png"),
                    color: product.favs != [] ? Colors.grey[700] : Colors.red,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
