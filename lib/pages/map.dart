import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  CameraPosition initialcameraposition;

  MapPage({Key key, @required this.initialcameraposition}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _controller;
  Location _location = Location();
  Marker marker;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.initialcameraposition.zoom != 5)
      marker = Marker(
          markerId: MarkerId('تعیین محل'),
          position: widget.initialcameraposition.target);
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
          'افزودن موقعیت',
          style: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Color(0xFF232226)),
        ),
        automaticallyImplyLeading: true,
        elevation: 6.0,
        actions: [
          if (marker != null)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).accentColor,
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(48.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                )),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'تایید',
                    style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 14.0,
                        color: Colors.white),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.done,
                    color: Colors.white,
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop(marker.position);
              },
            ),
        ],
      ),
      // map
      body: GoogleMap(
        initialCameraPosition: widget.initialcameraposition,
        onMapCreated: (GoogleMapController _cntlr) {
          _controller = _cntlr;
        },
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: {if (marker != null) marker},
        onLongPress: (LatLng ll) {
          setState(() {
            marker = Marker(markerId: MarkerId('تعیین محل'), position: ll);
          });
        },
        onTap: (LatLng ll) {
          if (marker != null)
            setState(() {
              marker = Marker(markerId: MarkerId('تعیین محل'), position: ll);
            });
        },
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
