import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/model/CourseBuy.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/screen/add_review_screen.dart';
import 'package:amin/screen/course_video_screen_details.dart';
import 'package:amin/screen/videoDetailsScreen.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoListSreen extends StatefulWidget {
  String? categories;
  bool? checkReview;
  bool? adminCheck;
  CourseList? courseList;
  String? refId;
  CourseBuy? dressModelNew;
  List<CourseVideo> courseVideo;
  CourseVideoListSreen({Key? key,required this.courseVideo,required this.categories,required this.adminCheck,required this.checkReview,required this.refId,required this.dressModelNew,required this.courseList}) : super(key: key);

  @override
  State<CourseVideoListSreen> createState() => _CourseVideoListSreenState();
}

class _CourseVideoListSreenState extends State<CourseVideoListSreen> {
  List<CourseVideo> courseVideoTwo = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseVideoTwo.addAll(widget.courseVideo);
    fillYTlists();
  }
  @override
  void dispose() {
    for (var element in lYTC) {
      element.dispose();
    }
    super.dispose();
  }

  bool _progress = false;

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

  List <YoutubePlayerController> lYTC = [];

  Map<String, dynamic> cStates = {};
  fillYTlists(){

    for (var element in courseVideoTwo) {
      print("video list  =  "+element.cvUrl!.toString());
      thumbnailUrl = getYoutubeThumbnail(element.cvUrl!);
    thumbnailUrlList.add(thumbnailUrl);
    /*  print("youtube url  =  "+element.cvUrl!);
      String _id = YoutubePlayer.convertUrlToId(element.cvUrl!)!;
      YoutubePlayerController _ytController = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          captionLanguage: 'en',
        ),
      );

      _ytController.addListener(() {
        print('for $_id got isPlaying state ${_ytController.value.isPlaying}');
        if (cStates[_id] != _ytController.value.isPlaying) {
          if (mounted) {
            setState(() {
              cStates[_id] = _ytController.value.isPlaying;
            });
          }
        }
      });

      lYTC.add(_ytController);*/
    }
  }
  ScrollController _controller = ScrollController();
  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return "null";
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
  String thumbnailUrl ="";
  List<String> thumbnailUrlList =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categories!),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
        child:   Stack(children: [
          ListView.builder(
            controller: _controller,
            itemCount: courseVideoTwo.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {

              return InkWell(
                onTap: (){
                  nextScreen(context, CourseVideoScreenDetailsScreen(mcouse: courseVideoTwo[index]));

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: Stack(
                    children: [

                      Container(height: 100,
                        padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,right: 5.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff595961)),
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
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(height: 100,
                                width: 100,
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(thumbnailUrlList[index])
                                    )
                                ),
                                child: ClipRRect(


                                ),),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: 150,
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(child: Text(courseVideoTwo[index].cvTitle!, textScaleFactor: 1.5,style: TextStyle(fontSize: 8,color: Colors.white,fontWeight: FontWeight.bold))),
                                  //   Flexible(child: Text(videoList[index].discription!, textScaleFactor: 1.5,style: TextStyle(fontSize: 2,color: Colors.grey,fontWeight: FontWeight.normal))),

                                  Container(child: Row(children: [
                                    Icon(Icons.access_time,color: Colors.white,size: 8,),
                                    Text(courseVideoTwo[index].cvTime!, textScaleFactor: 1.5,style: TextStyle(fontSize: 5,color: Colors.white)),

                                  ],),),

                                ],),)
                          ],),),

                    ],
                  ),
                ),
              );
            },
          ),
          Align(alignment: Alignment.bottomCenter,
          child: widget.adminCheck == false ? _progress == true
              ? Container()
              : widget.checkReview == false ? Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: BottomBar(
              check: false,
              text: "Add Review",
              onTap: () {
                nextScreenReplace(context, AddReviewScreen(
                  courseList: widget.courseList,
                  dressModel: null,
                  coursebut: widget.dressModelNew,
                  type: "Course",
                  refId: widget.refId,));
                /*   Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(courseList:_courseList,dressModel:null,coursebut:dressModelNew,type:"Course",refId: refId,))).then((value) => {

                  setState(() {
                    checkReview = true;
                  }),
                });*/

              },
            ),


          ) : Container() : Container(),),

        ],),

      ),
    );
  }
}
