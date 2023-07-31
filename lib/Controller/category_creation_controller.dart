import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/category_api.dart';

import '../API/api_structs.dart';

part 'category_creation_controller.g.dart';

@riverpod
class CategoryController extends _$CategoryController {
  @override
  Future<List<Category>> build() async {
    return await ref.read(categoryAPIRepository).getCategories();
  }

  Future<void> addCategory(Category category) async {
    state = const AsyncLoading();
    final categoryRepository = ref.read(categoryAPIRepository);
    final returnedCategory =
        await AsyncValue.guard(() => categoryRepository.addCategory(category));
    if (returnedCategory.hasError) {
      state = AsyncError(returnedCategory.error!, returnedCategory.stackTrace!);
    } else {
      state = await AsyncValue.guard(
          () => ref.read(categoryAPIRepository).getCategories());
    }
  }
}
