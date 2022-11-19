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
  const ProfileSuccess(this.userName,this.email,this.image);
  final String userName;
  final String email;
  final String image;
  @override
  List<Object> get props => [userName,email,image];
}
class ProfileGuestSuccess extends ProfileState {
  const ProfileGuestSuccess(this.userName);
  final String userName;
  @override
  List<Object> get props => [userName];
}
class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
