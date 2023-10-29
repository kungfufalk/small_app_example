import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../generated/find_me_pls.pbgrpc.dart';

part 'client_provider.g.dart';

///Todo: Check if grpc client is connected

@Riverpod(keepAlive: true)
FindMePlsClient? client(ClientRef ref) {
  return null;
}
