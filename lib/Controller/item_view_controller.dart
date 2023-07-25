import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/item_api.dart';

import '../API/api_structs.dart';

part 'item_view_controller.g.dart';

@riverpod
class ItemViewController extends _$ItemViewController {
  // Object? _key;

  @override
  FutureOr<Item?> build() async {
    // _key = Object();
    // ref.onDispose(() => _key = null);
    return null;
  }

  void addItem(
      {required Name name,
      required Description description,
      Price? price,
      ID? categoryId,
      required BuildContext context}) async {
    var item = Item(null, name, description, categoryId, price);
    state = const AsyncData(null);
    final itemRepository = ref.read(itemAPIRepository);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => itemRepository.addItem(item));
  }
}
