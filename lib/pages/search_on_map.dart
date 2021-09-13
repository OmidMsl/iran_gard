import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:iran_gard/pages/tour_details.dart';
import 'package:location/location.dart';

class SearchOnMapPage extends StatefulWidget {
  List<Tour> tours;
  SearchOnMapPage(this.tours, {Key key}) : super(key: key);

  @override
  _SearchOnMapPageState createState() => _SearchOnMapPageState();
}

class _SearchOnMapPageState extends State<SearchOnMapPage> {
  GoogleMapController _controller;
  Location _location = Location();
  Set<Marker> markers = {};

  @override
  void initState() {
    // TODO: implement initState
    for (Tour t in widget.tours) {
      markers.add(Marker(
          markerId: MarkerId(t.id.toString()),
          position: t.startLocation.latlng,
          infoWindow: InfoWindow(title: t.title),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TourDetailsPage(tours: [t], selectedTour: 0)));
          }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(48.0),
                bottomRight: Radius.circular(48.0))),
        centerTitle: true,
        title: Text(
          'جستجو با نقشه',
          style: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Color(0xFF232226)),
        ),
        automaticallyImplyLeading: true,
        elevation: 6.0,
      ),
      // map
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(32.0335651, 54.3893185), zoom: 5),
        onMapCreated: (GoogleMapController _cntlr) {
          _controller = _cntlr;
        },
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: markers,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.gps_fixed,
            size: 32,
            color: Color(0xFF232226),
          ),
          onPressed: () {
            _location.getLocation().then((value) {
              _controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(value.latitude, value.longitude),
                      zoom: 14),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
