import 'dart:ui';

import 'package:amin/helper/uitils.dart';
import 'package:amin/model/videoCategory.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/screen/search_screen.dart';
import 'package:amin/screen/videoDetailsScreen.dart';
import 'package:amin/screen/video_play.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}



class _VideoScreenState extends State<VideoScreen> {
  final db = FirebaseFirestore.instance;

  // _buildExpandableContent(Vehicle vehicle) {
  //   List<Widget> columnContent = [];
  //
  //   for (String content in vehicle.contents)
  //     columnContent.add(
  //       new ListTile(
  //         title:
  //             new Text(content, style: Theme.of(context).textTheme.headline6),
  //         onTap: () {
  //           nextScreen(
  //               context,
  //               VideoPlayScreen(
  //                 subCategory: content,
  //                 categories: vehicle.title,
  //                 check: false,
  //               ));
  //         },
  //       ),
  //     );
  //
  //   return columnContent;
  // }
  final queryPost = FirebaseFirestore.instance
      .collection('videoCategory')
      .withConverter<VideoCategory>(
      fromFirestore: (snapshot, _) =>
          VideoCategory.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _IsSearching = false;
    getData();
  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  String videoId="";
  String thumbnailUrl ="";
  List<String> thumbnailUrlList =[];
  List<String> thumbnailUrlListDouble =[];
  void getData() async {
    cprint(
        'login message =786 categories name = ' /*+ widget.categories.toString()*/);
    var result = await FirebaseFirestore.instance
        .collection('video')
        /*.where('categories', isEqualTo: widget.categories)*/
    /*.where('subCategory', isEqualTo: widget.subCategory)*/
        .get()
        .then((value) => {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {
          setState(() {

          }),
          docss = value.docs,
          cprint(
              'video  login message =786 video length = ' +  value.docs.length.toString()),
          for (int i = 0; i < value.docs.length; i++)
            {
              authgetfriendship = VideoList.fromJson(docss[i].data()),
              videoList.add(authgetfriendship),
              videoListDouble.add(authgetfriendship),
              refId.add(docss[i].reference.id),
              thumbnailUrl = getYoutubeThumbnail(authgetfriendship.url!),
              thumbnailUrlList.add(thumbnailUrl),
              thumbnailUrlListDouble.add(thumbnailUrl),
              setState(() {
                videoList;
              }),
              if(i==value.docs.length-1){
                fillYTlists()
              },
              cprint(
                  'login message =786 url = ' + authgetfriendship.url!),
              cprint(
                  'login message =786 url zero = ' + videoList[0].url!),
            }

          /*showToast("User already exist...")*/
        }
      else
        {
          setState(() {

          }),
          cprint('login message = mobile = false'),

        }
    });
  }
  Map<String, dynamic> cStates = {};

  fillYTlists(){
    for (var element in videoList) {
      String _id = YoutubePlayer.convertUrlToId(element.url!)!;
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

      lYTC.add(_ytController);
    }
  }
  VideoList authgetfriendship = VideoList();
  List<VideoList> videoList = [];
  List<VideoList> videoListDouble = [];
  List<String> refId = [];
  late String videoTitle;


  List <YoutubePlayerController> lYTC = [];
  @override
  void dispose() {
    for (var element in lYTC) {
      element.dispose();
    }
    super.dispose();
  }
  ScrollController _controller = ScrollController();


  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return "null";
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final TextEditingController _searchQuery = new TextEditingController();
  Widget appBarTitle = Container(child: Image.asset(
    "assets/images/icons/iconappbar.png", //delivoo logo
    height: 50.0,
    width: 50,
  ),);
  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }
  late bool _IsSearching;
  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle = new Container(child: Image.asset(
        "assets/images/icons/iconappbar.png", //delivoo logo
        height: 50.0,
        width: 50,
      ),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
  onSearchTextChanged(String text) async {
    print("check text    =====      "+text);
    // _searchQuery.clear();
    List<VideoList> dummySearchList = [];
    List<String> thumbnailUrlListmDouble =[];
    dummySearchList.addAll(videoListDouble);
    thumbnailUrlListmDouble.addAll(thumbnailUrlListDouble);
    print("check dummySearchList size    =====      "+dummySearchList.length.toString());

    if (text.isEmpty != true) {
      print("Step    =====      1");
      List<VideoList> dummyListData = [];
      List<String> thumbnailUrlListmData =[];
      for(int i=0;i<dummySearchList.length;i++){
        if(dummySearchList[i].title!.toLowerCase().contains(text.toLowerCase())){
          dummyListData.add(dummySearchList[i]);
          thumbnailUrlListmData.add(thumbnailUrlListmDouble[i]);
          print("check text    size    =====      "+dummyListData.length.toString());
        }
      }
      setState(() {
        videoList.clear();
        thumbnailUrlList.clear();
        // adsData;
        thumbnailUrlList.addAll(thumbnailUrlListmData);
        videoList.addAll(dummyListData);
      });
      return;
    } else {
      print("Step    =====      2");
      setState(() {
        videoList.clear();
        thumbnailUrlList.clear();
        // adsData;
        thumbnailUrlList.addAll(thumbnailUrlListDouble);
        videoList.addAll(videoListDouble);
      });
    }
  }
  FocusNode inputNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:appBarTitle,
          actions: [
            IconButton(
              icon: actionIcon,
              tooltip: 'Search list',
              onPressed: () {
                if (this.actionIcon.icon == Icons.search) {

                  inputNode.requestFocus();
                  this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                  this.appBarTitle = new TextField(
                    onChanged: onSearchTextChanged,
                    focusNode: inputNode,
                    controller: _searchQuery,
                    textInputAction: TextInputAction.search,
                    style: new TextStyle(
                        color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)
                    ),
                  );
                  _handleSearchStart();
                }
                else {
                  _handleSearchEnd();
                }
                // handle the press
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            videoList.clear();
            thumbnailUrlList.clear();
            thumbnailUrlListDouble.clear();
            videoListDouble.clear();
            getData();
            await Future.delayed(Duration(seconds: 2));

            //Do whatever you want on refrsh.Usually update the date of the listview
          },
          child: ListView(
            controller: _controller,
            children: [

              /*Container(width: MediaQuery.of(context).size.width,
                height: 60,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Icon"),),*/
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Categories",
                    style: Theme.of(context).textTheme.headline5,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40, margin: const EdgeInsets.only(bottom: 20,left: 20),
                child: FirestoreListView<VideoCategory>(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    query: queryPost,
                    pageSize: 20,
                    itemBuilder: (context, snapshot) {
                      final user = snapshot.data();


                      return InkWell(
                        onTap: () {
                          nextScreen(
                              context,
                              VideoPlayScreen(
                                subCategory: "user.title!",
                                categories: user.title!,
                                cId: user.id,
                                check: false,
                              ));
                        },
                        child: Container(height: 30,margin: const EdgeInsets.symmetric(horizontal: 5),padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Color(0xff7b7b7b),width: 1)
                        ),
                        child: Center(child: Text(user.title!),),),
                      );
                    }),
              ),


              ListView.builder(
                controller: _controller,
                itemCount: /*videoList.length >6?5:*/videoList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  return InkWell(
                    onTap: (){
                      /*if( widget.check! == false){*/
                        /*for (var element in lYTC) {
                          element.dispose();
                        }*/
                        nextScreen(context, VideoDetailsScreen(authgetfriendship: videoList[index]));
                     /* }*/

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                      child: Stack(
                        children: [

                          Container(height: 100,
                            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0,right: 5.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff595961)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(thumbnailUrlList[index])
                                        )
                                    ),
                                    child: ClipRRect(


                                    ),)
                                )
                                ,

                                Container(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  height: 150,
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(child: Text(videoList[index].title!, textScaleFactor: 1.5,style: TextStyle(fontSize: 8,color: Colors.white,fontWeight: FontWeight.bold))),
                                      //   Flexible(child: Text(videoList[index].discription!, textScaleFactor: 1.5,style: TextStyle(fontSize: 2,color: Colors.grey,fontWeight: FontWeight.normal))),

                                      Container(child: Row(children: [
                                        Icon(Icons.access_time,color: Colors.white,size: 8,),
                                        Text(videoList[index].time!, textScaleFactor: 1.5,style: TextStyle(fontSize: 5,color: Colors.white)),
                                        /*Visibility(
                                          visible: widget.check!,
                                          child: IconButton(onPressed: (){



                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Delete Selected Video').tr(),
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

                                                            deleteDress(refId[index]);

                                                          })
                                                    ],
                                                  );
                                                });
                                          },icon: Icon(Icons.delete,color: Colors.blue,)),
                                        ),*/
                                      ],),),

                                    ],),)
                              ],),),

                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
