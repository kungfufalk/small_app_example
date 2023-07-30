import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/category_api.dart';

import '../API/api_structs.dart';

part 'category_overview_controller.g.dart';

@riverpod
class CategoryOveviewController extends _$CategoryOveviewController {
  @override
   build() {
    return;
  }
  
  Future<AsyncValue<List<Category>>> getCategories() async{
    state = const AsyncLoading<void>();
    final categories = await AsyncValue.guard(() => ref.read(categoryAPIRepository).getCategories());
    if (categories.hasError) {
      state = AsyncError(categories.error!, categories.stackTrace!);
    }
    if (categories.hasValue) {
      state = const AsyncData(_);
    }
    return categories;
  }
}
