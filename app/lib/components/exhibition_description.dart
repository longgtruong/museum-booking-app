import 'package:app/models/exhibition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExhibitionDescription extends StatelessWidget {
  final Exhibition exhibition;
  final String museum;
  ExhibitionDescription(
      {Key? key, required this.exhibition, required this.museum})
      : super(key: key);

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
                child: Text(
                    "Until " + DateFormat.yMMMMEEEEd().format(exhibition.date)),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            museum,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )),
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
