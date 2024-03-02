import 'package:flutter/material.dart';

class SignInUpForm extends StatefulWidget {
  const SignInUpForm({super.key});

  @override
  State<SignInUpForm> createState() => _SignInUpFormState();
}

class _SignInUpFormState extends State<SignInUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Username:'),
          TextField(
            controller: _usernameController,
          ),
          Text('Password:'),
          TextField(
            controller: _passwordController,
          ),
          ElevatedButton(child: Text("Sign Up"),
              onPressed: (){},
          ),
          ElevatedButton(
            child: const Text('Sign in'),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
