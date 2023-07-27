import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/collection_api.dart';

import '../API/api_structs.dart';

part 'collection_view_controller.g.dart';

@riverpod
class CollectionViewController extends _$CollectionViewController {
  @override
  FutureOr<List<Item>> build() async {
    return List.empty();
  }

  Future<void> getItemsInCollection (Collection collection) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(collectionRepository).getItemsInCollection(collection));
  }
}