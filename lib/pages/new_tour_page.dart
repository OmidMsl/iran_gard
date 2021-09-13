import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iran_gard/iran_gard_icons_icons.dart';
import 'package:iran_gard/models/category.dart';
import 'package:iran_gard/models/tour.dart';
import 'package:iran_gard/pages/categories.dart';
import 'package:iran_gard/pages/map.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

Tour tour = Tour(
    title: 'تور طبیعت گردی دریاچه سد دز',
    startLocation:
        LocationWithTitle(title: 'دزفول', latlng: LatLng(32.378150, 48.418570)),
    destination: LocationWithTitle(
        title: 'دریاچه پامنار', latlng: LatLng(32.378281, 48.418499)),
    capasity: 30,
    registered: 0,
    categories: [
      Category(
          name: 'طبیعت گردی', icon: IranGardIcons.nature, color: Colors.green)
    ],
    subtitle: 'لوازم ضروری: شام و ناهار\nمدت زمان: 8 ساعت',
    images: [],
    date: Jalali(1400, 7, 20, 12, 30),
    channelName: 'dezful tourism',
    channelImage: Image.asset('images/dezful_tourism.jpg', fit: BoxFit.cover),
    duration: DayAndHour(hour: 8),
    isRegistered: false,
    leaderName: 'رضا',
    price: 150000,
    necessaryStuff: 'کفش مناسب');

List<String> base64Images = [];

class NewTourPage extends StatefulWidget {
  const NewTourPage({Key key}) : super(key: key);

  @override
  _NewTourPageState createState() => _NewTourPageState();
}

