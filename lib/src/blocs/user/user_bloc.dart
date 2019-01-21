import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:user_management/src/blocs/user/index.dart';
import 'package:user_management/src/models/index.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final http.Client httpClient;

  UserBloc({
    @required this.httpClient,
  });

  @override
  Stream<UserEvent> transform(Stream<UserEvent> events) {
    return (events as Observable<UserEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(currentState, event) async* {
    try {
      if (event is FetchUser) {
        yield UserLoading();

        int page =
            (currentState is UserLoaded) ? currentState.users.length / 20 : 0;

        final users = await this._fetchUser(page);

        yield UserLoaded(users: users, hasReachedMax: false);
      }
    } catch (error) {
      yield UserLoadFailure(error: error.toString());
    }
  }

  Future<List<UserModel>> _fetchUser(int page) async {
    final response = await httpClient.get('https://reqres.in/api/users');

    if (response.statusCode != 200) {
      throw Exception('Failed to load users');
    }

    final body = json.decode(response.body);
    final data = body['data'] as List;

    return data.map((item) {
      return new UserModel(
        id: item['id'],
        firstName: item['first_name'],
        lastName: item['last_name'],
        avatar: item['avatar'],
      );
    }).toList();
  }
}
