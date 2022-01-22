import 'package:app/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentModal extends StatefulWidget {
  Widget paymentButton;
  PaymentModal({Key? key, required this.paymentButton}) : super(key: key);

  @override
  _PaymentModalState createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  int _ticketQuantity = 1;
  double _ticketPrice = 15.25;
  double _totalPrice = 15.25;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r"Ticket $15.25",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => {
                                    setState(() {
                                      if (_ticketQuantity > 0) {
                                        _ticketQuantity--;
                                        _totalPrice = _totalPrice - 15.25;
                                      }
                                    })
                                  },
                              icon: FaIcon(FontAwesomeIcons.minusCircle)),
                          Text(
                            _ticketQuantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          IconButton(
                              onPressed: () => {
                                    setState(() {
                                      _ticketQuantity++;
                                      _totalPrice = _totalPrice + 15.25;
                                    })
                                  },
                              icon: FaIcon(FontAwesomeIcons.plusCircle))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Commission",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                      Text(r"$2.50"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => {},
                        child: Text(
                          "Have a promo?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.blueAccent),
                        ),
                      ),
                      Text(r"-$5.00"),
                    ],
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r"Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text("\$$_totalPrice"),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: widget.paymentButton,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TicketScreen()));
              },
            )
          ],
        ));
  }
}
