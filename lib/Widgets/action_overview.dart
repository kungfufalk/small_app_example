import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:small_app_example/Constants/route_constants.dart';

class ActionOverview extends ConsumerWidget {
  const ActionOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => context.go(AppRoutes.home + AppRoutes.collection),
              child: const Text('Create Collection')),
          ElevatedButton(
              onPressed: () => context.go(AppRoutes.home + AppRoutes.item),
              child: const Text('Create Item')),
          ElevatedButton(
              onPressed: () => context.go(AppRoutes.home + AppRoutes.category),
              child: const Text('Create Category')),
          ElevatedButton(
              onPressed: () => context.go(AppRoutes.home + AppRoutes.collection),
              child: const Text('Add Item to Collection')),
          ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Add Item to Category'))
        ],
      ),
    );
  }
}
