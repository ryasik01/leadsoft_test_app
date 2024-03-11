part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SearchEvent extends HomeEvent{
  final String query;

  SearchEvent(this.query);
}

class InitEvent extends HomeEvent{}
class ReplyEvent extends HomeEvent{}

class AddRemoveFavoriteListEvent extends HomeEvent{
  final Item item;

  AddRemoveFavoriteListEvent(this.item);
}

class GoDefaultEvent extends HomeEvent{}

class GoFavoriteScreenEvent extends HomeEvent{}

