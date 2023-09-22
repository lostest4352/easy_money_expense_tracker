import 'package:flutter_expense_tracker/pages/home_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  homePage,
  secondPage,
}

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: AppRoutes.homePage.name,
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      // routes: [],
    ),
    // GoRoute(
    //   name: AppRoutes.secondPage.name,
    //   path: '/second/:filename',
    //   builder: (context, state) {
    //     final params = state.pathParameters['filename'];
    //     return SecondPage(
    //       filename: params ?? '',
    //     );
    //   },
    // ),
  ],
);
