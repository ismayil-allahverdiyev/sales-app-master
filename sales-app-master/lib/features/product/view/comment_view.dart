import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  const CommentView({Key? key}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: width*0.05,
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 10,),
              Text(
                "User Userov",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4, 4, width/5, 4),
            child: Text(
              "I am a comment about a picture it is just so beautiful i am asnotished as hell u haveno idea u know!!!",
              style: TextStyle(
                  fontSize: 16
              ),
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
