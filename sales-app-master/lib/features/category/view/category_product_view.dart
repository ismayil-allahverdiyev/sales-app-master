import 'package:flutter/material.dart';
import 'package:sales_app/features/product/model/product_model.dart';
import 'package:sales_app/features/product/view/product_view.dart';

class CategoryProductView extends StatefulWidget {
  const CategoryProductView(
      {Key? key, required this.product, this.bought = false})
      : super(key: key);

  final Product product;
  final bool bought;

  @override
  State<CategoryProductView> createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductView(
                        product: Product(
                            0,
                            "Mountain view and beautiful trees with lightining striking the town in the corner!",
                            27,
                            5,
                            [
                              "assets/images/bird.png",
                              "assets/images/whale.png"
                            ],
                            [],
                            "",
                            "",
                            null),
                      )));
            },
            child: Container(
              width: width - 16,
              height: width / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.product.images![0]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.8 - 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      widget.bought == false
                          ? Text(
                              "${widget.product.price}\$",
                              style: TextStyle(
                                  fontSize: 18,
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
                Container(
                  width: width * 0.1,
                  height: width * 0.1,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage("assets/icons/heart.png"),
                        color: widget.product.favs != []
                            ? Colors.grey[700]
                            : Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
