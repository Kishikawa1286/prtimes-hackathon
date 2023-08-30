import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sora/color_schemes.g.dart';
import 'package:sora/firebase_options.dart';
import 'package:sora/generate_route.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      );
      if (Platform.isAndroid) {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }

      // ユーザーがログインしている場合、ログアウトします。
      // TODO: デバッグ用なので本番では削除する
      final auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        await auth.signOut();
      }

      runApp(
        ProviderScope(
          child: MaterialApp(
            title: 'mathlingo',
            onGenerateRoute: generateRoute,
            initialRoute: 'home',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              fontFamily: 'NotoSansJP',
            ),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          ),
        ),
      );
    },
    (error, stackTrace) async {
      print('runZonedGuarded: Caught error in my root zone.');
      print('error\n$error');
      print('stacktrace\n$stackTrace');
    },
  );
}
