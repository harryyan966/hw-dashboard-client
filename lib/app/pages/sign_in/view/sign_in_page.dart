import 'package:client/app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:general_utilities/general_utilities.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  // TODO(xiru): change all blocbuilders to build on demand
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(clientAuth: context.read())..add(const LoadPage()),
      child: BlocConsumer<SignInBloc, SignInState>(
        listenWhen: (previous, current) => current.status == SignInStatus.signedIn,
        listener: (context, state) => context.pushNamed('home'),
        builder: (context, state) {
          return switch (state.status) {
            SignInStatus.loading => const LoadingPage(),
            SignInStatus.loaded => SignInView(state: state),
            SignInStatus.error => ErrorPage(errorMessage: state.errorMessage),
            SignInStatus.signedIn => const LoadingPage()
          };
        },
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({required this.state, super.key});

  final SignInState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HW Dashboard',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Space.space80),
        child: Row(
          children: [
            Expanded(child: Image.asset('assets/sample.png')),
            const SizedBox(width: Space.space60),
            const Expanded(child: SignInForm()),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign In', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: Space.space40),
          FormBuilderTextField(
            name: 'username',
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Username'),
            validator: (value) => nameValidator(value ?? ''),
          ),
          const SizedBox(height: Space.space24),
          FormBuilderTextField(
            name: 'password',
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
            obscureText: true,
            validator: (value) => passwordValidator(value ?? ''),
          ),
          const SizedBox(height: Space.space40),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.saveAndValidate();
              if (_formKey.currentState!.validate()) {
                final values = _formKey.currentState!.value;
                final username = values.get<String>('username');
                final password = values.get<String>('password');
                context.read<SignInBloc>().add(SignIn(username: username, password: password));
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
