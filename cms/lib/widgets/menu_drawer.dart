import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        color: Colors.blueAccent,
        child: ListView(
          children: [
            ListTile(
              title: Text("Home",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              tileColor: Colors.white,
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text("Museum",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              tileColor: Colors.white,
              leading: Icon(
                Icons.museum,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text("Exhibitions",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              tileColor: Colors.white,
              leading: Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text("Tickets",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              tileColor: Colors.white,
              leading: Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
