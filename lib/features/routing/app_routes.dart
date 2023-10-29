import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:small_app_example/features/collection_management/collection_overview.dart';
import 'package:small_app_example/features/object_creation/widgets/category_creation_view.dart';
import 'package:small_app_example/features/object_creation/widgets/collection_creation_view.dart';
import 'package:small_app_example/features/object_creation/widgets/item_creation_view.dart';
import 'package:small_app_example/features/routing/route_constants.dart';

import '../basic_widgets/scaffold_with_nav.dart';
import '../object_creation/widgets/creation_overview.dart';
import '../settings/widgets/settings_overview.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyA = GlobalKey<NavigatorState>(debugLabel: 'shell A');
final _shellNavigatorKeyB = GlobalKey<NavigatorState>(debugLabel: 'shell B');
final _shellNavigatorKeyC = GlobalKey<NavigatorState>(debugLabel: 'shell C');

///Todo: replace with go_router_builder

final routerConfig = GoRouter(
  initialLocation: AppRoutes.browse,
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
              path: AppRoutes.create,
              builder: (context, state) => const CreationOverview(),
              routes: [
                GoRoute(
                  path: AppRoutes.categoryCreation,
                  builder: (context, state) => const CategoryCreationView(),
                ),
                GoRoute(
                  path: AppRoutes.collectionCreation,
                  builder: (context, state) => CollectionCreationView(),
                ),
                GoRoute(
                  path: AppRoutes.itemCreation,
                  builder: (context, state) => const ItemCreationView(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyB,
          routes: [
            GoRoute(
              path: AppRoutes.browse,
              builder: (context, state) {
                return const CollectionOverview();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyC,
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              builder: (context, state) => const SettingsOverview(),
            )
          ],
        )
      ],
    ),
  ],
);
