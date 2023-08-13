import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:small_app_example/API/category_api.dart';
import 'package:small_app_example/Widgets/basic_widgets/take_picture_screen.dart';
import 'package:small_app_example/Widgets/category_creation_view.dart';
import 'package:small_app_example/Widgets/category_details_view.dart';
import 'package:small_app_example/Widgets/category_overview.dart';
import 'package:small_app_example/Widgets/collection_view.dart';
import 'Constants/route_constants.dart';
import 'Widgets/item_view.dart';
import 'Widgets/scaffold_with_nav.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shell A');
final _shellNavigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shell B');
final _shellNavigatorKeyC = GlobalKey<NavigatorState>(debugLabel: 'shell C');

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
              routes: [
                GoRoute(
                  path: 'details/:categoryID',
                  builder: (context, state) => CategoryDetailsView(
                    categoryID:
                        int.tryParse(state.pathParameters['categoryID']!)!,
                  ),
                ),
                GoRoute(
                  path: 'creation',
                  builder: (context, state) => CategoryAddForm(
                    api: CategoryRestApi(),
                  ),
                )
              ],
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
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyC,
          routes: [
            GoRoute(
              path: AppRoutes.collection,
              builder: (context, state) => const CollectionView(),
            )
          ],
        )
      ],
    ),
    // GoRoute(
    //   path: '/camera',
    //   builder: (context, state) => const TakePictureScreen(),
    // ),
  ],
);
