// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:small_app_example/API/api_structs.dart';
// import 'package:small_app_example/Controller/collection_controllers/collection_view_controller.dart';
// import 'package:small_app_example/Extensions/async_value_ui.dart';
// import 'package:small_app_example/Widgets/basic_widgets/take_picture_screen.dart';
// import 'package:image/image.dart' as img;
//
// import '../../API/collection_api.dart';
//
// ///Todo: change the creation from collection to collection
//
// class CollectionAddForm extends ConsumerWidget {
//   CollectionAddForm({super.key, required this.api});
//
//   final CollectionApi api;
//   final TextEditingController collectionID = TextEditingController();
//   final TextEditingController collectionName = TextEditingController();
//   final TextEditingController parentCollection = TextEditingController();
//   String? imagePath;
//   String? imageData;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(collectionCreationControllerProvider);
//     ref.listen(
//       collectionCreationControllerProvider,
//       (_, state) {
//         state.showSnackBarOnError(context);
//       },
//     );
//     if (state.isLoading) {
//       return const CircularProgressIndicator();
//     } else {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'collection ID'),
//                 controller: collectionID,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly
//                 ],
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'collection Name'),
//                 controller: collectionName,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter collection name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Parent collection'),
//                 controller: parentCollection,
//                 keyboardType: TextInputType.number,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly
//                 ],
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     imagePath = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const TakePictureScreen(),
//                       ),
//                     );
//                   },
//                   child: const Icon(Icons.camera)),
//               ElevatedButton(
//                 child: const Text('Add collection'),
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     final parentCollectionNumber =
//                         int.tryParse(parentCollection.text);
//                     final collectionIDNumber = int.tryParse(collectionID.text);
//                     if (imagePath != null) {
//                       // final image = await img.decodeImageFile(imagePath!);
//                       // final imageCropped = img.copyResize(image!, width: 256);
//                       // imageData = imageCropped.;
//                       imageData =
//                           base64Encode(await File(imagePath!).readAsBytes());
//                     }
//                     ref
//                         .read(collectionCreationControllerProvider.notifier)
//                         .createcollection(
//                           collectionDeprecated(
//                             collectionIDNumber,
//                             collectionName.text,
//                             parentCollectionNumber,
//                             imageData,
//                           ),
//                         );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }