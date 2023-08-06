import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

String uri = "https://aisha-sales-app.herokuapp.com";
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class AppConstants {
  static const Color primaryColor = Color(0xff762ec1);
  static const Color iconColor = Color(0xff777DA7);
  static Color? secondaryColor = Color.fromRGBO(230, 81, 0, 1);
}

unFocus(BuildContext context) {
  FocusScopeNode currentCope = FocusScope.of(context);

  if (!currentCope.hasPrimaryFocus) {
    currentCope.unfocus();
  }
}

String? dir;

Future<File> moveFile(File sourceFile) async {
  try {
    print("Destination");
    // prefer using rename as it is probably faster
    dir ??= (await getApplicationDocumentsDirectory()).path;
    String destination = dir! + basename(sourceFile.path);
    print("Destination changed");
    return await sourceFile.rename(destination);
  } on FileSystemException catch (e) {
    // if rename fails, copy the source file and then delete it
    dir ??= (await getApplicationDocumentsDirectory()).path;
    String destination = dir! + basename(sourceFile.path);
    final newFile = await sourceFile.copy(destination);
    print("Destination changed 2");

    return newFile;
  }
}
