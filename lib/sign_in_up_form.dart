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
  String _message = '';
  bool _isLogin = true;
  String? _firebaseErrorCode;


  void _onSignIn() async
  {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      setState(() {
        _firebaseErrorCode = null;
      });
    } on FirebaseAuthException catch (ex) {
      print(ex.code);
      print(ex.message);
      setState(() {
        _firebaseErrorCode = ex.code;
      });
    }
  }

  void _onSignUp()
  {
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
            decoration: InputDecoration( icon: Icon(Icons.verified_user),
          labelText: 'Username'),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration( icon:
            Icon(Icons.enhanced_encryption), labelText: 'Password'),
          ),
          SizedBox(height: 15),
          ElevatedButton(child: Text("Sign Up"),
              onPressed: _onSignUp,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Sign in'),
            onPressed: _onSignIn,
          ),
          if (_firebaseErrorCode != null) Text(_firebaseErrorCode!),
        ],
      ),
    );
  }
}
