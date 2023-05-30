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
    apiKey: 'AIzaSyCK_KlG3PLg_fEcM3MgC0Rg6az0pnjozRU',
    appId: '1:669495573297:web:7d78acc7ba8285c2990e10',
    messagingSenderId: '669495573297',
    projectId: 'runningapp-972d6',
    authDomain: 'runningapp-972d6.firebaseapp.com',
    storageBucket: 'runningapp-972d6.appspot.com',
    measurementId: 'G-BZT2C387FC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBaga23UFHN1oeCh0uSRCtesP4lVii5pY',
    appId: '1:669495573297:android:e2cdbc2a766eea29990e10',
    messagingSenderId: '669495573297',
    projectId: 'runningapp-972d6',
    storageBucket: 'runningapp-972d6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-v3ydoomTeErPmIPlyDD5LemrQo4Mywk',
    appId: '1:669495573297:ios:bb8d3c7f155d5b27990e10',
    messagingSenderId: '669495573297',
    projectId: 'runningapp-972d6',
    storageBucket: 'runningapp-972d6.appspot.com',
    iosClientId: '669495573297-b65frplflftojemld9idtlbdps3tqbat.apps.googleusercontent.com',
    iosBundleId: 'com.example.newApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-v3ydoomTeErPmIPlyDD5LemrQo4Mywk',
    appId: '1:669495573297:ios:bb8d3c7f155d5b27990e10',
    messagingSenderId: '669495573297',
    projectId: 'runningapp-972d6',
    storageBucket: 'runningapp-972d6.appspot.com',
    iosClientId: '669495573297-b65frplflftojemld9idtlbdps3tqbat.apps.googleusercontent.com',
    iosBundleId: 'com.example.newApp',
  );
}