import 'package:flutter/material.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/tour.dart';

class SearchPage extends StatefulWidget {

  List<Tour> tours;
  List<User> users;
  SearchPage(this.tours, this.users);

  @override
  _SearchPageState createState() => _SearchPageState();
}

/*List<User> users = [
  User(
    name: 'محمدرضا عباسی',
    id: 'mmdRza',
    isLeader: false,
    image: Image.asset(
      'images/users/user_1',
      fit: BoxFit.cover,
    ),
  ),
  User(
    name: 'علی رضایی',
    id: 'ali71',
    isLeader: true,
    image: Image.asset(
      'images/users/user_2',
      fit: BoxFit.cover,
    ),
  ),
  User(
    name: 'محمد رضایی',
    id: 'mohammmmad',
    isLeader: true,
    image: Image.asset(
      'images/users/user_3',
      fit: BoxFit.cover,
    ),
  ),
  User(
    name: 'farhad karimi',
    id: 'karimi_farhad',
    isLeader: false,
    image: Image.asset(
      'images/users/user_4',
      fit: BoxFit.cover,
    ),
  ),
  User(
    name: 'داوود ظریف',
    id: 'dvd_zrf',
    isLeader: false,
  ),
];*/

List<SearchItem> searchItems = [];
int numOfTours = 0, numOfUsers = 0, numOfLeaders = 0, numOfGroups = 0;

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextController;

  String searchText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchTextController = TextEditingController();
    searchTextController.addListener(() {
      searchText = searchTextController.text.trim();
      searchItems = [];
      numOfTours = 0;
      numOfUsers = 0;
      numOfLeaders = 0;
      numOfGroups = 0;
      if (searchText.isNotEmpty) {
        for (User u in widget.users) {
          if (u.name.contains(searchText) || u.id.contains(searchText)) {
            searchItems.add(SearchItem.fromUser(u));
            if (u.isLeader)
              numOfLeaders++;
            else
              numOfUsers++;
          }
        }
        for (Tour t in widget.tours) {
          if (t.title.contains(searchText))
            searchItems.add(SearchItem.fromTour(t));
          numOfTours++;
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(48.0),
                bottomRight: Radius.circular(48.0))),
        centerTitle: true,
        title: Container(
          width: pageSize.width - 100,
          height: 35.0,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Color(0xFF232226),
                width: 1.5,
              )),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 35.0,
                  width: 32.0,
                  child: Center(
                    child: Icon(
                      Icons.search_rounded,
                      color: Color(0xFF232226),
                    ),
                  )),
              Container(
                width: pageSize.width - 170,
                height: 35.0,
                child: TextField(
                  controller: searchTextController,
                  textDirection: TextDirection.rtl,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontFamily: 'Sans'),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'جستجو...',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.only(
                        right: 8.0, bottom: 8.0, top: 8.0),
                  ),
                ),
              ),
              if (searchText.isNotEmpty)
                InkWell(
                  onTap: () {
                    setState(() {
                      searchTextController.clear();
                    });
                  },
                  child: Container(
                      height: 35.0,
                      width: 32.0,
                      child: Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: Color(0xFF232226),
                        ),
                      )),
                ),
            ],
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      searchItems.length > 10 ? 10 : searchItems.length,
                      (index) {
                    SearchItem si = searchItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      elevation: 3.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.ltr,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              textDirection: TextDirection.ltr,
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  child: Card(
                                    shape: si.type == SearchType.tour
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0))
                                        : CircleBorder(),
                                    child: ClipRRect(
                                      borderRadius: si.type == SearchType.tour
                                          ? BorderRadius.circular(4.0)
                                          : BorderRadius.circular(50.0),
                                      child: si.image == null
                                          ? Image.asset(
                                              'images/no_image_user.png',
                                              fit: BoxFit.cover)
                                          : si.image,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Text(
                                      si.name,
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Sans',
                                          color: Colors.black),
                                    ),
                                    Text(
                                      (si.type == SearchType.tour
                                          ? ''
                                          : '@' + si.id),
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              (si.type == SearchType.leader
                                  ? 'لیدر'
                                  : si.type == SearchType.tour
                                      ? 'تور'
                                      : 'کاربر'),
                              style: TextStyle(
                                color: Colors.green[300],
                                fontFamily: 'Sans',
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ],
          )),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.7,
            ),
            delegate: SliverChildListDelegate([
              if (numOfTours != 0)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 3.0,
                  color: Colors.white,
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: pageSize.width / 6,
                        height: pageSize.width / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          IranGardIcons.backpack,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'مشاهده همه\n تور ها',
                            style: TextStyle(
                                fontFamily: 'Sans',
                                color: Colors.blue,
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.blue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 2.0),
                              child: Text(
                                numOfTours.toString() + ' تور ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sans',
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              if (numOfUsers != 0)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 3.0,
                  color: Colors.white,
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: pageSize.width / 6,
                        height: pageSize.width / 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange,
                        ),
                        child: Icon(
                          IranGardIcons.user,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'مشاهده همه\n کاربران',
                            style: TextStyle(
                                fontFamily: 'Sans',
                                color: Colors.deepOrange,
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.deepOrange,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 2.0),
                              child: Text(
                                numOfUsers.toString() + ' کاربر ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sans',
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              if (numOfLeaders != 0)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 3.0,
                  color: Colors.white,
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: pageSize.width / 6,
                        height: pageSize.width / 6,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.pink),
                        child: Icon(
                          IranGardIcons.leader,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'مشاهده همه\n لیدر ها',
                            style: TextStyle(
                                fontFamily: 'Sans',
                                color: Colors.pink,
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.pink,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 2.0),
                              child: Text(
                                numOfLeaders.toString() + ' لیدر ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sans',
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              if (numOfGroups != 0)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  elevation: 3.0,
                  color: Colors.white,
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: pageSize.width / 6,
                        height: pageSize.width / 6,
                        color: Colors.deepPurple,
                        child: Icon(
                          IranGardIcons.backpack,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'مشاهده همه\n گروه ها',
                            style: TextStyle(
                                fontFamily: 'Sans',
                                color: Colors.deepPurple,
                                fontSize: 14.0),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.deepPurple,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 2.0),
                              child: Text(
                                numOfGroups.toString() + ' گروه ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sans',
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
            ]),
          )
        ],
      ),
    );
  }
}

class User {
  String name, id;
  bool isLeader;
  Image image;

  User({this.name, this.id, this.isLeader, this.image});
}

class SearchItem {
  String name, id;
  Image image;
  SearchType type;

  SearchItem.fromUser(User user) {
    this.name = user.name;
    this.id = user.id;
    this.image = user.image;
    this.type = user.isLeader ? SearchType.leader : SearchType.user;
  }

  SearchItem.fromTour(Tour tour) {
    this.name = tour.title;
    this.image = tour.images[0];
    this.type = SearchType.tour;
  }
}

enum SearchType {
  user,
  leader,
  tour,
}
