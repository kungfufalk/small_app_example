import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/item_api.dart';

import '../API/api_structs.dart';

part 'ItemViewController.g.dart';

@riverpod
class ItemViewController extends _$ItemViewController {
  // Object? _key;

  @override
  FutureOr<Item?> build() async {
    // _key = Object();
    // ref.onDispose(() => _key = null);
    return null;
  }

  void addItem(Item item, BuildContext context) async {
    state = const AsyncData(null);
    // final key = _key;
    final itemRepository = ref.read(itemAPIRepository);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => itemRepository.addItem(item));
    // if (key == _key) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Item was successfully added')));
    // }
  }
}
