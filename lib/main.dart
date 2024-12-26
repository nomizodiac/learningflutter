import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_state.dart';
import 'package:flutter_application_1/services/auth/firebase_auth_provider.dart';
import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/notes/create_update_note_view.dart';
import 'package:flutter_application_1/views/notes/notes_view.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/routes.dart';
import 'views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
    ),
    home: BlocProvider(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/*class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBlock(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Testing Bloc')),
        body: BlocConsumer<CounterBlock, CounterState>(
          listener: (context, state) {
            _controller.clear();
          },
          builder: (context, state) {
            final invalidValue =
                (state is CounterStateInValidNumber) ? state.invalidValue : '';
            return Column(
              children: [
                Text('Current value: ${state.value}'),
                Visibility(
                  visible: state is CounterStateInValidNumber,
                  child: Text('Invalid Input:$invalidValue'),
                ),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: "Enter a number"),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    TextButton(onPressed: () {
                      context.read<CounterBlock>().add(DecrementEvent(_controller.text));
                    }, child: Text('-')),
                    TextButton(onPressed: () {
                      context.read<CounterBlock>().add(IncrementEvent(_controller.text));
                    }, child: Text('+'))
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;

  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}

class CounterStateInValidNumber extends CounterState {
  final String invalidValue;

  const CounterStateInValidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;

  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(String value) : super(value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(String value) : super(value);
}

class CounterBlock extends Bloc<CounterEvent, CounterState> {
  CounterBlock() : super(const CounterStateValid(0)) {
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInValidNumber(
            invalidValue: event.value, previousValue: state.value));
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    });
    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInValidNumber(
            invalidValue: event.value, previousValue: state.value));
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}*/
