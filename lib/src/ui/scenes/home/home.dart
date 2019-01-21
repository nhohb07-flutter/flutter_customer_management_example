import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:user_management/src/ui/widgets/index.dart';
import 'package:user_management/src/blocs/index.dart';
import 'package:user_management/src/models/index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserBloc _userBloc = UserBloc(httpClient: http.Client());

  _HomeState() {
    _userBloc.dispatch(FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: this._userBloc,
      builder: (BuildContext context, UserState userState) {
        if (userState is UserUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppHeader(title: 'Users'),
          body: this._buildBodyPage(userState),
        );
      },
    );
  }

  Widget _buildBodyPage(UserState userState) {
    if (userState is UserLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (userState is UserLoadFailure) {
      return Center(
        child: Text(userState.error),
      );
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index >= userState.users.length) {
          return null;
        }

        final UserModel user = userState.users[index];

        return ListTile(
          leading: Text(user.id.toString()),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.lastName),
          dense: true,
        );
      },
    );
  }
}
