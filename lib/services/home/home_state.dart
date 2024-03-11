part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class DefaultState extends HomeState{
  final List<String> list;

  DefaultState(this.list);
}

class ResultState extends HomeState{
  final List<Item>? list;
  final List<int> favoriteIds;

  ResultState(this.list, this.favoriteIds);
}

class LoadingState extends HomeState{}

class ErrorState extends HomeState{}
