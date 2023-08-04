import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/API/category_api.dart';

import '../API/api_structs.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryController extends _$CategoryController {
  @override
  Future<List<Category>> build() async {
    return await ref.read(categoryAPIRepositoryProvider).getCategories();
  }

  Future<Category> addCategory(Category category) async {
    state = const AsyncLoading();
    final categoryRepository = ref.read(categoryAPIRepositoryProvider);
    final createdCategory =
        await AsyncValue.guard(() => categoryRepository.addCategory(category));
    state = await AsyncValue.guard(
        () => ref.read(categoryAPIRepositoryProvider).getCategories());
    if (createdCategory.hasValue) {
      return createdCategory.value!;
    } else {
      return Future.error(createdCategory.error!, createdCategory.stackTrace);
    }
  }

  Future<void> getCategories() async {
    state = const AsyncLoading();
    final categoryRepository = ref.read(categoryAPIRepositoryProvider);
    state = await AsyncValue.guard(() => categoryRepository.getCategories());
  }
}

@riverpod
List<Category>? filteredCategories(FilteredCategoriesRef ref) {
  return ref
      .watch(categoryControllerProvider)
      .value
      ?.where((category) => category.name.contains('A'))
      .toList();
}

@riverpod
class CategoryCreationController extends _$CategoryCreationController {
  @override
  AsyncValue<Category?> build() {
    return const AsyncData(null);
  }

  Future<void> createCategory(Category category) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(categoryControllerProvider.notifier).addCategory(category));
  }
}
