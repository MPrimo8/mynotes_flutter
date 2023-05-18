import 'package:flutter/material.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_8_mprime8/utilities/dialogs/error_dialog.dart';
import 'package:flutter_application_8_mprime8/utilities/dialogs/password_reset_email_sent_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context,
                'We could not process your request. Please make sure that you are a registered user. If you are not an user, register an account by going back one step.');
          }
        }
      }),
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
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  controller: _controller,
                  decoration:
                      const InputDecoration(hintText: 'Your email address...'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    final email = _controller.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventForgotPassword(email: email));
                  },
                  child: const Text('Send password reset email')),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const Text('Back to login page')),
              const Padding(
                padding: EdgeInsets.only(top: 58.0),
                child: Text(
                  'If you forgot your password, simply enter your email and we will send you a password reset link.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
