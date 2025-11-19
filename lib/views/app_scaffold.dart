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

  Widget _buildNavigationRail(BuildContext context, bool extended) {
    final int selectedIndex = currentDestination != null
        ? AppDestination.values.indexOf(currentDestination!)
        : 0;

    return NavigationRail(
      selectedIndex: selectedIndex,
      extended: extended,
      labelType:
          extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
      onDestinationSelected: (index) {
        final destination = AppDestination.values[index];
        _navigateTo(context, destination);
      },
      destinations: [
        for (final destination in AppDestination.values)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            label: Text(destination.label),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showRail = constraints.maxWidth >= 900;
        final bool extendRail = constraints.maxWidth >= 1200;

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
          drawer: showRail ? null : _buildDrawer(context),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showRail)
                _buildNavigationRail(
                  context,
                  extendRail,
                ),
              Expanded(child: body),
            ],
          ),
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }
}
