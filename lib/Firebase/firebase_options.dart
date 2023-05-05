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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDpgYG5jDUvE6Xv88OVt_92z03MEfDEanU',
    appId: '1:383934728885:web:6f8c783611454784958cfc',
    messagingSenderId: '383934728885',
    projectId: 'authentication-test-72ab6',
    authDomain: 'authentication-test-72ab6.firebaseapp.com',
    databaseURL: 'https://authentication-test-72ab6-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-test-72ab6.appspot.com',
    measurementId: 'G-NZ1BJW3VNR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7ytd3pmtt_NC49IMV_NOtHxfUSEqDyrI',
    appId: '1:383934728885:android:00ca45ede32da1d8958cfc',
    messagingSenderId: '383934728885',
    projectId: 'authentication-test-72ab6',
    databaseURL: 'https://authentication-test-72ab6-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-test-72ab6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcRuE0oa5nn-I4QAQ_1wSquVae89swT08',
    appId: '1:383934728885:ios:a65fd854dc46731a958cfc',
    messagingSenderId: '383934728885',
    projectId: 'authentication-test-72ab6',
    databaseURL: 'https://authentication-test-72ab6-default-rtdb.firebaseio.com',
    storageBucket: 'authentication-test-72ab6.appspot.com',
    iosClientId: '383934728885-7amq1g2p8b1m98h6h5288rghtvp2pdnj.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAuthentication',
  );
}
