import 'package:cms/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Museum Booking CMS"),
        ),
        drawer: MenuDrawer(),
        body: Center(
          child: Container(),
        ));
  }
}
