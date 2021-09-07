import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/category.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:iran_gard/pages/home.dart';
import 'package:intl/intl.dart' as numberFormatter;

class TourDetailsPage extends StatefulWidget {
  final List<Tour> tours;
  int selectedTour;
  TourDetailsPage({@required this.tours, @required this.selectedTour});

  @override
  _TourDetailsPageState createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  List<int> selecteds = [];
  numberFormatter.NumberFormat formatter;
  List<BuildContext> bcs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formatter = numberFormatter.NumberFormat.decimalPattern();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterBuildFunction(context));
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _showAppbar ? 56.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: AppBar(
                backgroundColor: Colors.white,
                title: new Text(
                  'Explore',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF232226)),
                ),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_rounded,
                        color: Color(0xFF232226)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  controller: _scrollViewController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(widget.tours.length, (index) {
                        Tour tour = widget.tours[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Builder(builder: (context2) {
                            if (index < widget.selectedTour) bcs.add(context2);
                            return Container(
                              decoration: BoxDecoration(
                                  color: tour.categories[0].color,
                                  borderRadius: BorderRadius.circular(32.0),
                                  border: Border.all(
                                      width: 2.0,
                                      color: tour.categories[0].color)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12.0,
                                        top: 8.0,
                                        bottom: 4.0),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 2.0),
                                                  child: Icon(
                                                    Icons.location_on_outlined,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'محل حرکت: ' +
                                                      tour.startLocation.title,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10.0),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 2.0,
                                                          left: 4.0),
                                                  child: Icon(
                                                    IranGardIcons.destination,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'مقصد: ' +
                                                      tour.destination.title,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10.0),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          textDirection: TextDirection.ltr,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: tour.channelImage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Column(
                                              textDirection: TextDirection.rtl,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  tour.channelName,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      //fontFamily: 'Sans',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.0),
                                                  textAlign: TextAlign.right,
                                                ),
                                                Row(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      IranGardIcons.leader,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Text(
                                                      tour.leaderName +
                                                          ' :لیدر',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                          fontFamily: 'Sans',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 10.0),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: (pageSize.width - 12),
                                    height: (pageSize.width - 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                            itemCount: tour.images.length,
                                            reverse: true,
                                            onPageChanged: (pn) {
                                              setState(() {
                                                tour.imageNumber = pn;
                                              });
                                            },
                                            itemBuilder: (context, index) =>
                                                Container(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  16.0)),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      child: tour.images[index],
                                                    ),
                                                  ),
                                                  width: (pageSize.width - 12),
                                                  height: (pageSize.width - 12),
                                                )),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              textDirection: TextDirection.rtl,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                  tour.images.length, (index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0,
                                                          right: 1,
                                                          left: 1),
                                                  child: Image.asset(
                                                    (tour.imageNumber != index
                                                        ? 'images/circle_off.png'
                                                        : 'images/circle_on.png'),
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                );
                                              }),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3.0, left: 12.0, right: 12.0),
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
                                                Icon(
                                                  (tour.isRegistered
                                                      ? IranGardIcons.registered
                                                      : IranGardIcons.register),
                                                  size: 28.0,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Container(
                                                  height: 20.0,
                                                  width: pageSize.width / 4.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                      //color: Colors.white,
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 3.0,
                                                          ),
                                                          child: Text(
                                                            tour.registered
                                                                    .toString() +
                                                                '/' +
                                                                tour.capasity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Sans',
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .white),
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                          ),
                                                        ),
                                                      ),
                                                      ClipRect(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          widthFactor: (tour
                                                                  .registered /
                                                              tour.capasity),
                                                          child: Container(
                                                            width: (pageSize
                                                                    .width /
                                                                4.0),
                                                            color: Colors.white,
                                                            height: 20.0,
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 3.0,
                                                                ),
                                                                child: Text(
                                                                  tour.registered
                                                                          .toString() +
                                                                      '/' +
                                                                      tour.capasity
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Sans',
                                                                      fontSize:
                                                                          12.0,
                                                                      color: tour
                                                                          .categories[
                                                                              0]
                                                                          .color),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  IranGardIcons.share_alt,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Icon(
                                                  IranGardIcons.comment_dots,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (selecteds.contains(index))
                                              setState(() {
                                                selecteds.remove(index);
                                              });
                                            else {
                                              setState(() {
                                                selecteds.add(index);
                                              });
                                            }
                                          },
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    tour.title,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  if (!selecteds
                                                      .contains(index))
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6.0,
                                                              right: 3.0),
                                                      child: Text(
                                                        'بیشتر...',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                            fontFamily: 'Sans',
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 10.0),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              selecteds.contains(index)
                                                  ? SizedBox()
                                                  : Row(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5.0,
                                                                  left: 4.0),
                                                          child: Text(
                                                              Tour.timeUntil(
                                                                  tour.date),
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Sans',
                                                                fontSize: 11.0,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ),
                                                        Icon(
                                                            Icons
                                                                .calendar_today_rounded,
                                                            color: Colors.white,
                                                            size: 18.0),
                                                      ],
                                                    )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        if (selecteds.contains(index))
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              textDirection: TextDirection.rtl,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(tour.subtitle,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Sans',
                                                        fontSize: 11.0,
                                                        color: Colors.white)),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Row(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: [
                                                    Icon(
                                                        Icons.category_outlined,
                                                        size: 18,
                                                        color: Colors.white),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                        'دسته بندی ها: ' +
                                                            getListAsStr(
                                                                Category.getNames(tour
                                                                    .categories)),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily: 'Sans',
                                                            fontSize: 11.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Row(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: [
                                                    Icon(
                                                        IranGardIcons
                                                            .money_bill_wave,
                                                        size: 15,
                                                        color: Colors.white),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                        'هزینه: ' +
                                                            formatter.format(
                                                                tour.price) +
                                                            ' تومان',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily: 'Sans',
                                                            fontSize: 11.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Row(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        color: Colors.white,
                                                        size: 16.0),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                        'زمان حرکت: ' +
                                                            Tour.timeUntil(
                                                                tour.date),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                          fontFamily: 'Sans',
                                                          fontSize: 11.0,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Row(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: [
                                                    Icon(Icons.alarm,
                                                        size: 18,
                                                        color: Colors.white),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                        'مدت: ' +
                                                            tour.duration
                                                                .toString(),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily: 'Sans',
                                                            fontSize: 11.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                Row(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: [
                                                    Icon(IranGardIcons.backpack,
                                                        size: 18,
                                                        color: Colors.white),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                        'لوازم ضروری: ' +
                                                            tour.necessaryStuff,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily: 'Sans',
                                                            fontSize: 11.0,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void afterBuildFunction(BuildContext c) {
    double offset = 0;
    for (BuildContext bc in bcs) {
      RenderBox rb = bc.findRenderObject();
      print('h=' + rb.size.height.toString());
      offset += (rb.size.height + 32);
    }
    _scrollViewController.jumpTo(offset);
  }
}
