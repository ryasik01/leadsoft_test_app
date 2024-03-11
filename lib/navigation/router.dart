import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../navigation/route.dart';
import '../services/favorite/favorite_bloc.dart';
import '../services/favorite/favorite_page.dart';
import '../services/home/home_bloc.dart';
import '../services/home/home_page.dart';


final GoRouter router = GoRouter(
  initialLocation: AppRoute.home.path,
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      builder: (context, state) => BlocProvider(
          create: (context) => HomeBloc(),
          child: const HomePage()),
    ),
    GoRoute(
      path: AppRoute.favorite.path,
      builder: (context, state) => BlocProvider(
          create: (context) => FavoriteBloc(state.extra as FavoriteBlocArg),
          child:  const FavoritePage()),
    ),
  ],
);
