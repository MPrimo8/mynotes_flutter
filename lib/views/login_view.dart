import 'package:flutter/material.dart';

import 'package:flutter_application_8_mprime8/constants/routes.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_exceptions.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_service.dart';
import 'package:flutter_application_8_mprime8/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  void signIn(String email, String password) async {
    try {
      await AuthService.firebase().logIn(email: email, password: password);
      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          notesRoute,
          (route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          verifyEmailRoute,
          (route) => false,
        );
      }
    } on UserNotFoundAuthException {
      await showErrorDialog(context, 'No user associated to that email');
    } on WrongPasswordAuthException {
      await showErrorDialog(context, 'Wrong password entered');
    } on GenericAuthException {
      await showErrorDialog(context, 'Authentication error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              onPressed: () => signIn(_email.text, _password.text),
              child: const Text('Login')),
          TextButton(
              onPressed: () => {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false)
                  },
              child: const Text('Not registered yet? Register here!')),
        ],
      ),
    );
  }
}
