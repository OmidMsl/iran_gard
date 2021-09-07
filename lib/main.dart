import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:iran_gard/pages/chats.dart';
import 'package:iran_gard/pages/home.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/pages/new_tour_page.dart';
import 'package:iran_gard/pages/profile.dart';
import 'package:iran_gard/pages/search.dart';
import 'package:iran_gard/pages/tours.dart';
import 'package:iran_gard/widgets/bottom_nav_bar.dart';

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

  HomePage home = HomePage();
  ToursPage tours = ToursPage();
  ChatsPage chats = ChatsPage();
  ProfilePage profile = ProfilePage();

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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage()));
              })
        ],
      ),
      body: _pageNumber == 3
          ? home
          : _pageNumber == 2
              ? tours
              : _pageNumber == 1
                  ? chats
                  : profile,
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewTourPage()));
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
}
