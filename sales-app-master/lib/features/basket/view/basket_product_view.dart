import 'package:flutter/material.dart';
import 'package:sales_app/features/product/view/product_view.dart';

import '../../product/model/product_model.dart';

class BasketProductView extends StatelessWidget {
  const BasketProductView({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductView(product: product)));
          },
          child: Column(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      product.images![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Text(
                    product.title,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    width: width / 4,
                  ),
                  Text(
                    "${product.price}\$",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
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
