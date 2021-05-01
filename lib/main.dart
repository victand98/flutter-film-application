import 'package:flutter/material.dart';

import 'package:flutter_film_application/src/pages/home_page.dart';
import 'package:flutter_film_application/src/pages/film_datail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "detail": (BuildContext context) => FilmDetail(),
      },
    );
  }
}
