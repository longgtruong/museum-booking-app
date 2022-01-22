import 'package:app/components/exhibition_description.dart';
import 'package:app/components/exhibition_header.dart';
import 'package:app/components/payment_modal.dart';
import 'package:app/models/exhibition.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExhibitionScreen extends StatefulWidget {
  //to-do change to Exhibition model
  final Exhibition exhibition;
  const ExhibitionScreen({Key? key, required this.exhibition})
      : super(key: key);

  @override
  _ExhibitionScreenState createState() => _ExhibitionScreenState();
}

class _ExhibitionScreenState extends State<ExhibitionScreen> {
  Widget buildButton(Widget icon, String title) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 10.0,
                ),
                Text(title,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PaymentModal(
                      paymentButton: buildButton(
                          FaIcon(FontAwesomeIcons.moneyCheck), "Pay"));
                });
          },
          child: Container(
            child:
                buildButton(FaIcon(FontAwesomeIcons.ticketAlt), "Buy ticket"),
          )),
      body: Container(
        child: Column(
          children: [
            ExhibitionHeader(
              exhibition: widget.exhibition,
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.topLeft,
              child: Text(
                widget.exhibition.title,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(
              height: 10.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            ExhibitionDescription(
              exhibition: widget.exhibition,
            ),
            Divider(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
