import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verrify Email')),
      body: Column(children: [
        Text(
            'We have sent you an email for verification, please open it to verify your account'),
        Text(
            'If you have not received email for verification, press button below'),
        TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                    const AuthEventSendEmailVerification(),
                  );
            },
            child: Text('Send email verification')),
        TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                const AuthEventLogout(),
              );
            },
            child: Text('Restart')),
      ]),
    );
  }
}
