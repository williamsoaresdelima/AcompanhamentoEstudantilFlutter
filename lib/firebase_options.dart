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
    apiKey: 'AIzaSyDGbRWNBFXQ2WOW_92bZ776XV0txjk85ao',
    appId: '1:193057558598:web:394de11a071d0eff583a47',
    messagingSenderId: '193057558598',
    projectId: 'acomestudantilflutter',
    authDomain: 'acomestudantilflutter.firebaseapp.com',
    storageBucket: 'acomestudantilflutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7yEWcVBbLMJH5bT7kysoPSMUZG3C3EgU',
    appId: '1:193057558598:android:3d62ccedaffa832b583a47',
    messagingSenderId: '193057558598',
    projectId: 'acomestudantilflutter',
    storageBucket: 'acomestudantilflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEK4iLL_ik31HIDjfaAcxnPrkWZ0KRDds',
    appId: '1:193057558598:ios:c922272017d4b5d5583a47',
    messagingSenderId: '193057558598',
    projectId: 'acomestudantilflutter',
    storageBucket: 'acomestudantilflutter.appspot.com',
    iosClientId: '193057558598-064n2kk0l59rn3flrtanvb3tlvjdicjs.apps.googleusercontent.com',
    iosBundleId: 'br.ace.lima.acompanhamentoEstudantil',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEK4iLL_ik31HIDjfaAcxnPrkWZ0KRDds',
    appId: '1:193057558598:ios:c922272017d4b5d5583a47',
    messagingSenderId: '193057558598',
    projectId: 'acomestudantilflutter',
    storageBucket: 'acomestudantilflutter.appspot.com',
    iosClientId: '193057558598-064n2kk0l59rn3flrtanvb3tlvjdicjs.apps.googleusercontent.com',
    iosBundleId: 'br.ace.lima.acompanhamentoEstudantil',
  );
}
