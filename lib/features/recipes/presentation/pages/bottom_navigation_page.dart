import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/search_cubit/search_cubit.dart';
import 'package:food_campanion/features/recipes/presentation/pages/Search_page.dart';
import 'package:food_campanion/features/recipes/presentation/pages/favorites_page.dart';
import 'package:food_campanion/features/recipes/presentation/pages/home_page.dart';
import 'package:food_campanion/features/recipes/presentation/pages/more_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  late PersistentTabController _controller;

  final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: const HomePage(),
    ),
    BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: const SearchPage(),
    ),
    const FavoritesPage(),
    const MorePage(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          CupertinoIcons.home,
        ),
        activeColorPrimary: Colors.orangeAccent,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          CupertinoIcons.search,
        ),
        activeColorPrimary: Colors.orangeAccent,
        title: ("Search"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          CupertinoIcons.heart_fill,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.orangeAccent,
        title: ("Favorite"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          Icons.list,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.orangeAccent,
        title: ("More"),
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
