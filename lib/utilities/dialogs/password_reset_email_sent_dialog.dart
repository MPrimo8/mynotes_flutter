import 'package:flutter/material.dart';
import 'package:flutter_application_8_mprime8/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have sent you a password reset link. Please check your email for more information.',
    optionBuilder: () => {
      'Ok': null,
    },
  );
}
