import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expense_tracker/global_vars/global_expense.dart';
import 'package:flutter_expense_tracker/routers/app_routes.dart';
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
  
  // TODO Remove global later
  getValue();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.dark(
        scheme: FlexScheme.mandyRed,
        colorScheme: const ColorScheme.dark(primary: Colors.red),
        appBarBackground: (Colors.grey[850]),
      ),
      // home: const HomePage(),
      routerConfig: goRouter,
      builder: (_, child) {
        return SafeArea(
          child: child!,
        );
      },
    );
  }
}
