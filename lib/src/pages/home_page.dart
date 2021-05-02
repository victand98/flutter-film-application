import 'package:flutter/material.dart';

import 'package:flutter_film_application/src/widgets/card_swiper_widget.dart';
import 'package:flutter_film_application/src/widgets/movie_horizontal.dart';
import 'package:flutter_film_application/src/providers/films_provider.dart';
import 'package:flutter_film_application/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final filmsProvider = FilmsProvider();

  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Películas en cine"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: DataSearch(),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _cardSwiper(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: filmsProvider.getNowPlaying(),
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

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
              stream: filmsProvider.popularsStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData)
                  return MovieHorizontal(
                    films: snapshot.data,
                    nextPage: filmsProvider.getPopulars,
                  );
                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
