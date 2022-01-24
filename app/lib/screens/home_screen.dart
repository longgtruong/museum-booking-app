import 'package:app/cubit/museum_cubit/museum_cubit.dart';
import 'package:app/screens/account_screen.dart';
import 'package:app/screens/exhibition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isListView = true;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MuseumCubit>(context).getExhibitions();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AccountScreen()))
                },
            icon: Icon(Icons.person_outline)),
        title: Text("Exhibitions"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () => {
                      setState(() {
                        _isListView = true;
                      })
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: _isListView
                                    ? const BorderSide(
                                        color: Colors.white, width: 3.0)
                                    : BorderSide.none)),
                        alignment: Alignment.center,
                        child: const Text(
                          "List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        width: MediaQuery.of(context).size.width * 0.45),
                  ),
                  TextButton(
                    onPressed: () => {
                      setState(() {
                        _isListView = false;
                      })
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: !_isListView
                                    ? const BorderSide(
                                        color: Colors.white, width: 3.0)
                                    : BorderSide.none)),
                        alignment: Alignment.center,
                        child: const Text(
                          "Map",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        width: MediaQuery.of(context).size.width * 0.45),
                  ),
                ],
              ),
              _isListView ? ExhibitionsListView() : ExhibitionsMapView()
            ],
          ),
        ),
      ),
    );
  }
}

class ExhibitionsListView extends StatefulWidget {
  const ExhibitionsListView({Key? key}) : super(key: key);

  @override
  _ExhibitionsListViewState createState() => _ExhibitionsListViewState();
}

class _ExhibitionsListViewState extends State<ExhibitionsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MuseumCubit, MuseumState>(builder: (context, state) {
      if (state is ExhibitionsLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ExhibitionsLoaded) {
        final exhibitions = state.exhibitions;
        return Expanded(
          child: Container(
              child: ListView.builder(
                  itemCount: exhibitions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ExhibitionScreen(
                                      exhibition: exhibitions[index],
                                    )))
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: exhibitions[index]
                                .imageUrl
                                .toString()
                                .contains("http")
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        exhibitions[index].imageUrl.toString()),
                                    fit: BoxFit.cover))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    image: AssetImage("assets/images" +
                                        exhibitions[index].imageUrl.toString()),
                                    fit: BoxFit.cover)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.favorite_outline)),
                                FaIcon(FontAwesomeIcons.ticketAlt)
                              ],
                            ),
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
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
        );
      }
      return Container();
    });
  }
}

class ExhibitionsMapView extends StatefulWidget {
  const ExhibitionsMapView({Key? key}) : super(key: key);

  @override
  _ExhibitionsMapViewState createState() => _ExhibitionsMapViewState();
}

class _ExhibitionsMapViewState extends State<ExhibitionsMapView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      child: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
