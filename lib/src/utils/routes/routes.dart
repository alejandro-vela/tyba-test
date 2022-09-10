import 'package:flutter/material.dart';
import '../../pages/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
};
