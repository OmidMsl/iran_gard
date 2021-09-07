import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/category.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:iran_gard/pages/categories.dart';
import 'package:iran_gard/pages/search_on_map.dart';
import 'package:iran_gard/pages/search_with_gps.dart';
import 'package:iran_gard/pages/tour_details.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<Tour> tours = [
  Tour(
      title: 'تور کوه نوردی آبشار شوی',
      destination: LocationWithTitle(title: 'آبشار شوی'),
      startLocation: LocationWithTitle(
          title: 'دزفول', latlng: LatLng(32.362015, 48.409303)),
      capasity: 30,
      registered: 10,
      categories: [
        Category(
          name: 'کوه نوردی',
          icon: IranGardIcons.climbing,
          color: Colors.deepOrange,
        ),
      ],
      subtitle: 'لوازم ضروری: کوله و ناهار\nمدت زمان: 12 ساعت',
      images: [
        Image.asset('images/shevi_1.jpeg', fit: BoxFit.cover),
        Image.asset('images/shevi_2.jpeg', fit: BoxFit.cover),
        Image.asset('images/shevi_3.jpg', fit: BoxFit.cover),
        Image.asset('images/shevi_4.jpeg', fit: BoxFit.cover),
      ],
      date: Jalali(1400, 6, 21, 12, 30),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 12),
      isRegistered: true,
      price: 200000,
      leaderName: 'ممد',
      necessaryStuff: 'کوله ، ناهار و ابزار کوه نوردی دلخواه'),
  Tour(
      title: 'تور طبیعت گردی دریاچه سد دز',
      startLocation: LocationWithTitle(
          title: 'دزفول', latlng: LatLng(32.378181, 48.418573)),
      destination: LocationWithTitle(title: 'دریاچه پامنار'),
      capasity: 30,
      registered: 0,
      categories: [
        Category(
            name: 'طبیعت گردی', icon: IranGardIcons.nature, color: Colors.green)
      ],
      subtitle: 'لوازم ضروری: شام و ناهار\nمدت زمان: 8 ساعت',
      images: [
        Image.asset('images/shahyoun_1.jpg', fit: BoxFit.cover),
        Image.asset('images/shahyoun_2.jpg', fit: BoxFit.cover),
        Image.asset('images/shahyoun_3.jpg', fit: BoxFit.cover),
      ],
      date: Jalali(1400, 7, 20, 12, 30),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 8),
      isRegistered: false,
      leaderName: 'رضا',
      price: 150000,
      necessaryStuff: 'کفش مناسب'),
  Tour(
      title: 'تور کویر گردی کویر لوت',
      startLocation: LocationWithTitle(
          title: 'اهواز', latlng: LatLng(31.334373, 48.631582)),
      destination: LocationWithTitle(title: 'کویر لوت'),
      capasity: 30,
      registered: 25,
      categories: [
        Category(
            name: 'کویر گردی', icon: IranGardIcons.desert, color: Colors.brown)
      ],
      subtitle:
          'لوازم ضروری:  لباس خواب و اوسایل شخصی\n\nبه همراه ناهار و شام مدت زمان: 48 ساعت',
      images: [
        Image.asset('images/loot_1.jpg', fit: BoxFit.cover),
        Image.asset('images/loot_2.jpg', fit: BoxFit.cover),
      ],
      date: Jalali(1400, 8, 25, 17, 00),
      channelName: 'iran tours',
      channelImage: AssetImage('images/iran_tours.jpg'),
      duration: DayAndHour(day: 2),
      isRegistered: true,
      price: 700000,
      leaderName: 'علی قاسمی',
      necessaryStuff: 'لباس راحتی و لوازم خواب'),
  Tour(
    title: 'تور شنا چالکندی دزفول',
    startLocation:
        LocationWithTitle(title: 'دزفول', latlng: LatLng(32.362015, 48.409303)),
    destination: LocationWithTitle(title: 'چالکندی دزفول'),
    capasity: 10,
    registered: 10,
    categories: [
      Category(
        name: 'شنا و غواصی',
        icon: IranGardIcons.swim,
        color: Colors.blue,
      )
    ],
    subtitle: 'لوازم ضروری: لباس شنا و ناهار\nمدت زمان: 12 ساعت',
    images: [
      Image.asset('images/chalkandi_1.jpg', fit: BoxFit.cover),
      Image.asset('images/chalkandi_1.jpg', fit: BoxFit.cover),
      Image.asset('images/chalkandi_1.jpg', fit: BoxFit.cover),
    ],
    date: Jalali(1400, 9, 1, 6, 30),
    channelName: 'dezful tourism',
    channelImage: AssetImage('images/dezful_tourism.jpg'),
    duration: DayAndHour(hour: 12),
    isRegistered: false,
    price: 300000,
    necessaryStuff: 'لباس شنا',
    leaderName: 'قلی',
  ),
];

