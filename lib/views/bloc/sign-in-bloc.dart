import 'package:auth_bloc/views/bloc/sign-in-event.dart';
import 'package:auth_bloc/views/bloc/sign-in-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (event.emailValue.isEmpty || !event.emailValue.contains('@')) {
        emit(SignInErrorState('Invalid Email'));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState('Password must be of minimum 8 characters long'));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
