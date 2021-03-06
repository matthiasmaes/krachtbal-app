// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB_8y6TE2S0TWJuuKBCDVGDWu8gD8bnUZU',
    appId: '1:37290786317:web:71f6534fdfd79e114c5f44',
    messagingSenderId: '37290786317',
    projectId: 'krachtbal-klaverken',
    authDomain: 'krachtbal-klaverken.firebaseapp.com',
    storageBucket: 'krachtbal-klaverken.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDD5Rq--ruKnU-hfIQiaoNgtCHk-0ggZ6s',
    appId: '1:37290786317:android:d763072716ee59a54c5f44',
    messagingSenderId: '37290786317',
    projectId: 'krachtbal-klaverken',
    storageBucket: 'krachtbal-klaverken.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyo5648q5oVCttcrlV_mZWRIbXNqa5ZWw',
    appId: '1:37290786317:ios:bf32fee6eec5ef734c5f44',
    messagingSenderId: '37290786317',
    projectId: 'krachtbal-klaverken',
    storageBucket: 'krachtbal-klaverken.appspot.com',
    iosClientId: '37290786317-c1dkff3bebqc7fpfq8g0vm23upckutmf.apps.googleusercontent.com',
    iosBundleId: 'com.matthiasmaes.krachtbal',
  );
}
