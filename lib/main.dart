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

void main() {
  runApp(const ProviderScope(
      // overrides: [itemAPIRepository.overrideWithValue(ItemDummyApi())],
      child: MyApp()));
}

final routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) =>
          const ActionOverview(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.collection,
          builder: (BuildContext context, GoRouterState state) =>
          const CollectionView(),
        ),
        GoRoute(
          path: AppRoutes.item,
          builder: (context, state) => ItemView(),
        ),
        GoRoute(
          path: AppRoutes.category,
          builder: (context, state) => const CategoryOverview(),
        )
      ]
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
