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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZfL-oWUsLDhK7qi3SnMz0I5Mq_0Z8qdI',
    appId: '1:1072736664922:android:5c0eb5be0a2fac95204763',
    messagingSenderId: '1072736664922',
    projectId: 'food-traceability-dapp',
    storageBucket: 'food-traceability-dapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnGO1HfztlulZT56jdacQd2xzz4aRQSG0',
    appId: '1:1072736664922:ios:e2e9dd0dee74a6ae204763',
    messagingSenderId: '1072736664922',
    projectId: 'food-traceability-dapp',
    storageBucket: 'food-traceability-dapp.appspot.com',
    iosClientId: '1072736664922-j5mk442d4e4fb7cvlo9hjtvhmnekg60n.apps.googleusercontent.com',
    iosBundleId: 'com.example.dapp',
  );
}
