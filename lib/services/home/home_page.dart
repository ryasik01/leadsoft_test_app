import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leadsoft_test_app/base/widgets/repo_tile.dart';
import 'package:leadsoft_test_app/data/model/response.dart';
import '../../base/widgets/text_field_container.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = context.read<HomeBloc>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Github repos list',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            // bottomOpacity: 3,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFF1463F5),
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  onPressed: () => bloc.add(GoFavoriteScreenEvent()),
                  icon: SvgPicture.asset('assets/images/favorite.svg',
                      color: const Color(0xFFF9F9F9)),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(color: const Color(0xFFF2F2F2), height: 3),
              TextFieldContainer(
                child: TextFormField(
                    controller: _controller,
                    autofocus: true,
                    onFieldSubmitted: (s) {
                      if (s.isNotEmpty && s.length > 3) {
                        return bloc.add(SearchEvent(s));
                      } else if (s.isEmpty) {
                        return bloc.add(GoDefaultEvent());
                      }
                    },
                    decoration: InputDecoration(
                        suffixIcon: _controller.value.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  bloc.add(GoDefaultEvent());
                                },
                                icon:
                                    SvgPicture.asset('assets/images/close.svg'),
                              )
                            : null,
                        icon: SvgPicture.asset('assets/images/search.svg'),
                        iconColor: const Color(0xFF1463F5),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFBFBFBF)),
                        border: InputBorder.none)),
              ),
              _title(state, bloc),
              _body(state, bloc)
            ],
          ),
        );
      });

  Widget _title(HomeState state, HomeBloc bloc) {
    if (state is LoadingState) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (state is ResultState) {
      return _buildTextTitle('What we have found');
    } else if (state is DefaultState) {
      return _buildTextTitle('Search History');
    } else if (state is ErrorState) {
      return Center(
        child: OutlinedButton(
            onPressed: () => bloc.add(ReplyEvent()),
            child: const Text('Reply')),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  Widget _body(HomeState state, HomeBloc bloc) {
    if (state is ResultState) {
      return _buildList(state.list, bloc, state.favoriteIds);
    } else if (state is DefaultState) {
      return Expanded(
          child: state.list.isEmpty
              ? centerText(
                  'You have empty history. \nClick on search to start journey!')
              : ListView(
                  children:
                      state.list.map((e) => SearchTile(item: e)).toList()));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildList(List<Item>? list, HomeBloc bloc, List<int> favoriteList) =>
      Expanded(
        child: list != null && list.isNotEmpty
            ? ListView(
                children: list.map((e) {
                      return RepoTile(
                        item: e,
                        isFavorite: favoriteList.contains(e.id),
                        onPressed: (item) =>
                            bloc.add(AddRemoveFavoriteListEvent(item)),
                      );
                    }).toList() ??
                    [],
              )
            : centerText(
                'Nothing was find for your search.\nPlease check the spelling'),
      );

  Widget _buildTextTitle(String text) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 20),
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF1463F5)),
        ),
      );

  Widget centerText(String str) => Center(
        child: Text(
          str,
          style: const TextStyle(fontSize: 14, color: Color(0xFFBFBFBF)),
          textAlign: TextAlign.center,
        ),
      );
}

class SearchTile extends StatelessWidget {
  final String item;

  const SearchTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10)),
      child: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
