import 'package:flutter_expense_tracker/pages/categories.dart';
import 'package:flutter_expense_tracker/pages/home_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  homePage,
  expenseCategoriesPage,
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
    GoRoute(
      name: AppRoutes.expenseCategoriesPage.name,
      path: '/categories',
      builder: (context, state) {
        return const ExpenseCategories();
      },
    ),
  ],
);
