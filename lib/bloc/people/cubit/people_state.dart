part of 'people_cubit.dart';

@immutable
sealed class PeopleState {}

final class PeopleInitial extends PeopleState {}
final class PeopleLoading extends PeopleState {}
final class PeopleLoaded extends PeopleState {}
final class PeopleError extends PeopleState {}
