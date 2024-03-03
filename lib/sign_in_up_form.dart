import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUpForm extends StatefulWidget {
  const SignInUpForm({super.key});

  @override
  State<SignInUpForm> createState() => _SignInUpFormState();
}

class _SignInUpFormState extends State<SignInUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _firebaseErrorCode;

  void _onSignUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      setState(() {
        _firebaseErrorCode = null;
      });
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      //Check if user has document, if not create one
      if (userId != null) {
        var userDoc = await FirebaseFirestore.instance
            .collection('sharedcount')
            .doc(userId)
            .get();
        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('sharedcount')
              .doc(userId)
              .set({
            'dedicationLevel': 0,
            'totalPoints': 0,
            'userID': userId,
            'email': _usernameController.text,
          });
        }
      }
    } on FirebaseAuthException catch (ex) {
      print(ex.code);
      print(ex.message);
      setState(() {
        _firebaseErrorCode = ex.code;
      });
    }
  }

  Future<void> _onSignIn() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _usernameController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                icon: Icon(Icons.verified_user), labelText: 'Username'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: const InputDecoration(
                icon: Icon(Icons.enhanced_encryption), labelText: 'Password'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _onSignUp,
            child: const Text("Sign Up"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _onSignIn,
            child: const Text('Sign in'),
          ),
          if (_firebaseErrorCode != null) Text(_firebaseErrorCode!),
        ],
      ),
    );
  }
}
