abstract class UserEvent {}

class FetchUser extends UserEvent {
  @override
  String toString() => 'FetchUser';
}
