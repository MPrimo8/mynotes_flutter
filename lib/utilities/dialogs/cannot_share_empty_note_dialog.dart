import 'package:flutter/material.dart';
import 'package:flutter_application_8_mprime8/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note!',
    optionBuilder: () => {
      'Ok': null,
    },
  );
}
