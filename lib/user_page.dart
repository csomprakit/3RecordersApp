import 'package:flutter/material.dart';
import 'sign_in_up_form.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text('User Page',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
      body: SignInUpForm(),
    );
  }
}
