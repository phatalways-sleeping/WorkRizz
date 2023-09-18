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
    on<AuthenticationClearEvent>((event, emit) async {
      emit(const StartingState());
    });
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
    on<RequestSigninEvent>(_requestLogin);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _requestForgetPassword(
    RequestForgetPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(const ForgetPasswordProgressingState());
      await _applicationRepository
          .forgotPassword(event.email)
          .then((progress) => emit(const SuccessfullySendResetEmail()));
    } on AuthenticateException catch (e) {
      emit(FailureForgetPasswordState(e.message));
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const ForgetPasswordState());
      });
    }
  }

  Future<void> _requestLogin(
    RequestSigninEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(const AuthenticationBySignInProgressingState());

      await _applicationRepository
          .login(
            event.email,
            event.password,
          )
          .then((successfullyAuthenticated) =>
              emit(const SuccessfulAuthenticatedState()));
    } on AuthenticateException catch (e) {
      emit(FailureAuthenticationBySigninState(e.message));
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const AuthenticationBySignInState());
      });
    }
  }

  Future<void> _requestSignUp(
    RequestSignupEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(const AuthenticationBySignUpProgressingState());

      await _applicationRepository
          .signUp(
            event.username,
            event.email,
            event.password,
            event.confirmPassword,
          )
          .then((successfullyAuthenticated) =>
              emit(const SuccessfulAuthenticatedState()));
    } on AuthenticateException catch (e) {
      emit(FailureAuthenticationBySignupState(e.message));
      await Future.delayed(const Duration(seconds: 3), () {
        emit(const AuthenticationBySignUpState());
      });
    }
  }
}
