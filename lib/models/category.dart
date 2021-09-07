import 'package:flutter/material.dart';

class Category {
  String name;
  IconData icon;
  Color color;

  Category({this.name, this.icon, this.color});

  @override
  bool operator ==(Object other) =>
      other is Category &&
      other.name == name &&
      other.icon == icon &&
      other.color == color;

  static List<String> getNames(List<Category> cts) {
    List<String> res = [];
    for (Category c in cts) {
      res.add(c.name);
    }
    return res;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
