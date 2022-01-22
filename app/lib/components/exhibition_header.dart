import 'package:app/components/image_carousel.dart';
import 'package:app/models/exhibition.dart';
import 'package:flutter/material.dart';

class ExhibitionHeader extends StatelessWidget {
  final Exhibition exhibition;
  ExhibitionHeader({Key? key, required this.exhibition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "http://artimagesgallery.com.au/images/made/images/uploads/Images/Leunig_Michael/Exhibition_2021/Paintings/The-Escapee-2021-41x51cm_web_620_489.jpg",
      "http://artimagesgallery.com.au/images/made/images/uploads/Images/Leunig_Michael/Exhibition_2021/Paintings/Alive-and-Well-2021-46x46cm_web_499_500.jpg",
      "http://artimagesgallery.com.au/images/made/images/uploads/Images/Leunig_Michael/Exhibition_2021/Paintings/Mirth-spirit-2021_web_373_500.jpg",
      "http://artimagesgallery.com.au/images/made/images/uploads/Images/Leunig_Michael/Exhibition_2021/Paintings/Get-Well-2021-30.5x30_web_508_500.jpg",
      "http://artimagesgallery.com.au/images/made/images/uploads/Images/Leunig_Michael/etchings/Jonah-and-the-Whale-II-web_1024x1024_551_500.jpg"
    ];

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
                      onPressed: () => {Navigator.pop(context)},
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
