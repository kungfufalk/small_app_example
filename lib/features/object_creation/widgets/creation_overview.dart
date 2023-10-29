import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/route_constants.dart';

class CreationOverview extends StatelessWidget {
  const CreationOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Object Type',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.categoryFullPath);
              },
              child: const Text('New Category'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.collectionFullPath);
              },
              child: const Text('New Collection'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.itemFullPath);
              },
              child: const Text('New Item'),
            )
          ],
        ),
      ),
    );
  }
}
