import 'package:app/cubit/museum_cubit/museum_cubit.dart';
import 'package:app/cubit/ticket_cubit/ticket_cubit.dart';
import 'package:app/models/exhibition.dart';
import 'package:app/models/ticket.dart';
import 'package:app/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentModal extends StatefulWidget {
  Widget paymentButton;
  Exhibition exhibition;

  PaymentModal({
    Key? key,
    required this.paymentButton,
    required this.exhibition,
  }) : super(key: key);

  @override
  _PaymentModalState createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  int _ticketQuantity = 1;
  double _ticketPrice = 0;
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _ticketQuantity = 1;
    _ticketPrice = widget.exhibition.price.toDouble();
    _totalPrice = widget.exhibition.price.toDouble();
  }

  buyTicket() {
    Ticket ticket =
        new Ticket(eventId: widget.exhibition.id!, quantity: _ticketQuantity);
    BlocProvider.of<TicketCubit>(context).buyTicket(ticket);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      builder: (context, state) {
        if (state is TicketStart) {
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
                              "Ticket \$$_ticketPrice",
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
                                              _totalPrice =
                                                  _totalPrice - _ticketPrice;
                                            }
                                          })
                                        },
                                    icon: FaIcon(FontAwesomeIcons.minusCircle)),
                                Text(
                                  _ticketQuantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                IconButton(
                                    onPressed: () => {
                                          setState(() {
                                            _ticketQuantity++;
                                            _totalPrice =
                                                _totalPrice + _ticketPrice;
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
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
                            Text(r"-$2.50"),
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
                            Text("$_totalPrice"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {buyTicket()},
                    child: widget.paymentButton,
                  )
                ],
              ));
        }
        if (state is UserLoginPrompt) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 50.0),
                SizedBox(
                  height: 15,
                ),
                Text("Must login to buy the tickets."),
              ],
            ),
          );
        }
        if (state is TicketProcessing) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is TicketProcessed) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.check, size: 50.0),
                SizedBox(
                  height: 15,
                ),
                Text("Ticket has been placed."),
              ],
            ),
          );
        }
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
