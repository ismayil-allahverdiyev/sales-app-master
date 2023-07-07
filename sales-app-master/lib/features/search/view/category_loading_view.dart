import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoadingView extends StatelessWidget {
  const CategoryLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> dummyCategories = [
      "aaaa",
      "aaaaaaa",
      "aaaaa",
      "aaaaaaaaaaa",
      "aa",
    ];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[100]!,
        highlightColor: Colors.grey[300]!,
        child: Wrap(
          spacing: 10,
          runSpacing: -8,
          children: List.generate(
            dummyCategories.length,
            (index) => Chip(
              backgroundColor: Color(0xffB6CAFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              label: Text(
                dummyCategories[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
