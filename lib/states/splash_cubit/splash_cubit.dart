import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> moveToLoadingState() async {
    emit(const SplashLoading());
    await Future.delayed(const Duration(seconds: 3));
    final currentUser = await FirebaseAuth.instance.authStateChanges().first;
    if (currentUser == null) {
      emit(const SplashToLogin());
    }

    emit(const SplashToHome());
  }
}
