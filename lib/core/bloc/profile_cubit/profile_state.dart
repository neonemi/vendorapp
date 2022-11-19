part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLogoutSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileSuccess extends ProfileState {

  @override
  List<Object> get props => [];
}
class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
