import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'account_settings_tab.dart';
import 'billing_tab.dart';
import 'general_settings_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = true;

  void _toggleTheme(bool isDarkTheme) {
    setState(() {
      _isDarkTheme = isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: MediaQuery.of(context).size.width < 600
                  ? _buildScrollableTabBar()
                  : const TabBar(
                       tabs: [
                        Tab(text: 'Account Settings'),
                        Tab(text: 'General Settings'),
                        Tab(text: 'Billing'),
                       ],
              ),
            ),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildTabPage(const AccountSettingsTab()),
              _buildTabPage(GeneralSettingsTab(
                isDarkTheme: _isDarkTheme,
                onThemeChanged: _toggleTheme,
              )),
              _buildTabPage(const BillingTab()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabPage(Widget child) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
      child: child,
    );
  }

  Widget _buildScrollableTabBar() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Tab(text: 'Account Settings'),
          SizedBox(width: 16),
          Tab(text: 'General Settings'),
          SizedBox(width: 16),
          Tab(text: 'Billing'),
        ],
      ),
    );
  }
}
