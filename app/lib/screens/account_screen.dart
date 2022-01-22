import 'package:app/components/signup_form.dart';
import 'package:app/cubit/user_cubit/user_cubit.dart';
import 'package:app/components/login_form.dart';
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
  bool _isLoggedIn = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account'),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
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
              final String token = (state as UserLoggedIn).token;
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
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  List<String> exhibitions = [
    "Issac Levitan and author cinema",
    "Anatomy of cubism",
    "Russia Big Aventure",
    "Unnatural selection"
  ];

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              WishList(exhibitions: exhibitions),
              SizedBox(
                height: 10.0,
              ),
              TicketList(
                tickets: exhibitions,
              )
            ],
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              child: Text("Logout", style: TextStyle(color: Colors.white)),
              onPressed: () => {BlocProvider.of<UserCubit>(context).logout()},
            ),
          ),
        ],
      ),
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
  List<String> exhibitions;
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
          CarouselSlider(
              items: List<Widget>.generate(4, (int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text("50 minutes")
                            ],
                          ),
                          Text("~ 0.9 km")
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          exhibitions[index],
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              }),
              options: CarouselOptions())
        ],
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  List<String> tickets;
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
          CarouselSlider(
              items: List<Widget>.generate(4, (int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text("50 minutes")
                            ],
                          ),
                          Text("~ 0.9 km")
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          tickets[index],
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.topLeft,
                        child: Text("December 5 at 18:00",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.8))),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.ticketAlt),
                            SizedBox(width: 5.0),
                            Text(
                              "x 1",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              options: CarouselOptions())
        ],
      ),
    );
  }
}
