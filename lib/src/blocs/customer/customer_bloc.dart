import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:customer_management/src/blocs/customer/index.dart';
import 'package:customer_management/src/models/index.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final http.Client httpClient = http.Client();

  @override
  Stream<CustomerEvent> transform(Stream<CustomerEvent> events) {
    return (events as Observable<CustomerEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => CustomerUninitialized();

  @override
  Stream<CustomerState> mapEventToState(currentState, event) async* {
    try {
      if (event is FetchCustomer) {
        yield CustomerLoading();

        int page = (currentState is CustomerLoaded)
            ? currentState.customers.length / 20
            : 0;

        final customers = await this._fetchCustomers(page);

        yield CustomerLoaded(customers: customers, hasReachedMax: false);
      }
    } catch (error) {
      yield CustomerLoadFailure(error: error.toString());
    }
  }

  Future<List<CustomerModel>> _fetchCustomers(int page) async {
    final response =
        await httpClient.get('https://reqres.in/api/users?per_page=20');

    if (response.statusCode != 200) {
      throw Exception('Failed to load customers');
    }

    final body = json.decode(response.body);
    final data = body['data'] as List;

    return data.map((item) {
      return new CustomerModel(
        id: item['id'],
        firstName: item['first_name'],
        lastName: item['last_name'],
        avatar: item['avatar'],
      );
    }).toList();
  }
}
