import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:task_managing_application/repositories/repositories.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(
    this._applicationRepository,
  ) : super(const MessageInitial()) {
    on<MessageSubscribeToFirestore>((event, emit) async {
      await emit.forEach(
        _applicationRepository.threadStream(),
        onData: (thread) => MessageSuccess(thread.messages),
        onError: (error, stackTrace) => MessageError(error.toString()),
      );
    });
    on<SendTextMessage>((event, emit) async {
      if(event.message.isEmpty) return;
      await _applicationRepository.addNewMessage(
        message: event.message,
        isTextMessage: true,
        isImageMessage: false,
      );
    });
  }

  final ApplicationRepository _applicationRepository;

  Future<MessageModel> messageFuture(String messageId) async {
    return await _applicationRepository.messageStream(messageId);
  }

  Future<String> avatarUrlFuture(String userId) async {
    final url = await _applicationRepository
        .userStream(userId)
        .first
        .then((value) => value.imageUrl);
    return await _applicationRepository.imageUrlOnStorageOf(url);
  }

  Stream<UserActivityModel> userActivityStream(String userId) {
    return _applicationRepository.userActivityStream(userId);
  }

  Future<String> imageUrlFuture(String imageUrl) async {
    return await _applicationRepository.imageUrlOnStorageOf(imageUrl);
  }

  Future<String> usernameFuture(String userId) async {
    if(userId == _applicationRepository.userId) return "You";
    return await _applicationRepository
        .userStream(userId)
        .first
        .then((value) => value.username);
  }

  bool isSender(String userId) {
    return _applicationRepository.userId == userId;
  }
}
