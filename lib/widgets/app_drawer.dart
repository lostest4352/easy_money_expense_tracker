import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/routers/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // TODO Remove later
      width: 260,
      child: ListView(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  'Easy',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Text(
                  "Expense tracker",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w200, fontSize: 14),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              context.goNamed(AppRoutes.homePage.name);
            },
            leading: const Icon(Icons.account_balance_outlined),
            title: Text(
              'Transactions',
              style: GoogleFonts.roboto(),
            ),
          ),
          ListTile(
            onTap: () {
              context.goNamed(AppRoutes.expenseCategoriesPage.name);
            },
            leading: const Icon(Icons.label),
            title: Text(
              'Categories',
              style: GoogleFonts.roboto(),
            ),
          ),
          ListTile(
            onTap: () {
              context.goNamed(AppRoutes.settingsPage.name);
            },
            leading: const Icon(Icons.settings),
            title: Text(
              'Settings',
              style: GoogleFonts.roboto(),
            ),
          ),
        ],
      ),
    );
  }
}
