import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  // chats
  List<ChatItem> chats = [
    ChatItem(
        name: 'علی',
        lastMessage: 'سلام',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 5,
        isOnline: true),
    ChatItem(
        name: 'رضا',
        lastMessage: 'نه',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 5,
        isOnline: true),
    ChatItem(
        name: 'مهدی',
        lastMessage: 'آره',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 0,
        isOnline: false),
    ChatItem(
        name: 'محمد',
        lastMessage: 'چطور؟',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 0,
        isOnline: false),
    ChatItem(
        name: 'سعید نعمتی بیاناتی',
        lastMessage: 'سلام',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 5,
        isOnline: false),
    ChatItem(
        name: 'iran tours',
        lastMessage: 'تور کویر گردی',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 0,
        isOnline: true),
    ChatItem(
        name: 'dezful tourism',
        lastMessage: 'تور جدید داریم رفقا',
        lastMessageTime: TimeOfDay(hour: 14, minute: 0),
        numOfNewMessages: 0,
        isOnline: true),
  ];
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: List.generate(7, (index) {
            ChatItem ci = chats[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                  child: ci.getAsWidget(
                      pageSize.height / 11, pageSize.width, context),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ChatItem {
  String name, lastMessage;
  TimeOfDay lastMessageTime;
  int numOfNewMessages;
  bool isOnline;
  String imageName;

  ChatItem(
      {this.name,
      this.lastMessage,
      this.isOnline,
      this.lastMessageTime,
      this.numOfNewMessages,
      this.imageName});

  Widget getAsWidget(double height, double width, BuildContext context) {
    if (height < 50) height = 50;
    return Container(
      width: width - 32,
      height: height,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Stack(
              children: [
                Image.asset(
                  'images/defImage.png',
                  height: height,
                ),
                if (isOnline)
                  Positioned(
                    bottom: height / 9,
                    child: Image.asset(
                      'images/is_online.png',
                      height: height / 5,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: width - 40 - height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[800],
                          fontFamily: 'Sans'),
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                    Visibility(
                      visible: numOfNewMessages != 0,
                      replacement: SizedBox(
                        height: 20.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Color(0xFF001FAB),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(' ' + numOfNewMessages.toString() + ' ',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lastMessage,
                      style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey[700],
                          fontFamily: 'Sans'),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                        lastMessageTime.hour.toString() +
                            ':' +
                            (lastMessageTime.minute < 10
                                ? lastMessageTime.minute.toString() + '0'
                                : lastMessageTime.minute.toString()),
                        style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey[700],
                            fontFamily: 'Homa')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
