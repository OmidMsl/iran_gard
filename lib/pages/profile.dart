import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool darkTheme = false, notifications = false;
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    width: pageSize.width - 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xFF001FAB),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'نام کاربری:',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontFamily: 'Sans'),
                              ),
                              Text(
                                'امید مسلمانی',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Sans'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'موجودی:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontFamily: 'Sans'),
                              ),
                              Text(
                                '20,000 تومان',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontFamily: 'Sans'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 75.0),
                  child: Container(
                    width: pageSize.width - 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xFF001FAB),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.rtl,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'id:',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontFamily: 'Sans'),
                              ),
                              Text(
                                '@omidmsl',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'گالری تصاویر',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Sans'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: pageSize.width / 3,
                  height: pageSize.width / 3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF001FAB),
                        width: 3.0,
                      ),
                      image: DecorationImage(
                          image: AssetImage('images/users/user_1'),
                          fit: BoxFit.cover)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF001FAB),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            width: pageSize.width - 16,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'تغییر گذرواژه',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0,
                    fontFamily: 'Sans'),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF001FAB),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            width: pageSize.width - 16,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تم تاریک',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14.0,
                        fontFamily: 'Sans'),
                  ),
                  Switch(
                    value: darkTheme,
                    onChanged: (value) {
                      setState(() {
                        darkTheme = value;
                      });
                    },
                    activeColor: Color(0xFF001FAB),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF001FAB),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            width: pageSize.width - 16,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اعلان ها',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14.0,
                        fontFamily: 'Sans'),
                  ),
                  Switch(
                    value: notifications,
                    onChanged: (value) {
                      setState(() {
                        notifications = value;
                      });
                    },
                    activeColor: Color(0xFF001FAB),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF001FAB),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            width: pageSize.width - 16,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'تماس با ما',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0,
                    fontFamily: 'Sans'),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF001FAB),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            width: pageSize.width - 16,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'حذف حساب کاربری',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0,
                    fontFamily: 'Sans'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
