import 'package:flutter/material.dart';
import 'package:tyba_test/src/pages/detail_screem.dart';
import '../../bloc/university_bloc/university_bloc.dart';
import '../../pages/home_screen.dart';

// Home
navigateToHome(
        BuildContext context, bool remplaced, UniversityBloc? universityBloc) =>
    remplaced
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext contextt) {
            return HomeScreen(newBLoc: universityBloc);
          }), (Route route) => false)
        : Navigator.of(context).pushNamed(HomeScreen.routeName);

navigateToDetailScreen(
        BuildContext context, UniversityBloc universityBloc, int index) =>
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext contextt) {
      return DetailScreen(
        universityBloc: universityBloc,
        index: index,
      );
    }), (Route route) => false);
