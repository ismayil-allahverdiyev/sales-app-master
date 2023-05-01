import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/features/category/model/category_model.dart';

import '../../category/view/category_view.dart';
import '../../category/view_model/category_view_model.dart';

class Insight extends StatelessWidget {
  Insight({super.key, required this.category});
  CategoryModel category;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          Provider.of<CategoryViewModel>(context, listen: false).isLoaded =
              false;
          return CategoryView(category: category);
        }));
      },
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: width / 3 * 2 - 25,
                width: width / 2 - 10,
                child: Card(
                  elevation: 10,
                  color: Color(0xffEDE6E3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: category.getCoverUrl,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                child: Container(
                  height: width / 3 * 2 - 33,
                  width: width / 2 - 18,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 16,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Row(
                    children: const [
                      Text(
                        "Explore ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right_circle,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Text(
            category.getTitle,
            style: GoogleFonts.notoSerif(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
