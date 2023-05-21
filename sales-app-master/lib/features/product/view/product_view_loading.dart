import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sales_app/features/product/view/comment_view_loading.dart';
import 'package:shimmer/shimmer.dart';

class ProductViewLoading extends StatelessWidget {
  const ProductViewLoading({super.key});

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SizedBox(
        height: height,
        width: width,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: width / 3 * 4,
                  width: width,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 20,
                  width: width / 3,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 20,
                  width: width / 2,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: width / 5,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 40,
                          width: width / 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      width: width / 6,
                      height: width / 12,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 45,
                  width: width / 5 * 3,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  indent: 8,
                  thickness: 2,
                  endIndent: width / 2,
                  height: 2,
                  color: Colors.white,
                ),
                CommentViewLoading(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
