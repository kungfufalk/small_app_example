// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../API/api_structs.dart';
// import '../../Controller/category_controllers/category_controller.dart';
//
// ///Todo: add item list
//
// class CategoryDetailsView extends ConsumerWidget {
//   const CategoryDetailsView({super.key, required this.categoryID});
//
//   final ID categoryID;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(categoryControllerProvider);
//     return state.when(
//       data: (data) {
//         final category = data.firstWhere((element) => element.id == categoryID);
//         return Column(
//           children: [
//             Image.memory(base64Decode(category.thumbnail!)),
//             Text('ID:${category.id}'),
//             Text('Name:${category.name}'),
//             Text('Parent Category:${category.parentCategory}'),
//           ],
//         );
//       },
//       error: (error, stackTrace) {
//         throw Exception(error);
//       },
//       loading: () => const CircularProgressIndicator(),
//     );
//   }
// }
