import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_constants.dart';

class CustomAppBar {

  final AppBar _appBar = AppBar(
      backgroundColor: AppConstants.primaryColor,
      elevation: 0,
      title: SizedBox(
        width: AppBar().preferredSize.width,
        child: Row(
          children: [
            Text(
                "Aisha",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                height: AppBar().preferredSize.height-16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[400]!, style: BorderStyle.solid, width: 2),
                  color: Colors.grey[100]
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.search, color: Colors.grey,),
                    SizedBox(width: 10,),
                    Text(
                      "Search...",
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
  );

  AppBar get appBar => _appBar;
}
