import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expense_tracker/routers/app_routes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

// async if issue
void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.dark(
          scheme: FlexScheme.mandyRed,
          colorScheme: const ColorScheme.dark(primary: Colors.white),
          appBarBackground: (Colors.grey[850]),
          primary: Colors.blue,
        ),
        // home: const HomePage(),
        routerConfig: goRouter,
      ),
    );
  }
}
