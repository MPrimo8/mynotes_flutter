import 'package:flutter/material.dart';

import 'package:flutter_application_8_mprime8/services/auth/auth_exceptions.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_state.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context,
                'Cannot find a user associated with the entered email');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/icon/icon.png'),
              ),
              const Text(
                'MyNotes',
                style: TextStyle(fontSize: 40, fontFamily: 'DancingScript'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextField(
                  controller: _email,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventLogIn(email, password));
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () => {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventForgotPassword())
                      },
                  child: const Text('I forgot my password')),
              TextButton(
                  onPressed: () => {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventShouldRegister())
                      },
                  child: const Text('Not registered yet? Register here!')),
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                    'Log in to your account in order to manage your notes!',
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
