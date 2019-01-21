abstract class CustomerEvent {}

class FetchCustomer extends CustomerEvent {
  @override
  String toString() => 'FetchCustomer';
}
