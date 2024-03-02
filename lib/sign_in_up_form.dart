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
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 15),
          ElevatedButton(child: Text("Sign Up"),
              onPressed: (){},
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Sign in'),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
