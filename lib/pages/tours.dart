import 'package:flutter/material.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/category.dart';
import 'package:iran_gard/models/story.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

List<Story> stories = [
  Story(
      title: 'story جدید',
      logo: AssetImage(
        'images/users/user_1',
      ),
      images: [AssetImage('images/chalkandi_3.jpg')],
      storyType: StoryType.addStory),
  Story(
      title: 'گالری',
      logo: AssetImage(
        'images/gallery.png',
      ),
      storyType: StoryType.gallery),
  Story(
      title: 'لیدر شوید',
      logo: AssetImage(
        'images/no_image_user.png',
      ),
      storyType: StoryType.becomeALeader),
  Story(
      title: 'ممد',
      logo: AssetImage(
        'images/users/user_2',
      ),
      images: [AssetImage('images/chalkandi_3.jpg')],
      storyType: StoryType.story),
  Story(
      title: 'iran tours',
      logo: AssetImage(
        'images/iran_tours.jpg',
      ),
      images: [AssetImage('images/loot_1.jpg')],
      storyType: StoryType.story),
];

List<Tour> registeredTours = [
  Tour(
      title: 'تور کوه نوردی آبشار شوی',
      destination: LocationWithTitle(title: 'آبشار شوی'),
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 7, 25, 12, 30),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 12),
      isRegistered: true,
      price: 200000,
      leaderName: 'ممد',
      necessaryStuff: 'کوله ، ناهار و ابزار کوه نوردی دلخواه',
      lastEvent: '24 ساعت مانده به شروع حرکت',
      lastEventTime: Jalali(1400, 6, 5, 12, 30),
      numberOfNewEvents: 3),
  Tour(
      title: 'تور طبیعت گردی دریاچه سد دز',
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      necessaryStuff: 'کفش مناسب',
      lastEvent: 'رضا: سلام',
      lastEventTime: Jalali(1400, 6, 1, 16, 55),
      numberOfNewEvents: 0),
  Tour(
      title: 'تور کوه نوردی آبشار شوی',
      destination: LocationWithTitle(title: 'آبشار شوی'),
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 8, 25, 17, 00),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 12),
      isRegistered: true,
      price: 200000,
      leaderName: 'ممد',
      necessaryStuff: 'کوله ، ناهار و ابزار کوه نوردی دلخواه',
      lastEvent: 'ممد: سلام',
      lastEventTime: Jalali(1400, 5, 25, 17, 00),
      numberOfNewEvents: 26),
  Tour(
      title: 'تور طبیعت گردی دریاچه سد دز',
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 9, 1, 6, 30),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 8),
      isRegistered: false,
      leaderName: 'رضا',
      price: 150000,
      necessaryStuff: 'کفش مناسب',
      lastEvent: 'رضا: سلام',
      lastEventTime: Jalali(1400, 2, 1, 16, 30),
      numberOfNewEvents: 0),
];

List<Tour> completedTours = [
  Tour(
      title: 'تور کوه نوردی آبشار شوی',
      destination: LocationWithTitle(title: 'آبشار شوی'),
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 7, 1, 6, 30),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 12),
      isRegistered: true,
      price: 200000,
      leaderName: 'ممد',
      necessaryStuff: 'کوله ، ناهار و ابزار کوه نوردی دلخواه',
      lastEvent: '24 ساعت مانده به شروع حرکت',
      lastEventTime: Jalali(1400, 6, 30, 6, 30),
      numberOfNewEvents: 3),
  Tour(
      title: 'تور طبیعت گردی دریاچه سد دز',
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 10, 1, 6, 30),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 8),
      isRegistered: false,
      leaderName: 'رضا',
      price: 150000,
      necessaryStuff: 'کفش مناسب',
      lastEvent: 'رضا: سلام',
      lastEventTime: Jalali(1400, 5, 1, 6, 30),
      numberOfNewEvents: 0),
  Tour(
      title: 'تور کوه نوردی آبشار شوی',
      destination: LocationWithTitle(title: 'آبشار شوی'),
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 9, 1, 7, 00),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 12),
      isRegistered: true,
      price: 200000,
      leaderName: 'ممد',
      necessaryStuff: 'کوله ، ناهار و ابزار کوه نوردی دلخواه',
      lastEvent: 'ممد: سلام',
      lastEventTime: Jalali(1400, 4, 1, 23, 30),
      numberOfNewEvents: 26),
  Tour(
      title: 'تور طبیعت گردی دریاچه سد دز',
      startLocation: LocationWithTitle(title: 'دزفول'),
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
      date: Jalali(1400, 7, 16, 5, 00),
      channelName: 'dezful tourism',
      channelImage: AssetImage('images/dezful_tourism.jpg'),
      duration: DayAndHour(hour: 8),
      isRegistered: false,
      leaderName: 'رضا',
      price: 150000,
      necessaryStuff: 'کفش مناسب',
      lastEvent: 'رضا: سلام',
      lastEventTime: Jalali(1400, 2, 25, 14, 43),
      numberOfNewEvents: 0),
];

class ToursPage extends StatefulWidget {
  @override
  _ToursPageState createState() => _ToursPageState();
}

int showingRTNum = registeredTours.length > 2 ? 2 : registeredTours.length;
int showingCTNum = registeredTours.length > 2 ? 2 : registeredTours.length;

