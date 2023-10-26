import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Constants/constants.dart';
import '../../generated/find_me_pls.pbgrpc.dart';

part 'client_provider.g.dart';

@Riverpod(keepAlive: true)
FindMePlsClient client(ClientRef ref) {
  final channel = ClientChannel(
    hostAddress,
    port: grpcPort,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  channel.shutdown();
  return FindMePlsClient(channel);
}
