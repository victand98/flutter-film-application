import 'package:flutter/material.dart';

import 'package:flutter_film_application/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
    return CardSwiper(films: [1, 2, 3, 4, 5]);
  }
}
