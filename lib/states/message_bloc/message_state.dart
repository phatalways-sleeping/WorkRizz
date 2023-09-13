part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();
  
  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {
  const MessageInitial();
}

final class MessageLoading extends MessageState {
  const MessageLoading();
}

final class MessageSuccess extends MessageState {
  const MessageSuccess(this.messageIds);

  final List<String> messageIds;

  @override
  List<Object> get props => [
    messageIds,
  ];
}

final class MessageError extends MessageState {
  const MessageError(this.error);

  final String error;

  @override
  List<Object> get props => [
    error,
  ];
}
