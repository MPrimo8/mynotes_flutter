import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:flutter_application_8_mprime8/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void signUp(String email, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      devtools.log(credentials.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        devtools.log('Weak password');
      } else if (e.code == 'email-already-in-use') {
        devtools.log('Email already registered');
      } else if (e.code == 'invalid-email') {
        devtools.log('Invalid email entered');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextButton(
              onPressed: () => signUp(_email.text, _password.text),
              child: const Text('Register')),
          TextButton(
              onPressed: () => {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false),
                  },
              child: const Text('Already registered? Login here!')),
        ],
      ),
    );
  }
}
