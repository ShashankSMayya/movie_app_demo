import 'package:flutter/material.dart';
import 'package:movie_app/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,

      theme: ThemeData(
        brightness: Brightness.dark,


        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
