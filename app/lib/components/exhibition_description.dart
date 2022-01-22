import 'package:app/models/exhibition.dart';
import 'package:flutter/material.dart';

class ExhibitionDescription extends StatelessWidget {
  final Exhibition exhibition;
  ExhibitionDescription({Key? key, required this.exhibition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text("Until 01/20/2022"),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "The Pushkin State Museum of Fine Arts",
                        style: TextStyle(color: Colors.grey),
                      )),
                  Text("~0.5km", style: TextStyle(color: Colors.grey))
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(exhibition.description)),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
