
import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password reset',
    content: 'We have sent you a password reset link. Please check your email for more information',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}