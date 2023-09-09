import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_managing_application/repositories/application_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> moveToLoadingState() async {
    emit(const SplashLoading());
    await Future.delayed(const Duration(seconds: 3));

    final currentUser = await FirebaseAuth.instance.authStateChanges().first;

    if (currentUser != null) {
      final email = currentUser.email!;

      final userAccount =
          await ApplicationRepository.repository.userStreamByEmail(email).first;

      ApplicationRepository.repository.userId = userAccount.id;
      ApplicationRepository.repository.userEmailAddress = userAccount.email;
      ApplicationRepository.repository.userImageUrl = userAccount.imageUrl;
      ApplicationRepository.repository.username = userAccount.username;

      emit(const SplashToHome());
    } else {
      emit(const SplashToLogin());
    }
  }
}
