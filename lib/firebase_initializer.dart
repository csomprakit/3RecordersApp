import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin_detector.dart';

class FirebaseInitializer extends StatelessWidget {
  const FirebaseInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot){
        if(snapshot.hasData)
        {
          print("Firebase initialization successful");
          return const SignInDetector();
        }
        else if(snapshot.hasError) {
          print("Firebase initialization error: ${snapshot.error}");
          return const Text('Oh no! You can\'t connect to Firebase.');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
