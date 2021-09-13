import 'package:flutter/material.dart';

class Story {
  String title;
  AssetImage logo;
  List<AssetImage> images;
  StoryType storyType;

  Story({this.title, this.logo, this.images, this.storyType});
}

enum StoryType {
  addStory,
  gallery,
  becomeALeader,
  story,
}
