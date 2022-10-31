// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monsters_front_end/pages/interaction.dart';
import 'package:monsters_front_end/routes.dart';
import 'pages/style.dart';

var tempPage = InteractionPage();
var user_Account = 'Lin';
void main() async {
  runApp(Monsters());
}

class Monsters extends StatelessWidget with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      title: '貘nsters',
      theme: _theme(),
      routes: {
        GitmeRebornRoutes.login: (context) => LoginPage(),
        GitmeRebornRoutes.home: (context) => MainPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GitmeRebornRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        break;
      case AppLifecycleState.paused:
        log(state.toString());
        break;
      case AppLifecycleState.resumed:
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        log(state.toString());
        break;
      case AppLifecycleState.detached:
        log(state.toString());
        break;
    }
  }
}

ThemeData _theme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: AppBarTextStyle,
        backgroundColor: BackgroundColorWarm),
    textTheme:
        const TextTheme(subtitle1: TitleTextStyle, bodyText1: Body1TextStyle),
    iconTheme: const IconThemeData(color: Colors.white),
    primarySwatch: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