class _ToursPageState extends State<ToursPage> {
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: pageSize.width,
            height: 80.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Row(
                textDirection: TextDirection.rtl,
                children: List.generate(stories.length, (index) {
                  Story story = stories[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          child: Stack(
                            children: [
                              Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: story.logo, fit: BoxFit.cover),
                                    border: Border.all(
                                        width: 2.0, color: Colors.pink)),
                              ),
                              if (story.storyType == StoryType.addStory)
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8.0),
                                            topLeft: Radius.circular(16.0)),
                                        color: Colors.pink),
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          story.title,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Sans', fontSize: 8.0),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          // registered tours
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // title of the tours card
                Positioned(
                  top: 0.0,
                  right: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Color(0xFF001FAB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('تور های ثبت نام شده',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Sans')),
                    ),
                  ),
                ),
                // curve shape in bottom of the tours card
                Positioned(
                  top: showingRTNum * 66.0 + 1.0,
                  bottom: 0.0,
                  child: Container(
                    height: 50,
                    width: pageSize.width - 16,
                    child: CustomPaint(
                      painter: showingRTNum < registeredTours.length
                          ? MoreCurvePainter(Color(0xFF001FAB))
                          : AllCurvePainter(Color(0xFF001FAB)),
                    ),
                  ),
                ),
                // more text
                if (showingRTNum < registeredTours.length)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: (showingRTNum * 66.0 + 28.0), right: 34.0),
                      child: InkWell(
                        onTap: showingRTNum < registeredTours.length
                            ? () {
                                if (showingRTNum + 5 > registeredTours.length) {
                                  setState(() {
                                    showingRTNum = registeredTours.length;
                                  });
                                } else {
                                  setState(() {
                                    showingRTNum += 5;
                                  });
                                }
                              }
                            : null,
                        child: Text('بیشتر',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Sans')),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Column(
                      children: List.generate(showingRTNum, (index) {
                        Tour tour = registeredTours[index];
                        return Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Card(
                                      shape: CircleBorder(),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: tour.images[index],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: pageSize.width - 130,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      FittedBox(
                                        child: Text(tour.title,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontFamily: 'Sans')),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(tour.lastEvent,
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 10.0,
                                              fontFamily: 'Sans')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 58.0,
                              width: 40.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Visibility(
                                    visible: tour.numberOfNewEvents != 0,
                                    replacement: SizedBox(
                                      height: 20.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: Color(0xFF001FAB),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                            ' ' +
                                                tour.numberOfNewEvents
                                                    .toString() +
                                                ' ',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  Text(Tour.timeUntil(tour.lastEventTime),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10.0,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // completed tours
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // title of the tours card
                Positioned(
                  top: 0.0,
                  right: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Color(0xFF001FAB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('تور های پایان یافته',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Sans')),
                    ),
                  ),
                ),
                // curve shape in bottom of the tours card
                Positioned(
                  top: showingCTNum * 66.0 + 1.0,
                  bottom: 0.0,
                  child: Container(
                    height: 50,
                    width: pageSize.width - 16,
                    child: CustomPaint(
                      painter: showingCTNum < completedTours.length
                          ? MoreCurvePainter(Color(0xFF001FAB))
                          : AllCurvePainter(Color(0xFF001FAB)),
                    ),
                  ),
                ),
                // more text
                if (showingCTNum < completedTours.length)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: (showingCTNum * 66.0 + 28.0), right: 34.0),
                      child: InkWell(
                        onTap: showingCTNum < completedTours.length
                            ? () {
                                if (showingCTNum + 5 > completedTours.length) {
                                  setState(() {
                                    showingCTNum = completedTours.length;
                                  });
                                } else {
                                  setState(() {
                                    showingCTNum += 5;
                                  });
                                }
                              }
                            : null,
                        child: Text('بیشتر',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Sans')),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Column(
                      children: List.generate(showingCTNum, (index) {
                        Tour tour = completedTours[index];
                        return Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Card(
                                      shape: CircleBorder(),
                                      child: ClipRRect(
                                        child: tour.images[0],
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: pageSize.width - 130,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      FittedBox(
                                        child: Text(tour.title,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontFamily: 'Sans')),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(tour.lastEvent,
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 10.0,
                                              fontFamily: 'Sans')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 58.0,
                              width: 40.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Visibility(
                                    visible: tour.numberOfNewEvents != 0,
                                    replacement: SizedBox(
                                      height: 20.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        color: Color(0xFF001FAB),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                            ' ' +
                                                tour.numberOfNewEvents
                                                    .toString() +
                                                ' ',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  Text(Tour.timeUntil(tour.lastEventTime),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 10.0,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String getTime(DateTime time) {
  DateTime today = DateTime.now();
  if (time.year == today.year && time.month == today.month) {
    if (time.day == today.day) {
      return time.hour.toString() + ':' + time.minute.toString();
    } else if (time.day == today.day - 1) {
      return 'دیروز';
    } else {
      return time.day.toString() + ' ' + englishMonthes[time.month];
    }
  } else if (time.year == today.year) {
    return time.day.toString() + ' ' + englishMonthes[time.month];
  } else {
    return time.year.toString() +
        '/' +
        time.month.toString() +
        '/' +
        time.day.toString();
  }
}

final List<String> englishMonthes = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class MoreCurvePainter extends CustomPainter {
  final Color paintedColor;
  MoreCurvePainter(this.paintedColor);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = paintedColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 25);
    path.quadraticBezierTo(
        (size.width - 100) * (0.5), 27, size.width - 100, 42);
    path.quadraticBezierTo(size.width, 60, size.width - 2, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class AllCurvePainter extends CustomPainter {
  final Color paintedColor;
  AllCurvePainter(this.paintedColor);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = paintedColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 25);
    path.lineTo(size.width - 8, 27);
    path.quadraticBezierTo((size.width - 2), 27, size.width - 2, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
