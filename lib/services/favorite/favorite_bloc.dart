import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leadsoft_test_app/navigation/router.dart';
import 'package:meta/meta.dart';

import '../../data/model/response.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBlocArg{
  final List<Item> favoriteList;

  FavoriteBlocArg(this.favoriteList);
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(FavoriteBlocArg arg) : super(DefaultState(arg.favoriteList)) {
    on<RemoveFromListEvent>((event, emit) {
      final list = (state as DefaultState).favoriteList;
      list.removeWhere((e) => e.id == event.item.id);
      emit(DefaultState(list));
    });
    on<GoHomeEvent>((event, emit) {
      if( state is DefaultState) {
        router.pop((state as DefaultState).favoriteList);
      }
    });
  }
}