class _HomePageState extends State<HomePage> {
  // advertising banners
  List<Image> ads = [
    Image.asset('images/ad_1.jpg', fit: BoxFit.cover),
    Image.asset('images/ad_2.png', fit: BoxFit.cover),
    Image.asset('images/ad_1.jpg', fit: BoxFit.cover),
    Image.asset('images/ad_2.png', fit: BoxFit.cover),
    Image.asset('images/ad_1.jpg', fit: BoxFit.cover),
  ];

  // page controller for advertising banners
  PageController bannerController;
  int showingAd = 0;

  List<int> alarmIndexes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < tours.length; i++) {
      if (tours[i].isRegistered) {
        Jalali j = difference(Jalali.now(), tours[i].date);
        if (j.year == 1 && j.month == 1 && j.day <= 8) {
          alarmIndexes.add(i);
        }
      }
    }
    bannerController = PageController(initialPage: showingAd);
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      int pn = 0;
      try {
        pn = bannerController.page.toInt();
      } catch (e) {}
      if (bannerController.positions.isNotEmpty) {
        // if its the last page go to first page.
        // else go to next page
        if (ads.length - 1 != pn)
          bannerController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        else
          bannerController.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  List<Category> selectedCategories = [];
  List<Tour> categoryTours = [];

  @override
  Widget build(BuildContext context) {
    categoryTours = [];
    if (selectedCategories.isEmpty)
      categoryTours.addAll(tours);
    else
      for (Tour t in tours) {
        for (Category c in selectedCategories) {
          if (t.categories.contains(c)) {
            categoryTours.add(t);
            continue;
          }
        }
      }
    bannerController = PageController(initialPage: showingAd);
    Size pageSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: List.generate(
                    alarmIndexes.length,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TourDetailsPage(
                                tours: [tours[alarmIndexes[index]]],
                                selectedTour: 0)));
                      },
                      child: Card(
                        color: Colors.red[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          side: BorderSide(
                            color: Colors.red[900],
                            width: 1.7,
                          ),
                        ),
                        //margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Tour.timeUntil(
                                        tours[alarmIndexes[index]].date) +
                                    ' مانده تا ' +
                                    tours[alarmIndexes[index]].title,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.red[900], fontFamily: 'Sans'),
                              ),
                              Icon(Icons.alarm_rounded, color: Colors.red[900]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      width: ((pageSize.width - 12) * 0.66) + 3,
                      height: ((pageSize.width - 12) * 0.66) + 6,
                      child: Stack(
                        children: [
                          Container(
                            width: ((pageSize.width - 12) * 0.66) + 3,
                            height: ((pageSize.width - 12) * 0.66) + 6,
                            child: PageView.builder(
                                itemCount: ads.length,
                                reverse: true,
                                controller: bannerController,
                                onPageChanged: (value) {
                                  setState(() {
                                    showingAd = value;
                                  });
                                },
                                itemBuilder: (_, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0)),
                                      side: BorderSide(
                                        color: Color(0xFF615D6C),
                                        width: 1.7,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: ads[index],
                                    ),
                                  );
                                }),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(ads.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 1, left: 1),
                                    child: Image.asset(
                                      (showingAd != index
                                          ? 'images/circle_off.png'
                                          : 'images/circle_on.png'),
                                      height: 8,
                                      width: 8,
                                    ),
                                  );
                                }),
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SearchWithGPSPage(tours)));
                          },
                          child: Container(
                            width: (pageSize.width - 12) / 3,
                            height: ((pageSize.width - 12) / 3) - 4,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                    width: 1.7, color: Colors.lightBlue)),
                            child: Column(
                              children: [
                                Container(
                                  width: (pageSize.width - 12) / 3,
                                  height: ((pageSize.width - 12) / 3) - 27.4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset(
                                        'images/find_by_location.png',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      'جستجوی تور با gps',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'Sans',
                                          color: Colors.white,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchOnMapPage(tours)));
                          },
                          child: Container(
                            width: (pageSize.width - 12) / 3,
                            height: ((pageSize.width - 12) / 3) - 4,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(16.0),
                                border:
                                    Border.all(width: 1.7, color: Colors.pink)),
                            child: Column(
                              children: [
                                Container(
                                  width: (pageSize.width - 12) / 3,
                                  height: ((pageSize.width - 12) / 3) - 27.4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset('images/find_on_map.jpg',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      'جستجو از روی نقشه',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'Sans',
                                          color: Colors.white,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
                            if (value != null)
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
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: (cat.icon == IranGardIcons.bout
                                          ? 32.0
                                          : 0.0)),
                                  child: Icon(
                                    cat.icon,
                                    color: selectedCategories != null &&
                                            selectedCategories.contains(cat)
                                        ? Colors.white
                                        : cat.color,
                                  ),
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
                            onPressed: () {
                              setState(() {
                                if (selectedCategories.contains(cat)) {
                                  selectedCategories.remove(cat);
                                } else {
                                  selectedCategories.add(cat);
                                }
                              });
                            },
                          ),
                        );
                      })),
                ),
              ],
            ),
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
                                tours: tours,
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

String getListAsStr(List<String> inp) {
  String res = "";
  for (String s in inp) {
    res += s;
    if (s != inp.last) {
      res += ', ';
    }
  }
  return res;
}
