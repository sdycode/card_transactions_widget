import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDnWCTjWq5aBAAduDxPljjHyPePHC4AD6A',
    appId: '1:49513463331:web:9be4371963137fd4c67b96',
    messagingSenderId: '49513463331',
    projectId: 'transaction-2a585',
    authDomain: 'transaction-2a585.firebaseapp.com',
    storageBucket: 'transaction-2a585.firebasestorage.app',
    measurementId: 'G-9WPN3M0Z1G',
    databaseURL:
        'https://transaction-2a585-default-rtdb.asia-southeast1.firebasedatabase.app', // Updated URL
  );

  // static const FirebaseOptions android = FirebaseOptions(
  //   apiKey: 'AIzaSyCJjvtbSxg67UqYDmzxAzkjpWXh18Syxj0',
  //   appId: '1:49513463331:android:ed248f732caceb02c67b96',
  //   messagingSenderId: '49513463331',
  //   projectId: 'transaction-2a585',
  //   storageBucket: 'transaction-2a585.firebasestorage.app',
  //   databaseURL:
  //       'https://transaction-2a585-default-rtdb.asia-southeast1.firebasedatabase.app', // Updated URL
  // );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJjvtbSxg67UqYDmzxAzkjpWXh18Syxj0',
    appId: '1:49513463331:android:ed248f732caceb02c67b96',
    messagingSenderId: '49513463331',
    projectId: 'transaction-2a585',
    storageBucket: 'transaction-2a585.firebasestorage.app',
    databaseURL:
        'https://transaction-2a585-default-rtdb.asia-southeast1.firebasedatabase.app', // Updated URL
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjeEAejn7aegyWsNa8H4ZTueyQqt-gdWE',
    appId: '1:49513463331:ios:f29957b9418515b9c67b96',
    messagingSenderId: '49513463331',
    projectId: 'transaction-2a585',
    storageBucket: 'transaction-2a585.firebasestorage.app',
    iosBundleId: 'com.example.transcationHistory',
    databaseURL:
        'https://transaction-2a585-default-rtdb.asia-southeast1.firebasedatabase.app', // Updated URL
  );
}
// // File generated by FlutterFire CLI.
// // ignore_for_file: type=lint
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions web = FirebaseOptions(
//     apiKey: 'AIzaSyDnWCTjWq5aBAAduDxPljjHyPePHC4AD6A',
//     appId: '1:49513463331:web:9be4371963137fd4c67b96',
//     messagingSenderId: '49513463331',
//     projectId: 'transaction-2a585',
//     authDomain: 'transaction-2a585.firebaseapp.com',
//     storageBucket: 'transaction-2a585.firebasestorage.app',
//     measurementId: 'G-9WPN3M0Z1G',
//   );

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyCJjvtbSxg67UqYDmzxAzkjpWXh18Syxj0',
//     appId: '1:49513463331:android:ed248f732caceb02c67b96',
//     messagingSenderId: '49513463331',
//     projectId: 'transaction-2a585',
//     storageBucket: 'transaction-2a585.firebasestorage.app',
//   );

//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyDjeEAejn7aegyWsNa8H4ZTueyQqt-gdWE',
//     appId: '1:49513463331:ios:f29957b9418515b9c67b96',
//     messagingSenderId: '49513463331',
//     projectId: 'transaction-2a585',
//     storageBucket: 'transaction-2a585.firebasestorage.app',
//     iosBundleId: 'com.example.transcationHistory',
//   );
// }
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint