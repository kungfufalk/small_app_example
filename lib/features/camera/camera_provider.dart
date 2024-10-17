import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_provider.g.dart';

@riverpod
CameraDescription? camera(CameraRef ref) {
  return null;
}

@riverpod
class PicturePath extends _$PicturePath {
  @override
  String? build() {
    return null;
  }
  void setPath(String path) {
    state = path;
  }
  void clearPath() {
    state = null;
  }
}