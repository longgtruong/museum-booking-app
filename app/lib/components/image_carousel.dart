import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExhibitionImagesCarousel extends StatelessWidget {
  List<String> images;
  ExhibitionImagesCarousel({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.5,
        viewportFraction: 1,
      ),
      items: images.map((e) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: NetworkImage(e),
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}
