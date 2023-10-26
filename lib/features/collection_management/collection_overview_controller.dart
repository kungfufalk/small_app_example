import 'dart:convert';

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
    final response = await ref.read(clientProvider).getAllCollections(Empty());
    return response.categories;
  }

  FutureOr<void> createCollection(Collection collection) async {
      state = const AsyncValue.loading();
      final returnedCollection = await ref.read(clientProvider).newCollection(collection);
      if (returnedCollection != null) {
        print('Collection created: ${returnedCollection.writeToJson()}');
      } else {
        state = AsyncValue.error('Failed to create collection', StackTrace.current);
      }
      ref.invalidateSelf();
      await future;
  }
}
