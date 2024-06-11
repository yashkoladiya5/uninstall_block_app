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
    apiKey: 'AIzaSyAyFbespN0dky8VF9NTuX5l2b4-vaNKO4k',
    appId: '1:227513476886:web:21203da0973f90efc2d237',
    messagingSenderId: '227513476886',
    projectId: 'telecallingme',
    authDomain: 'telecallingme.firebaseapp.com',
    storageBucket: 'telecallingme.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyBnFnauO9_8i-11VUmqY9ebCH3SyRKxc',
    appId: '1:227513476886:android:3b19fd787419310fc2d237',
    messagingSenderId: '227513476886',
    projectId: 'telecallingme',
    storageBucket: 'telecallingme.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIvrvlVXHUoOXpEX_deODsqunAo1W4mJM',
    appId: '1:227513476886:ios:567a4a77798fd842c2d237',
    messagingSenderId: '227513476886',
    projectId: 'telecallingme',
    storageBucket: 'telecallingme.appspot.com',
    iosBundleId: 'com.app.telecalling',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIvrvlVXHUoOXpEX_deODsqunAo1W4mJM',
    appId: '1:227513476886:ios:567a4a77798fd842c2d237',
    messagingSenderId: '227513476886',
    projectId: 'telecallingme',
    storageBucket: 'telecallingme.appspot.com',
    iosBundleId: 'com.app.telecalling',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAyFbespN0dky8VF9NTuX5l2b4-vaNKO4k',
    appId: '1:227513476886:web:acc69c6544d4803cc2d237',
    messagingSenderId: '227513476886',
    projectId: 'telecallingme',
    authDomain: 'telecallingme.firebaseapp.com',
    storageBucket: 'telecallingme.appspot.com',
  );
}
