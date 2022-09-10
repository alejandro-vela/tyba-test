import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:tyba_test/src/pages/home_screen.dart';
import 'global_locator.dart';
import 'src/bloc/observer_bloc.dart';
import 'src/utils/routes/routes.dart';

void main() {
  setUpGlobalLocator();
  Bloc.observer = ObserverBloc();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TybaApp());
}

class TybaApp extends StatelessWidget {
  const TybaApp();

  @override
  Widget build(BuildContext context) => Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.routeName,
          routes: routes,
        ),
      );
}
