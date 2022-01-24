import 'package:app/components/signup_form.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/components/login_form.dart';
import 'package:app/models/exhibition.dart';
import 'package:app/models/ticket.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUsersTicket();

    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            print(state);
            if (state is UserLogin || state is UserLoginError) {
              return LoginForm();
            }
            if (state is UserSignUp) {
              return SignUpForm();
            }
            if (state is UserLoggingIn || state is UserSigningUp) {
              return Center(
                  child: Container(child: CircularProgressIndicator()));
            }
            if (state is UserLoggedIn) {
              BlocProvider.of<UserCubit>(context).getUsersTicket();
            }
            if (state is LoadedTickets) {
              return UserDetails();
            }
            if (state is UserLogout) {
              return DefaultAuthPage();
            }
            return DefaultAuthPage();
          },
        ));
  }
}

class UserDetails extends StatefulWidget {
  UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is LoadedTickets) {
          final tickets = state.tickets;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Ticket",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    tickets.isNotEmpty
                        ? CarouselSlider(
                            items: List<Widget>.generate(tickets.length,
                                (int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/museum/default.png'),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text("Status: "),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          tickets[index].status.toString(),
                                          style: TextStyle(
                                              color: tickets[index]
                                                      .status
                                                      .toString()
                                                      .contains("ACTIVE")
                                                  ? Colors.black
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Text("Ticket number #" +
                                        tickets[index].id.toString()),
                                    Row(
                                      children: [
                                        FaIcon(FontAwesomeIcons.ticketAlt),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            " x " +
                                                tickets[index]
                                                    .quantity
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                            options:
                                CarouselOptions(enableInfiniteScroll: false))
                        : Center(
                            child: Container(
                              child: Text(
                                  "You currently do not have any tickets."),
                            ),
                          )
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent)),
                    child:
                        Text("Logout", style: TextStyle(color: Colors.white)),
                    onPressed: () =>
                        {BlocProvider.of<UserCubit>(context).logout()},
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class DefaultAuthPage extends StatelessWidget {
  const DefaultAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login to see your personalized page",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 40.0,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: Text("Login / Sign Up",
                  style: TextStyle(color: Colors.white)),
              onPressed: () =>
                  {BlocProvider.of<UserCubit>(context).emit(UserLogin())},
            ),
          ),
        ],
      ),
    ));
  }
}

class WishList extends StatelessWidget {
  List<Exhibition> exhibitions;
  WishList({Key? key, required this.exhibitions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text(
            "Wishlist",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          exhibitions.isNotEmpty
              ? CarouselSlider(
                  items: List<Widget>.generate(4, (int index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.etsystatic.com/15031880/r/il/fd8ae6/2451259716/il_570xN.2451259716_fhw2.jpg'),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(Icons.timer),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(exhibitions[index].length.toString() +
                                  " minutes")
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              exhibitions[index].title,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  options: CarouselOptions())
              : Center(
                  child: Container(
                    child: Text("There are no exhibitions in wishlist"),
                  ),
                )
        ],
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  List<Ticket> tickets;
  TicketList({Key? key, required this.tickets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text(
            "Your tickets",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(tickets[index].eventId.toString()),
                );
              })
        ],
      ),
    );
  }
}
