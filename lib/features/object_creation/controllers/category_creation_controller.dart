import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/features/grpc_connection/client_provider.dart';
import '../../../generated/category_types.pb.dart';

part 'category_creation_controller.g.dart';

@riverpod
class CategoryCreationController extends _$CategoryCreationController {
  @override
  FutureOr<Category?> build() async {}

  Future<void> createCategory(Category category) async {
    state = const AsyncLoading();
    try {
      final response = await ref.read(clientProvider).newCategory(category);
      state = AsyncData(response);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
