import 'package:flutter/material.dart';
import 'package:flutter_application_8_mprime8/constants/routes.dart';
import 'package:flutter_application_8_mprime8/services/auth/auth_service.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_8_mprime8/services/auth/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text(
              'An email verification has been sent to your inbox. Please open it to verify your account.'),
          const Text(
              "If you haven't received a verification email yet, press the buttom below to send a new one."),
          TextButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            child: const Text('Return to register screen'),
          )
        ],
      ),
    );
  }
}
