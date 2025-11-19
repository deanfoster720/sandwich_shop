import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';

enum AppDestination { order, about, profile }

extension AppDestinationData on AppDestination {
  String get label {
    switch (this) {
      case AppDestination.order:
        return 'Order sandwiches';
      case AppDestination.about:
        return 'About';
      case AppDestination.profile:
        return 'Profile';
    }
  }

  IconData get icon {
    switch (this) {
      case AppDestination.order:
        return Icons.fastfood;
      case AppDestination.about:
        return Icons.info_outline;
      case AppDestination.profile:
        return Icons.person_outline;
    }
  }

  String get routeName {
    switch (this) {
      case AppDestination.order:
        return '/';
      case AppDestination.about:
        return '/about';
      case AppDestination.profile:
        return '/profile';
    }
  }
}

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final AppDestination? currentDestination;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.currentDestination,
    this.floatingActionButton,
  });

  void _navigateTo(BuildContext context, AppDestination destination) {
    if (destination == currentDestination) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      destination.routeName,
      (route) => false,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 64,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sandwich Shop',
                      style: heading1,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Navigate through the app',
                      style: normalText,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (final destination in AppDestination.values)
                    ListTile(
                      leading: Icon(destination.icon),
                      title: Text(destination.label),
                      selected: destination == currentDestination,
                      onTap: () {
                        Navigator.of(context).pop();
                        _navigateTo(context, destination);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 12),
            Text(title, style: heading1),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
