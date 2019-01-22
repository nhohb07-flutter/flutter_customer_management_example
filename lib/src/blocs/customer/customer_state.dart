import 'package:meta/meta.dart';
import 'package:customer_management/src/models/index.dart';

abstract class CustomerState {
  bool isLoading;
  String error;
  List<CustomerModel> customers;
}

class CustomerUninitialized extends CustomerState {
  CustomerUninitialized() {
    this.isLoading = false;
  }

  @override
  String toString() => 'User Uninitialized: ${this.isLoading}';
}

class CustomerLoading extends CustomerState {
  CustomerLoading() {
    this.isLoading = true;
  }

  @override
  String toString() => 'User Loading: ${this.isLoading}';
}

class CustomerLoadFailure extends CustomerState {
  final String error;

  CustomerLoadFailure({
    @required this.error,
  }) {
    this.isLoading = false;
  }

  @override
  String toString() => 'User Load Failure: $error, ${this.isLoading}';
}

class CustomerLoaded extends CustomerState {
  final List<CustomerModel> customers;
  final bool hasReachedMax;

  CustomerLoaded({
    this.customers,
    this.hasReachedMax,
  }) {
    this.isLoading = false;
  }

  @override
  String toString() =>
      'User Loaded: { customers: ${this.customers.length}, hasReachedMax: ${this.hasReachedMax} }';
}
