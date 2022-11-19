part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileLoading extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileSuccess extends UpdateProfileState {
  const UpdateProfileSuccess(this.response);

  final UpdateProfileResponse response;

  @override
  List<Object> get props => [response];
}

class UpdateProfileError extends UpdateProfileState {
  const UpdateProfileError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
