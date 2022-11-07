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
    apiKey: 'AIzaSyD4-0q8wSalqTfTW1MrgVkYkq3tqUtNl7g',
    appId: '1:549601478533:web:624d8591f736d48576e6ec',
    messagingSenderId: '549601478533',
    projectId: 'shikisha-63928',
    authDomain: 'shikisha-63928.firebaseapp.com',
    storageBucket: 'shikisha-63928.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPnfXi1mLAllCx8hEufZZvzJw04n1rfJw',
    appId: '1:549601478533:android:f17d7393ad7f0c3676e6ec',
    messagingSenderId: '549601478533',
    projectId: 'shikisha-63928',
    storageBucket: 'shikisha-63928.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCY7rPxJQ4-f0R_C4uiTZeQ5qCqoTUH3V8',
    appId: '1:549601478533:ios:2a97a369d22b4fbe76e6ec',
    messagingSenderId: '549601478533',
    projectId: 'shikisha-63928',
    storageBucket: 'shikisha-63928.appspot.com',
    androidClientId: '549601478533-nr70r0o6fv9uddhrjcvipn484a2gn279.apps.googleusercontent.com',
    iosClientId: '549601478533-8eds0303miqccsdapuposvebumk65e6c.apps.googleusercontent.com',
    iosBundleId: 'com.example.shikishaseller',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCY7rPxJQ4-f0R_C4uiTZeQ5qCqoTUH3V8',
    appId: '1:549601478533:ios:2a97a369d22b4fbe76e6ec',
    messagingSenderId: '549601478533',
    projectId: 'shikisha-63928',
    storageBucket: 'shikisha-63928.appspot.com',
    androidClientId: '549601478533-nr70r0o6fv9uddhrjcvipn484a2gn279.apps.googleusercontent.com',
    iosClientId: '549601478533-8eds0303miqccsdapuposvebumk65e6c.apps.googleusercontent.com',
    iosBundleId: 'com.example.shikishaseller',
  );
}
