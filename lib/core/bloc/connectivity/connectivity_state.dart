part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState(
      {this.connectivityResult = ConnectivityResult.mobile});

  final ConnectivityResult connectivityResult;
}

class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial({super.connectivityResult});

  @override
  List<Object> get props => [connectivityResult];
}

class ConnectivityOffline extends ConnectivityState {
  const ConnectivityOffline({super.connectivityResult});

  @override
  List<Object> get props => [connectivityResult];
}

class ConnectivityOnline extends ConnectivityState {
  const ConnectivityOnline({super.connectivityResult});

  @override
  List<Object> get props => [connectivityResult];
}

class ConnectivityRestored extends ConnectivityOnline {
  const ConnectivityRestored({super.connectivityResult});

  @override
  List<Object> get props => [connectivityResult];
}
