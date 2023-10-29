import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:small_app_example/features/camera/camera_provider.dart';
import 'package:small_app_example/generated/find_me_pls.pbgrpc.dart';

import 'Constants/constants.dart';
import 'features/grpc_connection/client_provider.dart';
import 'features/routing/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  final channel = ClientChannel(
    hostAddress,
    port: grpcPort,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  runApp(ProviderScope(
    overrides: [
      clientProvider.overrideWithValue(FindMePlsClient(channel)),
      cameraProvider.overrideWithValue(firstCamera),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      title: 'Small App Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      color: Colors.redAccent,
    );
  }
}
