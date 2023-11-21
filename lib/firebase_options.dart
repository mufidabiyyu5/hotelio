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
    apiKey: 'AIzaSyB1S-ENtYCzWzXS0CAdUKVIsbfw8SMQlLE',
    appId: '1:551911220516:web:4880dc067abc4686cdffb1',
    messagingSenderId: '551911220516',
    projectId: 'hotelio-3793e',
    authDomain: 'hotelio-3793e.firebaseapp.com',
    storageBucket: 'hotelio-3793e.appspot.com',
    measurementId: 'G-BF36D7T41Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOIIfk2zPMQXYp9Q33HmlQSngzJ4yzIP8',
    appId: '1:551911220516:android:07ca691fb85f23c9cdffb1',
    messagingSenderId: '551911220516',
    projectId: 'hotelio-3793e',
    storageBucket: 'hotelio-3793e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkYORk9rOClPyuzejjBKsEAmeQg77O1U4',
    appId: '1:551911220516:ios:170022b5e5db3ed4cdffb1',
    messagingSenderId: '551911220516',
    projectId: 'hotelio-3793e',
    storageBucket: 'hotelio-3793e.appspot.com',
    iosBundleId: 'com.hotelio.hotelio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkYORk9rOClPyuzejjBKsEAmeQg77O1U4',
    appId: '1:551911220516:ios:f5a589859509cf64cdffb1',
    messagingSenderId: '551911220516',
    projectId: 'hotelio-3793e',
    storageBucket: 'hotelio-3793e.appspot.com',
    iosBundleId: 'com.hotelio.hotelio.RunnerTests',
  );
}
