import 'package:flutter/material.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
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
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                  "An email verification has been sent to your inbox. Please open it to verify your account. Once you've done that, return to the login screen.",
                  textAlign: TextAlign.center),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                  "If you haven't received a verification email yet, press the buttom below to send a new one.",
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(const AuthEventSendEmailVerification());
                },
                child: const Text('Send email verification'),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text('Return to login screen'),
            )
          ],
        ),
      ),
    );
  }
}
