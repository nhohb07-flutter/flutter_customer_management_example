import 'package:meta/meta.dart';
import 'package:user_management/src/models/index.dart';

// class UserState {
//   final bool isLoading;
//   final String error;
//   final List<UserModel> users;

//   UserState({
//     @required this.isLoading,
//     @required this.error,
//     @required this.users,
//   });

//   factory UserState.initial() {
//     return UserState(
//       isLoading: false,
//       error: null,
//       users: [],
//     );
//   }

//   factory UserState.loading() {
//     return UserState(
//       isLoading: true,
//       error: null,
//       users: [],
//     );
//   }

//   factory UserState.failure(String error) {
//     return UserState(
//       isLoading: false,
//       error: error,
//       users: [],
//     );
//   }

//   factory UserState.success(List<UserModel> users) {
//     return UserState copyWith({
//       List<UserModel> users,
//     }) {
//       return UserState(
//         isLoading: false,
//         error: null,
//         users: users ?? this.users,
//       );
//     }
//   }
// }

abstract class UserState {
  bool isLoading;
  String error;
  List<UserModel> users;
}

class UserUninitialized extends UserState {
  UserUninitialized() {
    this.isLoading = false;
  }

  @override
  String toString() => 'User Uninitialized: ${this.isLoading}';
}

class UserLoading extends UserState {
  UserLoading() {
    this.isLoading = true;
  }

  @override
  String toString() => 'User Loading: ${this.isLoading}';
}

class UserLoadFailure extends UserState {
  final String error;

  UserLoadFailure({
    @required this.error,
  }) {
    this.isLoading = false;
  }

  @override
  String toString() => 'User Load Failure: ${error}, ${this.isLoading}';
}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final bool hasReachedMax;

  UserLoaded({
    this.users,
    this.hasReachedMax,
  }) {
    this.isLoading = false;
  }

  @override
  String toString() =>
      'User Loaded: { users: ${this.users.length}, hasReachedMax: ${this.hasReachedMax} }';
}
