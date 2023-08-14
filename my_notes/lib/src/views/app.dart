import 'package:flutter/material.dart';
import 'package:my_notes/src/res/strings.dart';
import 'package:my_notes/src/views/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: ThemeData(
        useMaterial3: true
      ),
      home: HomeView(),
    );
  }
}