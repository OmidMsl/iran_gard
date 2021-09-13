import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iran_gard/models/category.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class Tour {
  int id;
  String title, subtitle;
  LocationWithTitle startLocation, destination;
  List<Category> categories;
  int capasity, registered, price;
  List<Image> images;
  List<String> imgNames;
  String channelName, leaderName;
  Image channelImage;
  String channelImageName;
  bool isRegistered;
  String necessaryStuff;
  int imageNumber = 0;
  String lastEvent;
  Jalali date, lastEventTime;
  int numberOfNewEvents;
  DayAndHour duration;

  Tour(
      {this.id,
      this.title,
      this.destination,
      this.startLocation,
      this.subtitle,
      this.categories,
      this.capasity,
      this.registered,
      this.images,
      this.imgNames,
      this.date,
      this.leaderName,
      this.channelName,
      this.channelImage,
      this.channelImageName,
      this.duration,
      this.isRegistered,
      this.price,
      this.necessaryStuff,
      this.lastEvent,
      this.lastEventTime,
      this.numberOfNewEvents});

  String getDateAsStr() {
    return daysOfWeek[date.weekDay - 1] +
        ' ' +
        date.day.toString() +
        ' ' +
        monthesOfYear[date.month - 1] +
        ' ' +
        date.year.toString() +
        '. ساعت ' +
        date.hour.toString() +
        ':' +
        date.minute.toString();
  }

  static String timeUntil(Jalali j) {
    Jalali diff = difference(Jalali.now(), j);
    if (Jalali.now().isBefore(j)) {
      if (diff.year > 1) {
        return (diff.year - 1).toString() +
            ' سال و ' +
            (diff.month - 1).toString() +
            ' ماه';
      } else if (diff.month > 1) {
        return (diff.month - 1).toString() +
            ' ماه و ' +
            (diff.day - 1).toString() +
            ' روز';
      } else if (diff.day > 1) {
        return (diff.day - 1).toString() +
            ' روز و ' +
            diff.hour.toString() +
            ' ساعت';
      } else if (diff.hour > 1) {
        return diff.hour.toString() +
            ' ساعت و ' +
            diff.minute.toString() +
            ' دقیقه';
      } else if (diff.minute > 1) {
        return diff.minute.toString() + ' دقیقه';
      } else
        return 'هم اکنون';
    } else {
      if (diff.year > 1) {
        return (diff.year - 1).toString() + ' سال پیش';
      } else if (diff.month > 1) {
        return (diff.month - 1).toString() + ' ماه پیش';
      } else if (diff.day > 1) {
        return (diff.day - 1).toString() + ' روز پیش';
      } else if (diff.hour > 1) {
        return diff.hour.toString() + ' ساعت پیش';
      } else if (diff.minute > 1) {
        return diff.minute.toString() + ' دقیقه پیش';
      } else
        return 'هم اکنون';
    }
  }
}

List<String> daysOfWeek = [
  'شنبه',
  'یکشنبه',
  'دوشنبه',
  'سه شنبه',
  'چهارشنبه',
  'پنجشنبه',
  'جمعه',
];

List<String> monthesOfYear = [
  'فروردین',
  'اردیبهشت',
  'خرداد',
  'تیر',
  'مرداد',
  'شهریور',
  'مهر',
  'آبان',
  'آذر',
  'دی',
  'بهمن',
  'اسفند',
];

Jalali difference(Jalali j1, Jalali j2) {
  int year, month, day, hour, minute;
  if (j2.isAfter(j1)) {
    Jalali temp = j2;
    j2 = j1;
    j1 = temp;
  }
  year = j1.year - j2.year;
  month = j1.month - j2.month;
  day = j1.day - j2.day;
  hour = j1.hour - j2.hour;
  minute = j1.minute - j2.minute;
  if (minute < 0) {
    hour--;
    minute += 60;
  }
  if (hour < 0) {
    day--;
    hour += 24;
  }
  if (day < 0) {
    month--;
    Jalali temp = Jalali(year + 1, month + 1);
    day += temp.monthLength;
  }
  if (month < 0) {
    year--;
    month += 12;
  }
  // print('res: y=$year\tm=$month\td=$day\th=$hour\tm=$minute');
  // print('j1: y=$j1\nj2: y=$j2');
  return Jalali(year + 1, month + 1, day + 1, hour, minute);
}

class DayAndHour {
  int day = 0, hour = 0;
  DayAndHour({this.day = 0, this.hour = 0});

  @override
  String toString() {
    // TODO: implement toString
    if (day != 0 && hour != 0)
      return '$day روز و $hour ساعت';
    else if (day != 0)
      return '$day روز';
    else if (hour != 0)
      return '$hour ساعت';
    else
      return '0';
  }
}

class LocationWithTitle {
  String title;
  LatLng latlng;

  LocationWithTitle({this.title = '', this.latlng});
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
