import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/features/collection_management/collection_overview_controller.dart';
import '../../../generated/collection_types.pb.dart';
import '../../grpc_connection/client_provider.dart';

part 'collection_creation_controller.g.dart';

@riverpod
class CollectionCreationController extends _$CollectionCreationController {
  @override
  FutureOr<Collection?> build() async {
    return null;
  }

  FutureOr<void> createCollection(Collection collection) async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 5));
      final returnedCollection =
      await ref.read(clientProvider)!.newCollection(collection);
      state = AsyncValue.data(returnedCollection);
      print('Collection created: ${returnedCollection.writeToJson()}');
    } catch (e) {
      state =
          AsyncValue.error('Failed to create collection', StackTrace.current);
    }
    ref.read(collectionOverviewControllerProvider.notifier).refreshCollections();
  }
}
