part of 'people_cubit.dart';

@immutable
sealed class PeopleState {}

final class PeopleInitial extends PeopleState {}

final class PeopleLoading extends PeopleState {}

final class PeopleLoaded extends PeopleState {}

final class PeopleFollowing extends PeopleState {}

final class CurrentUser extends PeopleState {
  final SearchedUserProfile user;
  CurrentUser({required this.user});
}

final class PeopleSearched extends PeopleState {
  final SearchedUserModel user;
  PeopleSearched({required this.user});
}

final class PeopleError extends PeopleState {}
