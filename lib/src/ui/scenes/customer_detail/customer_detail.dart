import 'package:flutter/material.dart';

import 'package:customer_management/src/ui/widgets/index.dart';

class CustomerDetail extends StatefulWidget {
  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Customer Detail',
        brightness: Brightness.dark,
      ),
      body: Text('Detail'),
    );
  }
}
