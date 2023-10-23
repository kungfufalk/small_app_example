import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:small_app_example/Constants/constants.dart';
import 'package:small_app_example/object_creation/widgets/item_creation_view.dart';
import 'package:small_app_example/features/camera/camera_provider.dart';
import 'package:small_app_example/generated/find_me_pls.pbgrpc.dart';
import 'package:small_app_example/features/grpc_connection/client_provider.dart';

import 'features/routing/app_routes.dart';

Future<void> main() async {
  final channel = ClientChannel(
    hostAddress,
    port: grpcPort,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  final stub = FindMePlsClient(channel);

  await channel.shutdown();

  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(ProviderScope(
    overrides: [
      clientProvider.overrideWithValue(stub),
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
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: ItemCreationView(),
    );
    // return MaterialApp.router(
    //   routerConfig: routerConfig,
    //   title: 'Flutter Demo',
    //   darkTheme: ThemeData.dark(useMaterial3: true),
    //   // theme: ThemeData(
    //   //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //   //   useMaterial3: true,
    //   //   textTheme: GoogleFonts.robotoTextTheme(),
    //   // ),
    //   color: Colors.redAccent,
    // );
  }
}
