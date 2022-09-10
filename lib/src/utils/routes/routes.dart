import 'package:flutter/material.dart';
import 'package:tyba_test/src/pages/detail_screem.dart';
import '../../pages/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailScreen.routeName: (context) => DetailScreen(),
};
