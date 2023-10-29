import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/features/grpc_connection/client_provider.dart';
import 'package:small_app_example/generated/collection_types.pb.dart';
import 'package:small_app_example/generated/find_me_pls.pbgrpc.dart';

part 'collection_overview_controller.g.dart';

@riverpod
class CollectionOverviewController extends _$CollectionOverviewController {
  @override
  FutureOr<List<Collection>> build() async {
    state = const AsyncLoading();
    final response = await ref.read(clientProvider)!.getAllCollections(Empty());
    return response.collections;
  }

  FutureOr<void> refreshCollections() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 5));
    try {
      final response = await ref.read(clientProvider)!.getAllCollections(
          Empty());
      state = AsyncData(response.collections);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

// FutureOr<Collection?> createCollection(Collection collection) async {
//   state = const AsyncValue.loading();
//   try {
//     await Future.delayed(const Duration(seconds: 5));
//     final returnedCollection =
//         await ref.read(clientProvider)!.newCollection(collection);
//     print('Collection created: ${returnedCollection.writeToJson()}');
//   } catch (e) {
//     state =
//         AsyncValue.error('Failed to create collection', StackTrace.current);
//   }
//   ref.invalidateSelf();
//   await future;
// }
}
