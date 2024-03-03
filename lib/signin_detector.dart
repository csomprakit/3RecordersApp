import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sign_in_up_form.dart';
import 'leaderboard_page.dart';

class SignInDetector extends StatelessWidget {
  const SignInDetector({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print("Auth state change: $snapshot");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData && snapshot.data != null) {
          print("User signed in. Email: ${snapshot.data!.email}");
          return const LeaderboardPage();
        }
        print("User not signed in. Showing SignInUpForm.");
        return const SignInUpForm();
      },
    );
  }
}
