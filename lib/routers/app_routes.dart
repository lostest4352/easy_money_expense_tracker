import 'package:flutter_expense_tracker/pages/categories.dart';
import 'package:flutter_expense_tracker/pages/main_page.dart';
import 'package:flutter_expense_tracker/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  homePage,
  expenseCategoriesPage,
  settingsPage,
}

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: AppRoutes.homePage.name,
      path: '/',
      builder: (context, state) {
        return const MainPage();
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
    GoRoute(
      name: AppRoutes.settingsPage.name,
      path: '/settingsPage',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
  ],
);
