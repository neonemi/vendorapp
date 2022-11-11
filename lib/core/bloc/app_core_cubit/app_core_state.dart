part of 'app_core_cubit.dart';

abstract class AppCoreState extends Equatable {
  const AppCoreState();
}

class AppCoreInitial extends AppCoreState {
  @override
  List<Object> get props => [];
}

class AppCoreLoading extends AppCoreState {
  @override
  List<Object> get props => [];
}

class AppCoreNavigateToRegisterPage extends AppCoreState {
  @override
  List<Object> get props => [];
}

class AppCoreNavigateToLoginPage extends AppCoreState {
  @override
  List<Object> get props => [];
}

class AppCoreNavigateToHomeScreen extends AppCoreState {
  @override
  List<Object> get props => [];
}

class AppCoreRequestTimeOut extends AppCoreState {
  @override
  List<Object> get props => [];
}

class AppCoreRequestError extends AppCoreState {
  const AppCoreRequestError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class AppCoreVersionState extends AppCoreState {
  const AppCoreVersionState(this.version);

  final String version;

  @override
  List<Object> get props => [version];
}

