import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/product/model/comment_model.dart';

class CommentView extends StatelessWidget {
  Comment comment;
  CommentView({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: width * 0.05,
                backgroundColor: Colors.grey[200],
                backgroundImage: comment.imageUrl != ""
                    ? NetworkImage(
                        comment.imageUrl,
                      )
                    : null,
                child: Icon(
                  CupertinoIcons.person,
                  color: AppConstants.iconColor,
                  size: width * 0.05,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                comment.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4, 4, width / 5, 4),
            child: Text(
              comment.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(
            indent: 8,
            endIndent: 8,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
