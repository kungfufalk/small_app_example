import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/API/category_api.dart';
import 'package:small_app_example/Controller/category_overview_controller.dart';

class CategoryOverview extends ConsumerWidget {
  const CategoryOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryOveviewControllerProvider);
    return GridView.count(crossAxisCount: crossAxisCount);
  }
}
