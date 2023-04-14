import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

String uri = "https://aisha-sales-app.herokuapp.com";

class AppConstants {
  static const Color primaryColor = Color(0xff762ec1);
  static Color? secondaryColor = Colors.orange[900];
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
