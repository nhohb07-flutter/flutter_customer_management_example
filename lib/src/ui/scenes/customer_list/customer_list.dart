import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:customer_management/src/ui/widgets/index.dart';
import 'package:customer_management/src/blocs/index.dart';
import 'package:customer_management/src/models/index.dart';

import '../customer_detail/customer_detail.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final CustomerBloc _customerBloc = CustomerBloc();

  _CustomerListState() {
    _customerBloc.dispatch(FetchCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: this._customerBloc,
      builder: (BuildContext context, CustomerState customerState) {
        if (customerState is CustomerUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppHeader(
            title: 'Customers',
            brightness: Brightness.dark,
          ),
          body: this._buildBodyPage(customerState),
          drawer: AppDrawer(),
        );
      },
    );
  }

  Widget _buildBodyPage(CustomerState customerState) {
    if (customerState is CustomerLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (customerState is CustomerLoadFailure) {
      return Center(
        child: Text(customerState.error),
      );
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index >= customerState.customers.length) {
          return null;
        }

        final CustomerModel user = customerState.customers[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.lastName),
          dense: true,
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerDetail()),
              ),
        );
      },
    );
  }
}
