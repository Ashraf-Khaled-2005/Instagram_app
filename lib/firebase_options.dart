// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAdKF5Dnk-7tK6YDyysfSsaQzonBCYkjqI',
    appId: '1:922614266117:web:de2d3df5379cc901f65f6c',
    messagingSenderId: '922614266117',
    projectId: 'instagram-52b06',
    authDomain: 'instagram-52b06.firebaseapp.com',
    storageBucket: 'instagram-52b06.appspot.com',
    measurementId: 'G-W44RSREQVQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaMd67OvHEOhhOJnS6rXDRpnS9swAlCuA',
    appId: '1:922614266117:android:ae23eb45c18b9c09f65f6c',
    messagingSenderId: '922614266117',
    projectId: 'instagram-52b06',
    storageBucket: 'instagram-52b06.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfqfWs7aDuynwBJw7kBs_Gf2kqJWmH-MI',
    appId: '1:922614266117:ios:6f5d96c7139c3902f65f6c',
    messagingSenderId: '922614266117',
    projectId: 'instagram-52b06',
    storageBucket: 'instagram-52b06.appspot.com',
    iosBundleId: 'com.example.instagramApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfqfWs7aDuynwBJw7kBs_Gf2kqJWmH-MI',
    appId: '1:922614266117:ios:6f5d96c7139c3902f65f6c',
    messagingSenderId: '922614266117',
    projectId: 'instagram-52b06',
    storageBucket: 'instagram-52b06.appspot.com',
    iosBundleId: 'com.example.instagramApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAdKF5Dnk-7tK6YDyysfSsaQzonBCYkjqI',
    appId: '1:922614266117:web:3b0c0fc1399327aff65f6c',
    messagingSenderId: '922614266117',
    projectId: 'instagram-52b06',
    authDomain: 'instagram-52b06.firebaseapp.com',
    storageBucket: 'instagram-52b06.appspot.com',
    measurementId: 'G-DJ52PY0Z5L',
  );
}
