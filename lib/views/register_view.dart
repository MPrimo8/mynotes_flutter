import 'package:flutter/material.dart';

import 'package:flutter_application_8_mprime8/constants/routes.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_exceptions.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_service.dart';
import 'package:flutter_application_8_mprime8/utilities/show_error_dialog.dart';

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
      await AuthService.firebase().createUser(email: email, password: password);
      AuthService.firebase().sendEmailVerification();
      Navigator.of(context).pushNamed(verifyEmailRoute);
    } on WeakPasswordAuthException {
      await showErrorDialog(context, 'Weak password');
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(context, 'Email is already in use');
    } on InvalidEmailAuthException {
      await showErrorDialog(context, 'Invalid email address');
    } on GenericAuthException {
      await showErrorDialog(context, 'Authentication error');
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
              onPressed: () {
                signUp(_email.text, _password.text);
              },
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
