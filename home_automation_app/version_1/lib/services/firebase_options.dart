// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDQ9LV24Tz5B6OiyPk6__s91p2rgxXLFcY',
    appId: '1:1039177525786:web:0cc99dbb819f0d103e3fa3',
    messagingSenderId: '1039177525786',
    projectId: 'version-01-439f2',
    authDomain: 'version-01-439f2.firebaseapp.com',
    databaseURL: 'https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'version-01-439f2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5EllEpnbt7PtsyjcVV1OpzhvZn7V5f4I',
    appId: '1:1039177525786:android:c9105b1011e9ebae3e3fa3',
    messagingSenderId: '1039177525786',
    projectId: 'version-01-439f2',
    databaseURL: 'https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'version-01-439f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIff_9epXh2tDoRJTdv9ku3rQazedaxfM',
    appId: '1:1039177525786:ios:ac08a374cf47e0223e3fa3',
    messagingSenderId: '1039177525786',
    projectId: 'version-01-439f2',
    databaseURL: 'https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'version-01-439f2.appspot.com',
    iosBundleId: 'com.example.version1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIff_9epXh2tDoRJTdv9ku3rQazedaxfM',
    appId: '1:1039177525786:ios:0f5036aefaa9c0493e3fa3',
    messagingSenderId: '1039177525786',
    projectId: 'version-01-439f2',
    databaseURL: 'https://version-01-439f2-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'version-01-439f2.appspot.com',
    iosBundleId: 'com.example.version1.RunnerTests',
  );
}