part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class RemoveFromListEvent extends FavoriteEvent{
  final Item item;

  RemoveFromListEvent(this.item);
}

class GoHomeEvent extends FavoriteEvent{}