import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:iran_gard/models/category.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:iran_gard/pages/categories.dart';
import 'package:iran_gard/pages/chats.dart';
import 'package:iran_gard/pages/home.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/pages/new_tour_page.dart';
import 'package:iran_gard/pages/profile.dart';
import 'package:iran_gard/pages/search.dart';
import 'package:iran_gard/pages/tours.dart';
import 'package:iran_gard/widgets/bottom_nav_bar.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main() {
  runApp(MyApp());
}

// main color theme
const MaterialColor myColor = MaterialColor(0xFF00E36A, const <int, Color>{
  50: Color.fromRGBO(0, 277, 106, .1),
  100: Color.fromRGBO(0, 277, 106, .2),
  200: Color.fromRGBO(0, 277, 106, .3),
  300: Color.fromRGBO(0, 277, 106, .4),
  400: Color.fromRGBO(0, 277, 106, .5),
  500: Color.fromRGBO(0, 277, 106, .6),
  600: Color.fromRGBO(0, 277, 106, .7),
  700: Color.fromRGBO(0, 277, 106, .8),
  800: Color.fromRGBO(0, 277, 106, .9),
  900: Color.fromRGBO(0, 277, 106, 1),
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ایرانگرد',
      theme: ThemeData(
          primarySwatch: myColor,
          accentColor: Color(0xFF001FAB),
          appBarTheme: AppBarTheme(
            color: myColor,
            titleTextStyle: TextStyle(
                fontFamily: 'Sans',
                fontSize: 18.0,
                color: Color(0xFF232226),
                fontWeight: FontWeight.bold),
            centerTitle: true,
            iconTheme: IconThemeData(
              size: 20.0,
              color: Color(0xFF232226),
            ),
            actionsIconTheme: IconThemeData(
              size: 20.0,
              color: Color(0xFF232226),
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
          )),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> pageTitles = ['پروفایل', 'گفتگو ها', 'تور های من', 'خانه'];

  List<Tour> tours = [];
  List<User> users = [];

  int _pageNumber = 3;
  bool _isFabExtended = true;
  bool upDirection = true, flag = true;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        upDirection = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward;

        // makes sure we don't call setState too much, but only when it is needed
        if (upDirection != flag)
          setState(() {
            _isFabExtended = !_isFabExtended;
          });

        flag = upDirection;
      });
    getTours();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
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
          _pageNumber == 3 ? 'ایرانگرد' : pageTitles[_pageNumber],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.search_rounded, color: Color(0xFF232226)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPage(tours, users)));
              })
        ],
      ),
      body: _pageNumber == 3
          ? HomePage(tours)
          : _pageNumber == 2
              ? ToursPage(tours)
              : _pageNumber == 1
                  ? ChatsPage()
                  : ProfilePage(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 60,
        color: Color(0xFF00E36A),
        index: _pageNumber,
        letIndexChange: (value) {
          setState(() {
            _pageNumber = value;
          });
          return true;
        },
        buttonBackgroundColor: Color(0xFF001FAB),
        itemTitles: pageTitles,
        textStyle: TextStyle(
            fontFamily: 'Sans',
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold),
        items: <Widget>[
          Icon(
            IranGardIcons.profile,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            IranGardIcons.chats,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            IranGardIcons.tours,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            IranGardIcons.home,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: AnimatedContainer(
          duration: Duration(),
          child: Visibility(
            visible: _pageNumber == 2,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => NewTourPage()))
                    .then((value) {
                  setState(() {
                    tours.add(value);
                  });
                });
              },
              backgroundColor: Color(0xFF001FAB),
              isExtended: _isFabExtended,
              label: _isFabExtended
                  ? Text('تور جدید',
                      style: TextStyle(fontFamily: "sans", color: Colors.white))
                  : Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
              icon: _isFabExtended
                  ? Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    )
                  : null,
            ),
          )),
    );
  }

  void getTours() async {
    Response response =
        await get(Uri.parse("http://irangard.freehost.io/getTours.php"));
    String data = utf8.decode(response.bodyBytes);
    print('data: ' + data);
    if (!data.contains('error')) {
      var tourJson = json.decode(data);
      for (var tj in tourJson) {
        List<String> startLoc = (tj['startLocation']).split('lt');
        List<String> destLoc = (tj['destination']).split('lt');
        List<Category> cats = [];
        List<String> ctstr = (tj['categories']).split(',');
        for (String s in ctstr) {
          for (Category c in categories) {
            if (c.name == s) {
              cats.add(c);
            }
          }
        }
        List<String> imgNames = tj['images'].split(',');
        imgNames.remove('');
        List<String> datestr = (tj['date']).split(' ');
        List<String> letstr = (tj['lastEventTime']).split(' ');
        List<String> durstr = (tj['duration']).split(' ');

        Tour t = Tour(
            id: int.parse(tj['id']),
            title: tj['title'],
            subtitle: tj['subtitle'],
            startLocation: LocationWithTitle(
                title: startLoc[0],
                latlng: LatLng(
                    double.parse(startLoc[1]), double.parse(startLoc[2]))),
            destination: LocationWithTitle(
                title: destLoc[0],
                latlng:
                    LatLng(double.parse(destLoc[1]), double.parse(destLoc[2]))),
            categories: cats,
            capasity: int.parse(tj['capasity']),
            registered: int.parse(tj['registered']),
            price: int.parse(tj['price']),
            imgNames: imgNames,
            channelName: tj['channelName'],
            channelImageName: tj['channelImage'],
            isRegistered: tj['isRegistered'] == '1',
            necessaryStuff: tj['necessaryStuff'],
            lastEvent: tj['lastEvent'],
            date: Jalali(
                int.parse(datestr[0]),
                int.parse(datestr[1]),
                int.parse(datestr[2]),
                int.parse(datestr[3]),
                int.parse(datestr[4])),
            lastEventTime: Jalali(
                int.parse(letstr[0]),
                int.parse(letstr[1]),
                int.parse(letstr[2]),
                int.parse(letstr[3]),
                int.parse(letstr[4])),
            numberOfNewEvents: int.parse(tj['numberOfNewEvents']),
            duration: DayAndHour(
                day: int.parse(durstr[0]), hour: int.parse(durstr[1])));
        setState(() {
          tours.add(t);
        });
      }
      getFirstImages();
    }
  }

  void getFirstImages() async {
    for (Tour t in tours) {
      if (t.images == null || t.images.isEmpty) {
        t.images = [];

        setState(() {
          t.images.add(Image.network(
              'http://irangard.freehost.io/pics/' + t.imgNames[0],
              fit: BoxFit.cover));
        });
      }
    }
  }

  void getUsers() async {
    Response response =
        await get(Uri.parse("http://irangard.freehost.io/getUsers.php"));
    String data = utf8.decode(response.bodyBytes);
    print('data: ' + data);
    if (!data.contains('error')) {
      var userJson = json.decode(data);
      for (var uj in userJson) {
        User u = User(
          id: uj['id'],
          name: uj['name'],
          isLeader: uj['isLeader'] == '1',
          image: uj['image'] == null
              ? null
              : Image.network('http://irangard.freehost.io/pics/' + uj['image'],
                  fit: BoxFit.cover),
        );
        setState(() {
          users.add(u);
        });
      }
    }
  }
}
