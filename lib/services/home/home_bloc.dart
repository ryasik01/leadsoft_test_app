import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:leadsoft_test_app/data/model/response.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/repository/github_repository.dart';
import '../../navigation/route.dart';
import '../../navigation/router.dart';
import '../favorite/favorite_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

const listFavoriteRepo = 'listFavoriteRepo';
const listSearch = 'listSearch';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Item> _favoriteList = [];
  List<String> _searchList = [];
  final GitHubRepository _repository;
  String _query = '';

  HomeBloc({GitHubRepository? repository})
      : _repository = repository ?? GitHubRepositoryImpl(),
        super(LoadingState()) {
    on<InitEvent>((event, emit) async {
      final favorite = await _getFromDB(listFavoriteRepo);
      if(favorite != null) _favoriteList = Item.decode(favorite);
      _searchList = await _getFromSearchDB(listSearch) ?? [];
      emit(DefaultState(_searchList));
    });
    on<SearchEvent>((event, emit) async {
      if (state != LoadingState) emit(LoadingState());
      final Response result;
      _query = event.query;
      _searchList.add(_query);
      await _saveSearchToDB(listSearch, _searchList);
      try {
        result = await _repository.getRepositories(event.query);
        emit(ResultState(result.items, _favoriteList.map((e) => e.id).toList()));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });
    on<ReplyEvent>((event, emit) async {
      if (state != LoadingState) emit(LoadingState());
      final Response result;
      try {
        result = await _repository.getRepositories(_query);
        emit(ResultState(result.items, _favoriteList.map((e) => e.id).toList()));
      } on Exception catch (e) {
        emit(ErrorState());
      }
    });
    on<AddRemoveFavoriteListEvent>((event, emit) {
      _favoriteList.where((e) => e.id == event.item.id).isNotEmpty
          ? _favoriteList.removeWhere((e) => e.id == event.item.id)
          : _favoriteList.add(event.item);
      _saveToDB(listFavoriteRepo, Item.encode(_favoriteList));
      emit(ResultState(
          (state as ResultState).list, _favoriteList.map((e) => e.id).toList()));
    });
    on<GoDefaultEvent>((event, emit) {
      emit(DefaultState(_searchList));
    });
    on<GoFavoriteScreenEvent>((event, emit) async {
      final result = await router.push(AppRoute.favorite.path,
          extra: FavoriteBlocArg(_favoriteList));
      if (result != null && result is List<Item>) {
        if(_favoriteList.length != result.length) {
          _favoriteList = result;
          await _saveToDB(listFavoriteRepo, Item.encode(result));
          if (state is ResultState) {
            emit(ResultState((state as ResultState).list,
                _favoriteList.map((e) => e.id).toList()));
          }
        }
      }
    });
    add(InitEvent());
  }

  Future<void> _saveToDB(String name, String list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(name, list);
  }

  Future<String?> _getFromDB(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  Future<void> _saveSearchToDB(String name, List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(name, list);
  }

  Future<List<String>?> _getFromSearchDB(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name);
  }

}
