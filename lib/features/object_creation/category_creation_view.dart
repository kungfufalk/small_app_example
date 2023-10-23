// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:small_app_example/API/api_structs.dart';
// import 'package:small_app_example/Controller/category_controllers/category_controller.dart';
// import 'package:small_app_example/Extensions/async_value_ui.dart';
// import 'package:small_app_example/Widgets/basic_widgets/take_picture_screen.dart';
// import 'package:image/image.dart' as img;
//
// import '../../API/category_api.dart';
//
// class CategoryAddForm extends ConsumerWidget {
//   CategoryAddForm({super.key, required this.api});
//
//   final CategoryApi api;
//   final TextEditingController categoryID = TextEditingController();
//   final TextEditingController categoryName = TextEditingController();
//   final TextEditingController parentCategory = TextEditingController();
//   String? imagePath;
//   String? imageData;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(categoryCreationControllerProvider);
//     ref.listen(
//       categoryCreationControllerProvider,
//       (_, state) {
//         state.showSnackBarOnError(context);
//       },
//     );
//     if (state.isLoading) {
//       return const CircularProgressIndicator();
//     } else {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Category ID'),
//               controller: categoryID,
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//             ),
//             TextFormField(
//                 decoration: const InputDecoration(labelText: 'Category Name'),
//                 controller: categoryName),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Parent Category'),
//               controller: parentCategory,
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   imagePath = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const TakePictureScreen(),
//                     ),
//                   );
//                 },
//                 child: const Icon(Icons.camera)),
//             ElevatedButton(
//               child: const Text('Add Category'),
//               onPressed: () async {
//                 final parentCategoryNumber = int.tryParse(parentCategory.text);
//                 final categoryIDNumber = int.tryParse(categoryID.text);
//                 if (imagePath != null) {
//                   // final image = await img.decodeImageFile(imagePath!);
//                   // final imageCropped = img.copyResize(image!, width: 256);
//                   // imageData = imageCropped.;
//                   imageData =
//                       base64Encode(await File(imagePath!).readAsBytes());
//                 }
//                 ref
//                     .read(categoryCreationControllerProvider.notifier)
//                     .createCategory(
//                       CategoryDeprecated(
//                         categoryIDNumber,
//                         categoryName.text,
//                         parentCategoryNumber,
//                         imageData,
//                       ),
//                     );
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
