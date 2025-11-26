part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {}

final class PostShared extends HomeState {}

final class PostReact extends HomeState {}

final class PostCommenting extends HomeState {}

final class PostCommented extends HomeState {}

final class HomePostCreated extends HomeState {}

final class HomeError extends HomeState {}
