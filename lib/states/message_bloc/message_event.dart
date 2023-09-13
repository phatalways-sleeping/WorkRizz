part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

final class MessageSubscribeToFirestore extends MessageEvent {
  const MessageSubscribeToFirestore();
}

final class SendTextMessage extends MessageEvent {
  const SendTextMessage(this.message);

  final String message;

  @override
  List<Object> get props => [
    message,
  ];
}