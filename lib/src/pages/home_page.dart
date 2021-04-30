import 'package:flutter/material.dart';
import 'package:flutter_film_application/src/providers/films_provider.dart';

import 'package:flutter_film_application/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final films = FilmsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Películas en cine"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _cardSwiper(),
          ],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: films.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData)
          return CardSwiper(
            films: snapshot.data,
          );
        else
          return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()),
          );
      },
    );
  }
}
