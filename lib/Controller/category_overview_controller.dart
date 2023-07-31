import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/category_api.dart';

import '../API/api_structs.dart';

part 'category_overview_controller.g.dart';

@riverpod
class CategoryOverviewController extends _$CategoryOverviewController {
  @override
  Future<AsyncValue<List<Category>>> build() async {
    return await AsyncValue.guard(
        () => ref.read(categoryAPIRepository).getCategories());
  }

// Future<void> getCategories() async {
//   state = const AsyncLoading();
//   state = await AsyncValue.guard(
//       () => ref.read(categoryAPIRepository).getCategories());
// }
}
