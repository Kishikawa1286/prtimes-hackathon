// ignore_for_file: avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:sora/env.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }

    if (defaultTargetPlatform == TargetPlatform.macOS) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for macos - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }

    if (defaultTargetPlatform == TargetPlatform.windows) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for windows - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }

    if (defaultTargetPlatform == TargetPlatform.linux) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for linux - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }

    if (flavor == 'prod') {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return androidProd;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return iosProd;
      }
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return androidDev;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return iosDev;
      }
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions androidProd = FirebaseOptions(
    apiKey: 'AIzaSyDIHolBWCTIU6ztMZK_dPCbcaT9-zFtGNQ',
    appId: '1:834392061325:android:5df659c06360f84cd6b9c4',
    messagingSenderId: '834392061325',
    projectId: 'sora-prod-kam',
    storageBucket: 'sora-prod-kam.appspot.com',
  );

  static const FirebaseOptions iosProd = FirebaseOptions(
    apiKey: 'AIzaSyD4efEXqlbtKEsMQBuV80bEufMXzjXwlNY',
    appId: '1:834392061325:ios:4552542b4c16802dd6b9c4',
    messagingSenderId: '834392061325',
    projectId: 'sora-prod-kam',
    storageBucket: 'sora-prod-kam.appspot.com',
    iosBundleId: 'com.kamachokkai.sora',
  );

  static const FirebaseOptions androidDev = FirebaseOptions(
    apiKey: 'AIzaSyBzvrA5oNFihqDBDwzTwAdheecR4rUHYk8',
    appId: '1:424089261888:android:e78f951b66e2781f6e0ca5',
    messagingSenderId: '424089261888',
    projectId: 'sora-dev-kam',
    storageBucket: 'sora-dev-kam.appspot.com',
  );

  static const FirebaseOptions iosDev = FirebaseOptions(
    apiKey: 'AIzaSyDTXHOqVg_TxQ7Vgsh8DMl1FGt6RIybfwc',
    appId: '1:424089261888:ios:f26f014ff1c936606e0ca5',
    messagingSenderId: '424089261888',
    projectId: 'sora-dev-kam',
    storageBucket: 'sora-dev-kam.appspot.com',
    iosBundleId: 'com.kamachokkai.sora.dev',
  );
}
