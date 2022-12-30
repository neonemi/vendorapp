part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationSuccess extends NotificationState {
  const NotificationSuccess(this.response);
  final GetNotificationResponse response;
  @override
  List<Object> get props => [response];
}
class NotificationDeleteSuccess extends NotificationState {
  const NotificationDeleteSuccess(this.response);
  final GetNotificationResponse response;
  @override
  List<Object> get props => [response];
}
class NotificationReadSuccess extends NotificationState {
  const NotificationReadSuccess(this.response);
  final GetNotificationResponse response;
  @override
  List<Object> get props => [response];
}
class NotificationUnReadSuccess extends NotificationState {
  const NotificationUnReadSuccess(this.response);
  final GetUnReadNotificationCount response;
  @override
  List<Object> get props => [response];
}
class NotificationError extends NotificationState {
  const NotificationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
