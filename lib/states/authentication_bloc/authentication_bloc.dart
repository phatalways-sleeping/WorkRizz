import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/exceptions/authenticate_exception.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._applicationRepository)
      : super(const StartingState()) {
    on<LoginEvent>((event, emit) {
      emit(const AuthenticationBySignInState());
    });
    on<SignUpEvent>((event, emit) {
      emit(const AuthenticationBySignUpState());
    });
    on<ForgetPasswordEvent>((event, emit) {
      emit(const ForgetPasswordState());
    });
    on<RequestForgetPasswordEvent>(_requestForgetPassword);
    on<RequestSignupEvent>(_requestSignUp);
    on<RequestSigninEvent>(_requestSignIn);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _requestForgetPassword(event, emit) async {
    try {
      emit(const ForgetPasswordProgressingState());

      if (event.email.isEmpty) {
        emit(const FailureForgetPasswordState('EMAIL IS EMPTY'));
        await Future.delayed(const Duration(seconds: 3), () {
          emit(const ForgetPasswordState());
        });
        return;
      }
      await _applicationRepository
          .forgotPassword(event.email)
          .then((progress) => emit(const AuthenticationBySignInState()));
    } on AuthenticateException catch (e) {
      emit(FailureForgetPasswordState(e.message));
    } finally {
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const ForgetPasswordState());
      });
    }
  }

  Future<void> _requestSignIn(event, emit) async {
    try {
      emit(const AuthenticationBySignInProgressingState());
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(const FailureAuthenticationBySigninState(
            'EMAIL OR PASSWORD IS EMPTY'));
        await Future.delayed(const Duration(seconds: 3), () {
          emit(const AuthenticationBySignInState());
        });
        return;
      }

      if (!event.email.contains('@') || !event.email.contains('.')) {
        emit(const FailureAuthenticationBySigninState('EMAIL IS NOT VALID'));
        await Future.delayed(const Duration(seconds: 3), () {
          emit(const AuthenticationBySignInState());
        });
        return;
      }

      if (event.password.length < 6) {
        emit(const FailureAuthenticationBySigninState(
            'PASSWORD MUST BE AT LEAST 6 CHARACTERS'));
        await Future.delayed(const Duration(seconds: 3), () {
          emit(const AuthenticationBySignInState());
        });
        return;
      }

      await _applicationRepository.login(event.email, event.password).then(
            (successfullyAuthenticated) => emit(
              const SuccessfulAuthenticatedState(),
            ),
          );
    } on AuthenticateException catch (e) {
      emit(FailureAuthenticationBySigninState(e.message));
    } finally {
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const AuthenticationBySignInState());
      });
    }
  }

  Future<void> _requestSignUp(event, emit) async {
    try {
      emit(const AuthenticationBySignUpProgressingState());
      if (event.email.isEmpty ||
          event.password.isEmpty ||
          event.username.isEmpty ||
          event.confirmPassword.isEmpty) {
        emit(const FailureAuthenticationBySignupState(
            'EMAIL OR PASSWORD OR USERNAME IS EMPTY'));
        await Future.delayed(const Duration(seconds: 2), () {
          emit(const AuthenticationBySignUpState());
        });
        return;
      }

      if (!event.email.contains('@') || !event.email.contains('.')) {
        emit(const FailureAuthenticationBySignupState('EMAIL IS NOT VALID'));
        await Future.delayed(const Duration(seconds: 3), () {
          emit(const AuthenticationBySignUpState());
        });
        return;
      }

      if (event.password != event.confirmPassword) {
        emit(const FailureAuthenticationBySignupState(
            'PASSWORDS ARE NOT MATCH'));
        await Future.delayed(const Duration(seconds: 3), () {
          emit(const AuthenticationBySignUpState());
        });
        return;
      }

      if (event.password.length < 6) {
        emit(const FailureAuthenticationBySignupState(
            'PASSWORD MUST BE AT LEAST 6 CHARACTERS'));
        await Future.delayed(const Duration(seconds: 2), () {
          emit(const AuthenticationBySignUpState());
        });
        return;
      }

      await _applicationRepository
          .signUp(
            event.email,
            event.password,
          )
          .then(
            (successfullyAuthenticated) => emit(
              const SuccessfulAuthenticatedState(),
            ),
          );
    } on AuthenticateException catch (e) {
      emit(FailureAuthenticationBySignupState(e.message));
    } finally {
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const AuthenticationBySignUpState());
      });
    }
  }
}
