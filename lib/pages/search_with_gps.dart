import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/category.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:iran_gard/pages/categories.dart';
import 'package:iran_gard/pages/tour_details.dart';
import 'package:location/location.dart';

class SearchWithGPSPage extends StatefulWidget {
  List<Tour> tours;
  SearchWithGPSPage(this.tours, {Key key}) : super(key: key);

  @override
  _SearchWithGPSPageState createState() => _SearchWithGPSPageState();
}

class _SearchWithGPSPageState extends State<SearchWithGPSPage> {
  Location _location = Location();
  List<Tour> locatedTours = [];
  List<Category> selectedCategories = [];
  List<Tour> categoryTours = [];

  @override
  void initState() {
    // TODO: implement initState
    _location.hasPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        _location.serviceEnabled().then((serviceEnable) {
          if (serviceEnable) {
            print('service is enabled');
            _location.getLocation().then((loc) {
              print('location received');
              for (Tour t in widget.tours) {
                if (calculateDistance(LatLng(loc.latitude, loc.longitude),
                        t.startLocation.latlng) <=
                    10000)
                  setState(() {
                    locatedTours.add(t);
                  });
              }
            });
          } else {
            _location.requestService().then((requestResult) {
              if (requestResult) {
                print('service enabled');
                _location.getLocation().then((loc) {
                  for (Tour t in widget.tours) {
                    if (calculateDistance(LatLng(loc.latitude, loc.longitude),
                            t.startLocation.latlng) <=
                        10000) locatedTours.add(t);
                  }
                });
              }
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryTours = [];
    if (selectedCategories.isEmpty)
      categoryTours.addAll(locatedTours);
    else
      for (Tour t in locatedTours) {
        for (Category c in selectedCategories) {
          if (t.categories.contains(c)) {
            categoryTours.add(t);
            continue;
          }
        }
      }
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(48.0),
                bottomRight: Radius.circular(48.0))),
        centerTitle: true,
        title: Text(
          'جستجو با موقعیت',
        ),
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'دسته بندی ها',
                      style: TextStyle(
                          fontFamily: 'Sans',
                          color: Color(0xFF615D6C),
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: Text(
                        'مشاهده همه (' + categories.length.toString() + ')',
                        style: TextStyle(
                            fontFamily: 'Sans',
                            color: Color(0xFF615D6C),
                            fontSize: 12.0),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => CategoriesPage(
                                      selectedCategories: selectedCategories,
                                    )))
                            .then((value) {
                          setState(() {
                            selectedCategories = value;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                    textDirection: TextDirection.rtl,
                    children: List.generate(categories.length, (index) {
                      Category cat = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selectedCategories != null &&
                                        selectedCategories.contains(cat)
                                    ? cat.color
                                    : Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(
                                color: cat.color,
                                width: 0.8,
                              ),
                            )),
                          ),
                          onPressed: () {
                            setState(() {
                              if (selectedCategories.contains(cat)) {
                                selectedCategories.remove(cat);
                              } else {
                                selectedCategories.add(cat);
                              }
                            });
                          },
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: (cat.icon == IranGardIcons.bout
                                        ? 32.0
                                        : 0.0)),
                                child: Icon(cat.icon,
                                    color: selectedCategories != null &&
                                            selectedCategories.contains(cat)
                                        ? Colors.white
                                        : cat.color),
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                cat.name,
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontSize: 11.0,
                                    color: selectedCategories != null &&
                                            selectedCategories.contains(cat)
                                        ? Colors.white
                                        : Colors.black),
                                textDirection: TextDirection.rtl,
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ]),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildListDelegate(
              List.generate(categoryTours.length, (index) {
                Tour tour = categoryTours[index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TourDetailsPage(
                                tours: widget.tours,
                                selectedTour: index,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: tour.categories[0].color,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              width: 1.2, color: tour.categories[0].color)),
                      child: Column(
                        children: [
                          Container(
                            width: (pageSize.width - 12) / 3,
                            height: ((pageSize.width - 12) / 3) - 34,
                            child: Card(
                              margin: EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: tour.images[0],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2.0),
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          tour.startLocation.title,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'Sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 6.0),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2.0, left: 2.0),
                                          child: Icon(
                                            Icons.calendar_today_rounded,
                                            size: 8,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          Tour.timeUntil(tour.date),
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontFamily: 'Sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 6.0),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  tour.title,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontFamily: 'Sans',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 8.0),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

double calculateDistance(LatLng p1, LatLng p2) {
  var a = 0.5 -
      cos((p2.latitude - p1.latitude) * pi) / 2 +
      cos(p1.latitude * pi) *
          cos(p2.latitude * pi) *
          (1 - cos((p2.longitude - p1.longitude) * pi)) /
          2;
  return 12742 * asin(sqrt(a));
}
