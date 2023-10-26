import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../generated/collection_types.pb.dart';
import '../../grpc_connection/client_provider.dart';

part 'collection_creation_controller.g.dart';

@riverpod
class CollectionCreationController extends _$CollectionCreationController {
  @override
  FutureOr<Collection?> build() async {
  }
  Future<void> createCollection(Collection collection) async {
    state = const AsyncLoading();
    try {
      final response = await ref.read(clientProvider).newCollection(collection);
      state = AsyncData(response);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
