import 'package:app/components/image_carousel.dart';
import 'package:app/cubit/museum_cubit/museum_cubit.dart';
import 'package:app/models/exhibition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExhibitionHeader extends StatelessWidget {
  final Exhibition exhibition;
  ExhibitionHeader({Key? key, required this.exhibition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [exhibition.imageUrl.toString()];

    int size = images.length;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(children: [
        ExhibitionImagesCarousel(images: images),
        Container(
          margin:
              EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0, bottom: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        BlocProvider.of<MuseumCubit>(context).getExhibitions();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.favorite_outline)),
                      IconButton(onPressed: () => {}, icon: Icon(Icons.share))
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer),
                      SizedBox(width: 5.0),
                      Text(exhibition.length.toString() + " minutes")
                    ],
                  ),
                  Text("$size photo")
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
