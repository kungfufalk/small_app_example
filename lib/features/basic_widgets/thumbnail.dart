// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../Constants/route_constants.dart';
//
// class ThumbnailView extends StatelessWidget {
//   const ThumbnailView({super.key, required this.image, required this.title, required this.onTap});
//
//   final ImageProvider image;
//   final String title;
//   final void Function() onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap;
//         //context.go('${AppRoutes.categoryDetails}/${category.id}');
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Flexible(
//               flex: 5,
//               child: Image(image: image),
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
