import 'dart:io';

import 'package:amin/common/animated_bottom_bar.dart';
import 'package:amin/screen/account_page.dart';
import 'package:amin/screen/courses.dart';
import 'package:amin/screen/full_dress_screen.dart';
import 'package:amin/screen/home.dart';
import 'package:amin/screen/home_video.dart';
import 'package:amin/screen/order_screen.dart';
import 'package:amin/screen/video.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class HomeOrderAccount extends StatefulWidget {
  const HomeOrderAccount({Key? key}) : super(key: key);

  @override
  State<HomeOrderAccount> createState() => _HomeOrderAccountState();
}

class _HomeOrderAccountState extends State<HomeOrderAccount> {
  // CameraDescription scamera;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // scamera = widget.camera;
  }

  final List<BarItem> barItems = [
    BarItem(
      text: 'home',
      image: bottomIconHome,
    ),
    BarItem(
      text: 'shop',
      image: bottomIconOrder,
    ),
    BarItem(
      text: 'courses',
      image: bottomIconCource,
    ),
    BarItem(
      text: 'video',
      image: bottomIconVideo,
    ),
    BarItem(
      text: 'profile',
      image: bottomIconAccount,
    ),
  ];

  final List<Widget> _children = [
    HomeScreen(),
   // OrderScreen(checkAdmin: false,),
    FullDressScreen(check: false),
    CourseScreen(adminCheck: false,check: false,),
    VideoScreen(),
   /* HomeVideoScreen(),*/
    AccountPage(),
  ];

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static String bottomIconHome = 'assets/images/footermenu/ic_home.png';

  static String bottomIconOrder = 'assets/images/footermenu/ic_orders.png';

  static String bottomIconAccount = 'assets/images/footermenu/ic_profile.png';


  static String bottomIconCource = 'assets/images/footermenu/ic_cource.png';

  static String bottomIconVideo = 'assets/images/footermenu/ic_video.png';

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async{

      return await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('are you sure',style: Theme.of(context).textTheme.headline1,).tr(),
          content: new Text('do you want to exit the App',style: Theme.of(context).textTheme.bodyText2).tr(),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () {
                /*Navigator.of(context).pop(true);*/
                exit(0);
                //nextScreenCloseOthers(context,SplashScreen());
                //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => LoginScreen()),(route) => false);

              },
              child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
            ),
          ],
        ),
      );
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: AnimatedBottomBar(
            barItems: barItems,
            onBarTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
      ),
    );
  }
}
