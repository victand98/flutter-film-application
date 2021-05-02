import 'package:flutter/material.dart';

import 'package:flutter_film_application/src/providers/films_provider.dart';
import 'package:flutter_film_application/src/models/film_model.dart';

class DataSearch extends SearchDelegate {
  final filmsProvider = FilmsProvider();

  String _selected = "";

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del AppBar (P.E: Botón para cancelar la busqueda)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder que crea los resultados que se mostrarán
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(_selected),
      ),
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Sugerencias que aparecen cuando el usuario escribe

  //   final _suggestedList = (query.isEmpty)
  //       ? newFilms
  //       : films
  //           .where((element) =>
  //               element.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //       itemCount: _suggestedList.length,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           leading: Icon(Icons.movie),
  //           title: Text(_suggestedList[index]),
  //           onTap: () {
  //             _selected = _suggestedList[index];
  //             showResults(context);
  //           },
  //         );
  //       });
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando el usuario escribe

    if (query.isEmpty) return Container();

    return FutureBuilder(
        future: filmsProvider.searchFilm(query),
        builder: (context, AsyncSnapshot<List<Film>> snapshot) {
          if (snapshot.hasData)
            return ListView(
              children: snapshot.data
                  .map(
                    (film) => ListTile(
                      leading: FadeInImage(
                        placeholder: AssetImage("assets/img/no-image.jpg"),
                        image: NetworkImage(film.getPosterImg()),
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      title: Text(film.title),
                      subtitle: Text(
                        film.overview,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        close(context, null);
                        film.uniqueId = "";
                        Navigator.pushNamed(context, "detail", arguments: film);
                      },
                    ),
                  )
                  .toList(),
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
