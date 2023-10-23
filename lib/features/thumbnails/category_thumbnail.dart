// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:small_app_example/Constants/route_constants.dart';
//
// import '../API/api_structs.dart';
//
// class CategoryThumbnail extends StatelessWidget {
//   const CategoryThumbnail({
//     super.key,
//     required this.category,
//   });
//
//   final Category category;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.go('${AppRoutes.categoryDetails}/${category.id}');
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Flexible(
//               flex: 5,
//               child: Image.memory(
//                 base64Decode(category.thumbnail!),
//               ),
//             ),
//             Flexible(
//               flex: 1,
//               child: Text(category.name),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
