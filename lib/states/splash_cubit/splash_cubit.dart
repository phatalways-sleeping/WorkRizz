import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> moveToLoadingState() async {
    emit(const SplashLoading());
    await Future.delayed(const Duration(seconds: 3));
    await SharedPreferences.getInstance().then(
      (sharedPreferences) {
        // sharedPreferences.clear();
        final loginBefore =
            sharedPreferences.get('hasBeenAuthenticated') as bool?;
        if (loginBefore == null) {
          ApplicationRepository.initializeRepo();
          emit(const SplashToLogin());
        } else {
          ApplicationRepository.initializeRepo(
            latestAuthenticatedEmail: sharedPreferences.get('email') as String,
          );
          emit(const SplashToHome());
        }
      },
    );
  }
}
