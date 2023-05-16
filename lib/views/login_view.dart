import 'package:flutter/material.dart';

import 'package:flutter_application_8_mprime8/constants/routes.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_exceptions.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_service.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_8_mprime8/utilities/dialogs/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  context.read<AuthBloc>().add(AuthEventLogIn(email, password));
                } on UserNotFoundAuthException {
                  await showErrorDialog(
                      context, 'No user associated to that email');
                } on WrongPasswordAuthException {
                  await showErrorDialog(context, 'Wrong password entered');
                } on GenericAuthException {
                  await showErrorDialog(context, 'Authentication error');
                }
              },
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
