// To do: implement controller
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/item_api.dart';

import '../API/api_structs.dart';

part 'ItemViewController.g.dart';

@riverpod
class ItemViewController extends _$ItemViewController {
  @override
  FutureOr<void> build() async {}

  Future<void> addItem(Item item) async {
    final itemRepository = ref.read(itemAPIRepository);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => itemRepository.addItem(item));
  }
}
