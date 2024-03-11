part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class LoadingState extends FavoriteState {}

class DefaultState extends FavoriteState {
  final List<Item> favoriteList;

  DefaultState(this.favoriteList);
}
