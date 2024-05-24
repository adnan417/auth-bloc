import 'package:auth_bloc/views/bloc/sign-in-bloc.dart';
import 'package:auth_bloc/views/bloc/sign-in-event.dart';
import 'package:auth_bloc/views/bloc/sign-in-state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScaffold extends StatelessWidget {
  const SignInScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerEmail = TextEditingController();
    TextEditingController _controllerPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
                controller: _controllerEmail,
                onChanged: (value) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangedEvent(
                        _controllerEmail.text, _controllerPassword.text),
                  );
                },
                decoration: InputDecoration(hintText: "Email Address")),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _controllerPassword,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(
                  SignInTextChangedEvent(
                      _controllerEmail.text, _controllerPassword.text),
                );
              },
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if (state is SignInValidState) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SignInBloc>(context).add(
                            SignInSubmittedEvent(_controllerEmail.text,
                                _controllerPassword.text));
                      },
                      child: Text('Sign In'),
                    );
                  } else if (state is SignInLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const ElevatedButton(
                      onPressed: null,
                      child: Text('Sign In'),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
