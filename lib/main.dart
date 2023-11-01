import 'dart:io';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/database/isar_service.dart';
import 'package:flutter_expense_tracker/routes/app_routes.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return IsarService();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                TransactionsBloc(isarService: context.read<IsarService>())
                  ..add(TransactionsInitialEvent()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(isarService: context.read<IsarService>()),
          ),
        ],
        child: SafeArea(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.dark(
              scheme: FlexScheme.mandyRed,
              colorScheme: const ColorScheme.dark(primary: Colors.red),
              appBarBackground: (Colors.grey[850]),
            ),
            // home: const HomePage(),
            routerConfig: goRouter,
          ),
        ),
      ),
    );
  }
}