class _NewTourPageState extends State<NewTourPage> {
  TextEditingController titleTextController,
      subtitleTextController,
      capasityTextController,
      durationDaysTextController,
      durationHoursTextController,
      leaderNameTextController,
      priceTextController,
      necessaryStuffTextController;
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
    titleTextController = TextEditingController(text: tour.title);
    subtitleTextController = TextEditingController(text: tour.subtitle);
    capasityTextController =
        TextEditingController(text: tour.capasity.toString());
    durationDaysTextController =
        TextEditingController(text: tour.duration.day.toString());
    durationHoursTextController =
        TextEditingController(text: tour.duration.hour.toString());
    leaderNameTextController = TextEditingController(text: tour.leaderName);
    priceTextController = TextEditingController(text: tour.price.toString());
    necessaryStuffTextController =
        TextEditingController(text: tour.necessaryStuff);
  }

  @override
  Widget build(BuildContext context) {
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
          'تور جدید',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'مبدا',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  showLocationDialog(
                      context, tour.startLocation, LocationType.startPoint);
                },
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  shadowColor: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey[800],
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          tour.startLocation.title,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Sans', color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'مقصد',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  showLocationDialog(
                      context, tour.destination, LocationType.destination);
                },
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  shadowColor: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          IranGardIcons.destination,
                          color: Colors.grey[800],
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          tour.destination.title,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Sans', color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'دسته بندی ها',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                    minWidth: pageSize.width - 20,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children:
                        List.generate(tour.categories.length + 1, (index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                side: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.5,
                                ),
                              )),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => CategoriesPage(
                                            selectedCategories: tour.categories,
                                          )))
                                  .then((newCategories) {
                                setState(() {
                                  tour.categories = newCategories;
                                });
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 32.0,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        );
                      } else {
                        Category cat = categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
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
                                    color: cat.color,
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  cat.name,
                                  style: TextStyle(
                                      fontFamily: 'Sans',
                                      fontSize: 11.0,
                                      color: Colors.black),
                                  textDirection: TextDirection.rtl,
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'عنوان',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Container(
                  child: TextField(
                    controller: titleTextController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'عنوان تور',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontFamily: 'Sans',
                          fontSize: 14.0),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(
                          right: 8.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'توضیحات',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Container(
                  child: TextField(
                    controller: subtitleTextController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    minLines: 3,
                    maxLines: 20,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'کاربر در مورد تور باید بداند که ...',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontFamily: 'Sans',
                          fontSize: 14.0),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(
                          right: 8.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'ظرفیت',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Container(
                  child: TextField(
                    controller: capasityTextController,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    textDirection: TextDirection.rtl,
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'نفر',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontFamily: 'Sans',
                          fontSize: 14.0),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(
                          right: 8.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'تصاویر',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              Container(
                width: pageSize.width,
                height: (pageSize.width - 12) / 3,
                child: ReorderableListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      Image oi = tour.images.removeAt(oldIndex);
                      tour.images.insert(
                          (oldIndex > newIndex ? newIndex : newIndex - 1), oi);
                    });
                    String oi = base64Images.removeAt(oldIndex);
                    base64Images.insert(
                        (oldIndex > newIndex ? newIndex : newIndex - 1), oi);
                  },
                  header: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size.fromRadius((pageSize.width / 5) - 12)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          side: BorderSide(
                            color: Theme.of(context).accentColor,
                            width: 1.5,
                          ),
                        )),
                      ),
                      onPressed: () {
                        ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((xFile) {
                          File f = File(xFile.path);
                          base64Images.add(base64Encode(f.readAsBytesSync()));
                          f.readAsBytes().then((bytes) {
                            setState(() {
                              tour.images.add(Image.memory(bytes));
                            });
                          });
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 32.0,
                            color: Theme.of(context).accentColor,
                          ),
                          Text('افزودن تصویر',
                              style: TextStyle(
                                  fontFamily: "sans",
                                  color: Theme.of(context).accentColor))
                        ],
                      ),
                    ),
                  ),
                  children: List.generate(tour.images.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      key: ValueKey(index),
                      child: InkWell(
                        onTap: () {
                          showImageOptionsDialog(context, index);
                        },
                        child: Container(
                          width: (pageSize.width - 12) / 3,
                          height: (pageSize.width - 12) / 3,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: tour.images[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'تاریخ حرکت',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              InkWell(
                onTap: () async {
                  showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali.now(),
                    lastDate: Jalali(1410, 12),
                  ).then((pickedDate) {
                    showPersianTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget child) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: child,
                        );
                      },
                    ).then((pickerTime) {
                      if (pickedDate != null &&
                          pickerTime != null &&
                          (pickedDate.year != tour.date.year ||
                              pickedDate.month != tour.date.month ||
                              pickedDate.day != tour.date.day ||
                              pickerTime.hour != tour.date.hour ||
                              pickedDate.minute != tour.date.minute)) {
                        setState(() {
                          tour.date.copy(
                              year: pickedDate.year,
                              month: pickedDate.month,
                              day: pickedDate.day,
                              hour: pickerTime.hour,
                              minute: pickerTime.minute);
                        });
                      }
                    });
                  });
                },
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  shadowColor: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey[800],
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          tour.getDateAsStr(),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Sans', color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'مدت زمان',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    width: pageSize.width / 4,
                    child: Card(
                      color: Colors.white,
                      elevation: 6,
                      shadowColor: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          width: 1.5,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      child: Container(
                        child: TextField(
                          controller: durationDaysTextController,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          textDirection: TextDirection.rtl,
                          cursorColor: Theme.of(context).accentColor,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontFamily: 'Sans',
                              fontSize: 14.0),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'روز',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontFamily: 'Sans',
                                fontSize: 14.0),
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.only(
                                right: 8.0, bottom: 8.0, top: 8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'روز',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Container(
                    width: pageSize.width / 4,
                    child: Card(
                      color: Colors.white,
                      elevation: 6,
                      shadowColor: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          width: 1.5,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      child: Container(
                        child: TextField(
                          controller: durationHoursTextController,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          textDirection: TextDirection.rtl,
                          cursorColor: Theme.of(context).accentColor,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontFamily: 'Sans',
                              fontSize: 14.0),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ساعت',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                                color: Colors.black26,
                                fontFamily: 'Sans',
                                fontSize: 14.0),
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.only(
                                right: 8.0, bottom: 8.0, top: 8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'ساعت',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'نام لیدر',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Container(
                  child: TextField(
                    controller: leaderNameTextController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'نام لیدر',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontFamily: 'Sans',
                          fontSize: 14.0),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(
                          right: 8.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'قیمت (به ریال)',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Color(0xFFC33F3E)),
                  )
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Container(
                  child: TextField(
                    controller: priceTextController,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    textDirection: TextDirection.rtl,
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'قیمت به ریال',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontFamily: 'Sans',
                          fontSize: 14.0),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(
                          right: 8.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'لوازم ظروری',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'Sans', color: Colors.grey[600]),
                  ),
                ],
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shadowColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: Container(
                  child: TextField(
                    controller: necessaryStuffTextController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'Sans',
                        fontSize: 14.0),
                    minLines: 3,
                    maxLines: 20,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'کاربر چه ابزار ضروری (یا اختیاری) را باید همراه خود داشته باشد؟ ',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                          color: Colors.black26,
                          fontFamily: 'Sans',
                          fontSize: 14.0),
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(
                          right: 8.0, bottom: 8.0, top: 8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
          duration: Duration(),
          child: FloatingActionButton.extended(
            onPressed: () {
              insertTour();
            },
            backgroundColor: Color(0xFF001FAB),
            isExtended: _isFabExtended,
            label: _isFabExtended
                ? Text('ذخیره',
                    style: TextStyle(fontFamily: "sans", color: Colors.white))
                : Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  ),
            icon: _isFabExtended
                ? Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  )
                : null,
          )),
    );
  }

  void showImageOptionsDialog(BuildContext context, int index) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    child: Text(
                      'حذف تصویر',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: Color(0xff6f6f6f)),
                    ),
                    onTap: () {
                      setState(() {
                        tour.images.removeAt(index);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 32.0, right: 32.0),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void showLocationDialog(
      BuildContext context, LocationWithTitle lwt, LocationType locationType) {
    TextEditingController locationTitleTextController =
        TextEditingController(text: lwt.title ?? '');
    GoogleMapController _controller;
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'عنوان موقعیت',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: Color(0xFFC33F3E)),
                      )
                    ],
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 6,
                    shadowColor: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        width: 1.5,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    child: Container(
                      child: TextField(
                        controller: locationTitleTextController,
                        textDirection: TextDirection.rtl,
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontFamily: 'Sans',
                            fontSize: 14.0),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'عنوان موقعیت',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: TextStyle(
                              color: Colors.black26,
                              fontFamily: 'Sans',
                              fontSize: 14.0),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.only(
                              right: 8.0, bottom: 8.0, top: 8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'موقعیت',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: Color(0xFFC33F3E)),
                      )
                    ],
                  ),
                  // small map
                  SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.3,
                        widthFactor: 2.5,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          onMapCreated: (GoogleMapController _cntlr) {
                            _controller = _cntlr;
                          },
                          onTap: (LatLng location) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => MapPage(
                                          initialcameraposition: lwt.latlng ==
                                                  null
                                              ? CameraPosition(
                                                  target: LatLng(
                                                      32.0335651, 54.3893185),
                                                  zoom: 5)
                                              : CameraPosition(
                                                  target: lwt.latlng, zoom: 14),
                                        )))
                                .then((loc) {
                              if (loc != null) {
                                lwt.latlng = loc;
                                _controller.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(target: loc, zoom: 14),
                                  ),
                                );
                              }
                            });
                          },
                          initialCameraPosition: lwt.latlng == null
                              ? CameraPosition(
                                  target: LatLng(32.0335651, 54.3893185),
                                  zoom: 3)
                              : CameraPosition(target: lwt.latlng, zoom: 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor,
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      )),
                    ),
                    child: Center(
                      child: Text(
                        'ذخیره موقعیت',
                        style: TextStyle(
                            fontFamily: 'Sans',
                            fontSize: 14.0,
                            color: Colors.white),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (locationType == LocationType.startPoint) {
                          tour.startLocation.title =
                              locationTitleTextController.text;
                          tour.startLocation.latlng = lwt.latlng;
                        } else {
                          tour.destination.title =
                              locationTitleTextController.text;
                          tour.destination.latlng = lwt.latlng;
                        }
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 32.0, right: 32.0),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void insertTour() {
    if (tour.startLocation == null ||
        tour.startLocation.title == null ||
        tour.startLocation.latlng == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("لطفا مبدا را مشخص نمایید"),
      ));
    } else if (tour.destination == null ||
        tour.destination.title == null ||
        tour.destination.latlng == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("لطفا مقصد را مشخص نمایید"),
      ));
    } else if (tour.categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("حداقل یک دسته بندی مشخص نمایید"),
      ));
    } else if (titleTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("عنوان را مشخص نمایید"),
      ));
    } else if (capasityTextController.text.trim().isEmpty ||
        int.parse(capasityTextController.text.trim()) == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ظرفیت را مشخص نمایید"),
      ));
    } else if (base64Images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("حداقل یک تصویر اضافه کنید"),
      ));
    } else if (tour.date == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("لطفا تاریخ حرکت را مشخص نمایید"),
      ));
    } else if ((durationDaysTextController.text.trim().isEmpty ||
            int.parse(durationDaysTextController.text.trim()) == 0) &&
        (durationHoursTextController.text.trim().isEmpty ||
            int.parse(durationHoursTextController.text.trim()) == 0)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("مدت زمان را مشخص نمایید"),
      ));
    } else if (leaderNameTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("نام لیدر را مشخص نمایید"),
      ));
    } else if (priceTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("قیمت تور را مشخص نمایید"),
      ));
    } else {
      String cats = '';
      for (Category c in tour.categories) {
        cats += c.name + ',';
      }
      post(
        Uri.parse("http://irangard.freehost.io/addTour.php"),
        body: {
          'title': titleTextController.text.trim(),
          'subtitle': subtitleTextController.text.trim(),
          'startLocation': tour.startLocation.title +
              'lt' +
              tour.startLocation.latlng.latitude.toString() +
              'lt' +
              tour.startLocation.latlng.longitude.toString(),
          'destination': tour.destination.title +
              'lt' +
              tour.destination.latlng.latitude.toString() +
              'lt' +
              tour.destination.latlng.longitude.toString(),
          'categories': cats,
          'capasity': capasityTextController.text.trim(),
          'registered': '0',
          'price': priceTextController.text.trim(),
          'channelName': tour.channelName,
          'isRegistered': '0',
          'necessaryStuff': necessaryStuffTextController.text.trim(),
          'lastEvent': 'تور ایجاد شد',
          'date': tour.date.year.toString() +
              ' ' +
              tour.date.month.toString() +
              ' ' +
              tour.date.day.toString() +
              ' ' +
              tour.date.hour.toString() +
              ' ' +
              tour.date.minute.toString(),
          'lastEventTime': Jalali.now().year.toString() +
              ' ' +
              Jalali.now().month.toString() +
              ' ' +
              Jalali.now().day.toString() +
              ' ' +
              Jalali.now().hour.toString() +
              ' ' +
              Jalali.now().minute.toString(),
          'numberOfNewEvents': '0',
          'duration': tour.duration.day.toString() +
              ' ' +
              tour.duration.hour.toString(),
        },
      ).then((response) {
        print(response.statusCode);
        String res = utf8.decode(response.bodyBytes);
        print(res);
        uploadImages(res);
      });
      Navigator.of(context).pop(tour);
    }
  }

  void uploadImages(String id) {
    String imgs = '';
    for (int i = 0; i < base64Images.length; i++) {
      String imgName = id + '_tour_img_$i.jpeg';
      imgs += imgName + ',';
      post(Uri.parse("http://irangard.freehost.io/addImage.php"), body: {
        "image": base64Images[i],
        "name": imgName,
      }).then((result) {
        print(
            imgName + ' # ' + result.statusCode.toString() + ':' + result.body);
      });
    }
    post(Uri.parse("http://irangard.freehost.io/setImageNames.php"), body: {
      "images": imgs,
      "id": id,
    }).then((result) {
      print(result.statusCode.toString() + ':' + result.body);
    });
  }
}

enum LocationType {
  startPoint,
  destination,
}
