import 'package:flutter/material.dart';
import 'package:flutter_film_application/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Film> films;
  final Function nextPage;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontal({@required this.films, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        print("load new data");
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
        children: _targets(context),
      ),
    );
  }

  List<Widget> _targets(BuildContext context) {
    return films.map((film) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage("assets/img/no-image.jpg"),
                image: NetworkImage(film.getPosterImg()),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
