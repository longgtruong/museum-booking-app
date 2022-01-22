import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket"),
        backgroundColor: Colors.blue,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "Anatomy of cubism",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text("Order number: #012345678"),
                    SizedBox(height: 10.0),
                    Text("January 22, 2022"),
                    SizedBox(height: 10.0),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text("The Pushkin State Museum of Fine Arts")),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.ticketAlt),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(" x 1")
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Text(
                          r"$ 15.25",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  foregroundColor: Colors.white,
                  size: 200.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () => {
                          Share.share(
                              'I just got ticket to the \'Anatomy of cubism\' exhibition on January 22, 2022.')
                        },
                    child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Center(
                          child: Text(
                        "Share",
                        style: TextStyle(color: Colors.white),
                      )),
                    )),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
