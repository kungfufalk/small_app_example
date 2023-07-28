import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_app_example/Constants/route_constants.dart';
import 'package:small_app_example/Widgets/action_overview.dart';
import 'package:small_app_example/Widgets/category_view.dart';
import 'package:small_app_example/Widgets/collection_view.dart';
import 'package:small_app_example/Widgets/item_view.dart';
import 'package:small_app_example/Widgets/scaffold_with_nav.dart';

void main() {
  runApp(const ProviderScope(
      // overrides: [itemAPIRepository.overrideWithValue(ItemDummyApi())],
      child: MyApp()));
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shell A');
final _shellNavigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shell B');

final routerConfig = GoRouter(
  initialLocation: AppRoutes.category,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyA,
          routes: [
            GoRoute(
              path: AppRoutes.category,
              builder: (context, state) => const CategoryOverview(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyB,
          routes: [
            GoRoute(
              path: AppRoutes.item,
              builder: (context, state) => ItemView(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      color: Colors.redAccent,
    );
  }
}
