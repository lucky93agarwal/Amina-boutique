import 'dart:io';

import 'package:amin/admin/admin_category.dart';
import 'package:amin/admin/admin_couponList.dart';
import 'package:amin/admin/admin_course_buy_list.dart';
import 'package:amin/admin/admin_faq_user_list.dart';
import 'package:amin/admin/admin_product_banner.dart';
import 'package:amin/admin/admin_rating_list.dart';
import 'package:amin/admin/admin_user_list.dart';
import 'package:amin/admin/admin_video_list.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/admin/admin_home_banner_screen.dart';
import 'package:amin/model/ChatQuestionList.dart';
import 'package:amin/screen/courses.dart';
import 'package:amin/screen/login.dart';
import 'package:amin/screen/order_screen.dart';
import 'package:amin/screen/splash.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/locator.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  String? UserName = "";
  String? UserImg = "";

  String? UserMobile = "";
  CollectionReference userss = FirebaseFirestore.instance.collection('users');
  int? userCount = 0;

  CollectionReference videos = FirebaseFirestore.instance.collection('video');
  int? videoCount = 0;
  CollectionReference courses = FirebaseFirestore.instance.collection('courses');
  int? courseCount = 0;

  CollectionReference dresss = FirebaseFirestore.instance.collection('dress');
  //Coupon
  int? dressCount = 0;

  CollectionReference coupons = FirebaseFirestore.instance.collection('Coupon');
  //Coupon
  int? CouponCount = 0;


  CollectionReference dressbuy = FirebaseFirestore.instance.collection('BuyDress');
  //Coupon
  int? DressBuyCount = 0;

  CollectionReference faqbuy = FirebaseFirestore.instance.collection('faq');
  //Coupon
  int? faqCount = 0;

  int? courseBuyCount =0;


  CollectionReference ratings = FirebaseFirestore.instance.collection('Ratings');
  CollectionReference faqUser = FirebaseFirestore.instance.collection('faqUser');


  CollectionReference coursebuy = FirebaseFirestore.instance.collection('course_buy');
  //CouponF
  int? RatingCount = 0;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docssfaq;
  List<ChatQuestionList> items = [];
  List<String> userList = [];
  late ChatQuestionList chatQestion;
  String? userId = "";
  getUserData() async {
    final pref = getIt<SharedPreferenceHelper>();
    userId = await pref.getUserId();
    cprint('User userCount 7  =  ' + userCount.toString());
    userss.get().then((value) => {
          setState(() {
            userCount = value.size;
            /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
          }),
          cprint('User userCount =  ' + userCount.toString()),
        });


    coursebuy.get().then((value) => {
      setState(() {
        courseBuyCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
    });

    videos.get().then((value) => {
      setState(() {
        videoCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + userCount.toString()),
    });


    courses.get().then((value) => {
      setState(() {
        courseCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + courseCount.toString()),
    });

    dresss.get().then((value) => {
      setState(() {
        dressCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + courseCount.toString()),
    });

    coupons.get().then((value) => {
      setState(() {
        CouponCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + CouponCount.toString()),
    });


    dressbuy.get().then((value) => {
      setState(() {
        DressBuyCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + CouponCount.toString()),
    });


    ratings.get().then((value) => {
      setState(() {
        RatingCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + CouponCount.toString()),
    });

    faqUser.get().then((value) => {
      setState(() {
        faqCount = value.size;
        /*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*/
      }),
      cprint('User userCount =  ' + CouponCount.toString()),
    });


    /*var result = await FirebaseFirestore.instance
        .collection('faq')
        .where("user_id", isNotEqualTo: userId.toString())
        .get()
        .then((value) => {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {
          docssfaq = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              chatQestion = ChatQuestionList.fromJson(docssfaq[i].data()),
              if(userList.contains(chatQestion.userName!)==false){
                userList.add(chatQestion.userName!),
              },

              setState(() {
                faqCount = userList.length;
                *//*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*//*
              }),

            }
        }
    });*/
   /* faqbuy.get().then((value) => {
      setState(() {
        faqCount = value.size;
        *//*  Choice cChoice = Choice(title: "Users", icon: Icons.supervised_user_circle,count: userCount.toString());
       choices.add(cChoice);*//*
      }),
      cprint('User userCount =  ' + CouponCount.toString()),
    });*/

    UserName = await pref.getUserName();
    UserImg = await pref.getUserImage();
    UserMobile = await pref.getUserMobile();
    setState(() {
      UserMobile;
      userCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    void getUserID() async {
      final pref = getIt<SharedPreferenceHelper>();
      pref.clearPreferenceValues();
      nextScreenReplace(context, SplashScreen());
      /*   DeleteAPI();*/
    }

    var size = MediaQuery.of(context).size;
    var width = size.width;

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
          appBar: AppBar(
            title: Text("Admin"),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('logging out').tr(),
                          content: Text('are you sure').tr(),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('no').tr(),
                              textColor: kMainColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: kTransparentColor)),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                                child: Text('yes').tr(),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: kTransparentColor)),
                                textColor: kMainColor,
                                onPressed: () {
                                  getUserID();
                                  /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstPage()),
                          );*/
                                })
                          ],
                        );
                      });
                },
                icon: Icon(Icons.power_settings_new_sharp),
                color: Colors.blue,
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  currentAccountPictureSize: Size.square(90.0),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(UserImg!),
                  ),
                  accountName: Text(
                    UserName!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Lato"),
                  ),
                  accountEmail: Container(
                      child: Text(
                    "+91 " + UserMobile!,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Lato"),
                  )),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text("Users"),
                  onTap: () {
                    nextScreen(context, AdminUserListScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.ondemand_video_rounded),
                  title: Text("Videos"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, AdminVideoListScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.golf_course),
                  title: Text("Courses"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, CourseScreen(adminCheck: true,check: false,));
                  },
                ),

                ListTile(
                  leading: Icon(Icons.all_inclusive_rounded),
                  title: Text("Product"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, AdminCategoryScreen());
                  },
                ),

                ListTile(
                  leading: Icon(Icons.monetization_on_outlined),
                  title: Text("Coupon"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, AdminCouponListScreen(check: false));
                  },
                ),



                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Rating"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, AdminRatingListScreen());
                  },
                ),

                ListTile(
                  leading: Icon(Icons.all_inclusive_rounded),
                  title: Text("Product Order"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, OrderScreen(checkAdmin:true));
                  },
                ),

                ListTile(
                  leading: Icon(Icons.all_inclusive_rounded),
                  title: Text("Live Chat"),
                  onTap: () {
                    Navigator.pop(context);
                    nextScreen(context, AdminFAQUserListScreen());
                  },
                ),
              ],
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
                        nextScreen(context, AdminUserListScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.blue,
                                size: 80,
                              )
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                /*  Icon(
                                    Icons.supervised_user_circle,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Users",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:  userCount.toString().length ==3?30: userCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        nextScreen(context, AdminVideoListScreen());
                      },
                      child: Container(
                        height: 150,
                        width: width*0.4,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.slow_motion_video_outlined,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                 /* Icon(
                                    Icons.slow_motion_video_outlined,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Video",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    videoCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: videoCount.toString().length ==3?30: videoCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),


              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){

                        nextScreen(context, CourseScreen(adminCheck: true,check: false,));
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.golf_course,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Icon(
                                    Icons.golf_course,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Course",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    courseCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: courseCount.toString().length ==3?30: courseCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminCourseBuyList());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.dry_cleaning,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Icon(
                                    Icons.dry_cleaning,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Course Buy",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    courseBuyCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: courseBuyCount.toString().length ==3?30: courseBuyCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminCouponListScreen(check:false));
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Icon(
                                    Icons.monetization_on,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Coupon",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    CouponCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize:  CouponCount.toString().length ==3?30: CouponCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminCategoryScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.dry_cleaning,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Icon(
                                    Icons.dry_cleaning,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Product",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dressCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: dressCount.toString().length ==3?30: dressCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminRatingListScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.star,
                                color: Colors.blue,
                                size: 80,
                              )
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Rating",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    RatingCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: RatingCount.toString().length ==3?30: RatingCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:(){

                        nextScreen(context, OrderScreen(checkAdmin: true));
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*  Icon(
                                    Icons.monetization_on,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Product \n Order",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DressBuyCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: DressBuyCount.toString().length ==3?30: DressBuyCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),




              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminHomeBannerScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color:  Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Home \nScreen Banner",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminFAQUserListScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.chat,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Icon(
                                    Icons.monetization_on,
                                    color: Colors.blue,
                                    size: 80,
                                  ),*/
                                  Text(
                                    "Live \n Chat",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    faqCount.toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: faqCount.toString().length ==3?30: faqCount.toString().length ==4?20:40,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminProductBannerScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Product \nScreen Banner",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:(){

                        nextScreen(context, AdminProductBannerScreen());
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: width*0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Color(0xFF303030),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                          border: Border.all(color: Color(0xff595961)),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Create \nCourse Order",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }
}


