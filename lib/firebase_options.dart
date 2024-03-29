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
    apiKey: 'AIzaSyA3bcJ8LgGh3zfcZwV-u1g-Df0CANWq500',
    appId: '1:89037691986:web:9ee12fd5d869d29bf3938b',
    messagingSenderId: '89037691986',
    projectId: 'flutter-storyselectionapp',
    authDomain: 'flutter-storyselectionapp.firebaseapp.com',
    storageBucket: 'flutter-storyselectionapp.appspot.com',
    measurementId: 'G-K3PH9Y581C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAXh7udfztgF1KIQUdQhSCxcsF8TiQO4Y',
    appId: '1:89037691986:android:f6c962fcb9e5b679f3938b',
    messagingSenderId: '89037691986',
    projectId: 'flutter-storyselectionapp',
    storageBucket: 'flutter-storyselectionapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDL2hVlvwOhIf0T9krwCTT_NPEanSyOhgA',
    appId: '1:89037691986:ios:27e3395abdb729fef3938b',
    messagingSenderId: '89037691986',
    projectId: 'flutter-storyselectionapp',
    storageBucket: 'flutter-storyselectionapp.appspot.com',
    iosBundleId: 'com.example.example7',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDL2hVlvwOhIf0T9krwCTT_NPEanSyOhgA',
    appId: '1:89037691986:ios:d765db0f9756775ef3938b',
    messagingSenderId: '89037691986',
    projectId: 'flutter-storyselectionapp',
    storageBucket: 'flutter-storyselectionapp.appspot.com',
    iosBundleId: 'com.example.example7.RunnerTests',
  );
}
