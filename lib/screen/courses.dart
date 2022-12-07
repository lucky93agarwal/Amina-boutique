import 'dart:ffi';

import 'package:amin/admin/admin_create_course.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/screen/courses_details.dart';
import 'package:amin/screen/search_screen.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CourseScreen extends StatefulWidget {
  bool? check;
  bool? adminCheck;
  CourseScreen({Key? key,required this.adminCheck,required this.check}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    getData();
  }
  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: kMainColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  CourseList authgetfriendship = CourseList();
  List<CourseList> videoList = [];
  List<bool> checkBuy = [];
  List<String> checkCourseId = [];
  List<String> refId = [];
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  bool _progress = false;


  String? UserId = "";
  void getData() async {
    var result = await FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((value) => {
              cprint(
                  'login message =786 value.size = ' + value.size.toString()),
              if (value.size >= 1)
                {
                  setState(() {
                    _progress = false;
                  }),
                  docss = value.docs,
                  for (int i = 0; i < value.docs.length; i++)
                    {
                      authgetfriendship = CourseList.fromJson(docss[i].data()),
                      videoList.add(authgetfriendship),
                      refId.add(docss[i].reference.id),
                      checkBuy.add(false),
                      checkCourseId.add(authgetfriendship.cId!),
                      setState(() {
                        videoList;
                      }),
                      if (i == value.docs.length - 1)
                        {

                          setState(() {
                            _progress = true;
                          }),

                        },
                      cprint(
                          'login message =786 url = ' + authgetfriendship.cThum!),
                      cprint(
                          'login message =786 url zero = ' + videoList[0].cName!),
                    }

                  /*showToast("User already exist...")*/
                }
              else
                {
                  setState(() {
                    _progress = false;
                  }),
                  cprint('login message = mobile = false'),
                  showToast("wrong credentials")
                }
            });
  }
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 350) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:       Container(child: Image.asset(
          "assets/images/icons/iconappbar.png", //delivoo logo
          height: 50.0,
          width: 50,
        ),),
        actions: [
         widget.adminCheck == true? IconButton(onPressed: (){
           nextScreen(context, AdminCreateCourseScreen(admin: false,courseList:null,refId:null));
          }, icon: Icon(Icons.add,color: Colors.white,)):Container()
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          videoList.clear();
          getData();
          await Future.delayed(Duration(seconds: 2));

          //Do whatever you want on refrsh.Usually update the date of the listview
        },
        child: ListView(
          controller: _scrollController,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "All Courses",
                  style: Theme.of(context).textTheme.headline5,
                )),


            _progress ==true ? Container(
              margin: const EdgeInsets.only(left: 15.0,right: 15.0),
              child: ListView.builder(shrinkWrap: true,
                  itemCount: videoList.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context,int index){
                return InkWell(
                    onTap: () {
                      if(widget.adminCheck! ==true){
                        nextScreenReplace(context, AdminCreateCourseScreen(admin: widget.adminCheck!,courseList:videoList[index],refId:refId[index]));

                      }else{
                        if(widget.check == true){
                          Navigator.pop(context,videoList[index].cId);
                        }else {
                          nextScreen(context, CourseDetailsScreen(courseList: videoList[index],adminCheck: widget.adminCheck));
                        }

                      }
                      //
                    },
                    child: Container(
                        padding: const EdgeInsets.all(7.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff525252),  //                   <--- border color
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.05),
                                  offset: Offset(0, 5),
                                  blurRadius: 5)
                            ]),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: <Widget>[
                            AspectRatio(aspectRatio: 16 / 9,
                            child: Container(height: 125,decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white
                                          .withOpacity(0.05),
                                      offset: Offset(0, 5),
                                      blurRadius: 5)
                                ],
                                image: DecorationImage(image: NetworkImage(
                                  videoList[index].cThum!,
                                ),fit: BoxFit.cover)
                            ),)),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                  Text(
                                    videoList[index].cName!.length > 30?videoList[index].cName!.substring(0,30):videoList[index].cName!,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,fontWeight: FontWeight.w900),
                                  ),


                                ],),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Text("₹"+
                                          videoList[index].cPrice!.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.deepPurpleAccent,fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("₹"+videoList[index].cMRP!.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,

                                        maxLines: 2,
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration
                                                .lineThrough,
                                            fontSize: 13,
                                            color: Colors.grey,fontWeight: FontWeight.normal),
                                      ),

                                    ],),
                                    Visibility(
                                      visible: true,
                                      child: RatingBarIndicator(
                                        rating: videoList[index].cRating! == ""?0.0: double.parse(videoList[index].cRating!),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 13.0,
                                        unratedColor: Colors.amber.withAlpha(50),
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                ],),

                              ],
                            ),
                          ],
                        )));
              }),
            ): Container(),
          ],
        ),
      ),
    );
  }
}
