part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressSuccess extends AddressState {
  const AddressSuccess(this.response);

  final SuccessResponse response;

  @override
  List<Object> get props => [response];
}
class UpdateAddressSuccess extends AddressState {
  const UpdateAddressSuccess(this.response);

  final SuccessResponse response;

  @override
  List<Object> get props => [response];
}
class DefaultAddressSuccess extends AddressState {
  const DefaultAddressSuccess(this.response);

  final SuccessResponse response;

  @override
  List<Object> get props => [response];
}
class DeleteAddressSuccess extends AddressState {
  const DeleteAddressSuccess(this.response);

  final SuccessResponse response;

  @override
  List<Object> get props => [response];
}
class AddressError extends AddressState {
  const AddressError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
