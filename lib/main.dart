import "dart:async";
import "dart:developer";
import 'dart:io';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:water_shader/core/utils/index.dart';

import 'app.dart';

class BetterHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient httpClient = super.createHttpClient(context);
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    httpClient.maxConnectionsPerHost = 5;
    return httpClient;
  }
}

Future<void> initServices() async {
  HttpOverrides.global = BetterHttpOverrides();

  await Future.wait(
    <Future<dynamic>>[
      StorageUtil.init(),
    ],
  );
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      debugPrint = (String? message, {int? wrapWidth}) {
        if (kDebugMode) {
          log(message.toString());
        }
      };

      await initServices();

      SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
        (_) {
          runApp(
            const WaterShaderApp(),
          );
        },
      );
    },
    (Object error, StackTrace stack) {
      debugPrint("AppError: $error\nStackTrace: $stack");
    },
  );
}
