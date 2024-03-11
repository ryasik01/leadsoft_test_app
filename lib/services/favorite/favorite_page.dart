import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../base/widgets/repo_tile.dart';
import 'favorite_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            final bloc = context.read<FavoriteBloc>();
            return Scaffold(
              appBar: AppBar(
                leading: Container(
                  margin: const EdgeInsets.only(left: 16, bottom: 4, top: 4),
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1463F5),
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                    onPressed: () => bloc.add(GoHomeEvent()),
                    icon: SvgPicture.asset('assets/images/left.svg',
                        color: const Color(0xFFF9F9F9)),
                  ),
                ),
                backgroundColor: Colors.white,
                title: const Text(
                  'Favorite repos list',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                bottomOpacity: 3,
              ),
              body: Column(children: [
                Container(color: const Color(0xFFF2F2F2), height: 3),
                const SizedBox(height: 20),
                _body(state, bloc)
              ],)
          );
          });

  Widget _body(FavoriteState state, FavoriteBloc bloc) {
    if (state is DefaultState) {
      return Expanded(
        child:
        state.favoriteList.isNotEmpty ?
        ListView(
          children: state.favoriteList.map((e) {
            return RepoTile(
              item: e,
              isFavorite: true,
              onPressed: (item) => bloc.add(RemoveFromListEvent(item)),
            );
          }).toList() ??
              [],
        )
        : const Center(
          child: Text(
            'You have no favorites.\nClick on star while searching to add first favorite',
            style: TextStyle(fontSize: 14, color: Color(0xFFBFBFBF)),
            textAlign: TextAlign.center,
          ),
        )
      );;
    } else {
      return const Center(child: CupertinoActivityIndicator());
    }
  }
}