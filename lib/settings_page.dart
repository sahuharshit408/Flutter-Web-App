import 'package:flutter/material.dart';
import 'account_settings_tab.dart';
import 'general_settings_tab.dart';
import 'billing_tab.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: MediaQuery.of(context).size.width < 600
              ? _buildScrollableTabBar()
              : TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Account Settings'),
              Tab(text: 'General Settings'),
              Tab(text: 'Billing'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const AccountSettingsTab(),
          GeneralSettingsTab(
            onThemeChanged: (bool value) {
              // Handle theme change
            },
            isDarkTheme: true, // You may want to pass the actual theme value
          ),
          const BillingTab(),
        ],
      ),
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
