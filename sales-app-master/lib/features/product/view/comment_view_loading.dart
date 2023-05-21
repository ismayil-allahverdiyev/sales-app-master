import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class CommentViewLoading extends StatelessWidget {
  const CommentViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.05,
                  ),
                  Container(
                    width: width / 3,
                    height: 30,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: width / 5 * 4,
                height: 50,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}
