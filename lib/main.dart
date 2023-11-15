import 'package:flutter/material.dart';
import 'package:todoapp/config/route.dart';
import 'package:todoapp/config/theme.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: appTheme,
      routes: appRoutes,
    );
  }
}
