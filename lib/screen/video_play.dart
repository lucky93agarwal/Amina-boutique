import 'package:amin/admin/admin_create_video.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/screen/videoDetailsScreen.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Components/entry_fields.dart';
import '../utils/color.dart';

class VideoPlayScreen extends StatefulWidget {
  String? categories;
  String? subCategory;
  bool? check;

  VideoPlayScreen(
      {Key? key, required this.subCategory, required this.categories, required this.check})
      : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }



  @override
  void dispose() {
    for (var element in lYTC) {
      element.dispose();
    }
    super.dispose();
  }

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  void getData() async {
    cprint(
        'login message =786 categories name = ' + widget.categories.toString());
    var result = await FirebaseFirestore.instance
        .collection('video')
        .where('categories', isEqualTo: widget.categories)
        /*.where('subCategory', isEqualTo: widget.subCategory)*/
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
                      authgetfriendship = VideoList.fromJson(docss[i].data()),
                      videoList.add(authgetfriendship),

                      duplicateVideoList.add(authgetfriendship),
                      duplicaterRefId.add(docss[i].reference.id),

                      refId.add(docss[i].reference.id),
                      thumbnailUrl = getYoutubeThumbnail(authgetfriendship.url!),
                      thumbnailUrlList.add(thumbnailUrl),

                      duplicateThumbnailUrlList.add(thumbnailUrl),

                      setState(() {
                        videoList;
                      }),
                      // if(i==value.docs.length-1){
                      //   fillYTlists()
                      // },
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
                    _progress = false;
                  }),
                  cprint('login message = mobile = false'),
                  if(widget.check==true){
                    showToast("Please add video"),
                  }

                }
            });
  }
  String thumbnailUrl ="";
  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return "null";
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
  bool _progress = false;
  List<String> thumbnailUrlList =[];
  List<String> duplicateThumbnailUrlList =[];
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

  VideoList authgetfriendship = VideoList();
  List<VideoList> videoList = [];
  List<VideoList> duplicateVideoList = [];
  List<String> refId = [];
  List<String> duplicaterRefId = [];







  late String videoTitle;


  List <YoutubePlayerController> lYTC = [];

  Map<String, dynamic> cStates = {};
  onSearchTextChanged(String text) async {
    print("check text    =====      "+text);
    // _searchQuery.clear();
    List<VideoList> dummySearchList = [];
    List<String> duplicaterRefIdNew = [];
    List<String> duplicateThumbnailUrlListNew =[];

    duplicateThumbnailUrlListNew.addAll(duplicateThumbnailUrlList);
    duplicaterRefIdNew.addAll(duplicaterRefId);
    dummySearchList.addAll(duplicateVideoList);
    print("check dummySearchList size    =====      "+dummySearchList.length.toString());

    if (text.isEmpty != true) {
      print("Step    =====      1");
      List<VideoList> dummyListData = [];
      List<String> duplicaterRefIdNew2 = [];
      List<String> duplicateThumbnailUrlListNew2 =[];

      for(int i=0;i<dummySearchList.length;i++){
        if(dummySearchList[i].title!.toLowerCase().contains(text.toLowerCase())){
          dummyListData.add(dummySearchList[i]);
          duplicaterRefIdNew2.add(duplicaterRefIdNew[i]);
          duplicateThumbnailUrlListNew2.add(duplicateThumbnailUrlListNew[i]);
          print("check text    size    =====      "+dummyListData.length.toString());
        }
      }
      setState(() {
        videoList.clear();
        // adsData;
        thumbnailUrlList.addAll(duplicateThumbnailUrlListNew2);
        videoList.addAll(dummyListData);
        refId.addAll(duplicaterRefIdNew2);
      });
      return;
    } else {
      print("Step    =====      2");
      setState(() {
        videoList.clear();
        // adsData;
        thumbnailUrlList.addAll(duplicateThumbnailUrlList);
        refId.addAll(duplicaterRefId);
        videoList.addAll(duplicateVideoList);
      });
    }
  }


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
  deleteDress(String refId)async{
    FirebaseFirestore.instance.collection('video').doc(refId).delete();
    Navigator.pop(context);
  }
  final TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categories!),
        actions: [
          Visibility(
            visible: widget.check!,
            child: IconButton(onPressed: (){
              nextScreen(context, AdminCreateVideoScreen(subCategory: widget.subCategory,categories: widget.categories,));
            }, icon: Icon(Icons.add,color: Colors.white,)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        /*child: ListView.builder(
          itemCount: lYTC.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            YoutubePlayerController _ytController = lYTC[index];
            String _id = YoutubePlayer.convertUrlToId(videoList[index].url!)!;
            String curState = 'undefined';
            if (cStates[_id] != null) {
              curState = cStates[_id]? 'playing':'paused';
            }
            return InkWell(
              onTap: (){
              */
          /*  if( widget.check! == false){*/
          /*
                  for (var element in lYTC) {
                    element.dispose();
                  }
                  nextScreen(context, VideoDetailsScreen(authgetfriendship: videoList[index]));
               */
          /* }*/
          /*

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Stack(
                  children: [

                    Container(height: 150,
                    padding: const EdgeInsets.all(5.0),
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
                      Container(height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: ClipRRect(
                        child: YoutubePlayer(
                          controller: _ytController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.lightBlueAccent,
                          bottomActions: [
                           */
          /* CurrentPosition(),
                            ProgressBar(isExpanded: true),
                            FullScreenButton(),*/
          /*
                          ],
                          onReady: (){
                            print('onReady for $index');
                          },
                          onEnded: (YoutubeMetaData _md) {
                            _ytController.seekTo(const Duration(seconds: 0));
                          },
                        ),
                      ),),
                        Container(
                          width: MediaQuery.of(context).size.width*0.55,
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
                            Visibility(
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
                            ),
                          ],),),

                        ],),)
                    ],),),

                  ],
                ),
              ),
            );
          },
        )*/

       child:   ListView(
         controller: _scrollController,
         shrinkWrap: true,
         children: [


       TextField(
       onChanged: onSearchTextChanged,
         controller: _searchController,
         textInputAction: TextInputAction.search,
         style: new TextStyle(
             color: Colors.white,
             fontFamily: "Lato"
         ),
         decoration: new InputDecoration(
             prefixIcon: new Icon(Icons.search, color: Colors.white),
             hintText: "Search...",
             hintStyle: new TextStyle(color: Colors.white,fontFamily: "Lato")
         ),
       ),



           SizedBox(height: 5,),
           ListView.builder(
             controller: _scrollController,
                itemCount: /*videoList.length >6?5:*/videoList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  return InkWell(
                    onTap: (){
                      /*if( widget.check! == false){*/
                      // for (var element in lYTC) {
                      //   element.dispose();
                      // }
                      nextScreen(context, VideoDetailsScreen(authgetfriendship: videoList[index]));
                      /* }*/

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                      child: Stack(
                        children: [

                          Container(height: 100,
                            padding: const EdgeInsets.all(5.0),
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
                                Container(height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      image: DecorationImage(
                                          image: NetworkImage(thumbnailUrlList[index])
                                      )
                                  ),
                                  child: ClipRRect(

                                    /*child: YoutubePlayer(
                                        controller: _ytController,
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor: Colors.lightBlueAccent,
                                        bottomActions: [
                                          */
                                    /* CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                  FullScreenButton(),*/
                                    /*
                                        ],
                                        onReady: (){
                                          print('onReady for $index');
                                        },
                                        onEnded: (YoutubeMetaData _md) {
                                          _ytController.seekTo(const Duration(seconds: 0));
                                        },
                                      ),*/
                                  ),),

                                Container(
                                  width: MediaQuery.of(context).size.width*0.55,
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
                                        Spacer(),
                                        Visibility(
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
                                                          new GestureDetector(
                                                            onTap: () => Navigator.pop(context),
                                                            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                                          ),
                                                          SizedBox(height: 16),
                                                          new GestureDetector(
                                                            onTap: () => deleteDress(refId[index]),
                                                            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                                          ),

                                                        ],
                                                      );
                                                    });
                                              },icon: Icon(Icons.delete,color: Colors.blue,)),
                                            ),
                                      ],),),

                                    ],),)
                              ],),),

                          /*  Container(
                            height: 220.0,
                            decoration: const BoxDecoration(
                                color: Color(0xfff5f5f5),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    color: Colors.grey,
                                    blurRadius: 12.0,
                                  ),
                                  BoxShadow(
                                    offset: Offset(-2, -2),
                                    color: Colors.grey,
                                    blurRadius: 6.0,
                                  ),
                                ]
                            ),
                            child: ClipRRect(
                              child: YoutubePlayer(
                                controller: _ytController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.lightBlueAccent,
                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                  FullScreenButton(),
                                ],
                                onReady: (){
                                  print('onReady for $index');
                                },
                                onEnded: (YoutubeMetaData _md) {
                                  _ytController.seekTo(const Duration(seconds: 0));
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Text(videoList[index].title!, textScaleFactor: 1.5,style: TextStyle(fontSize: 10,color: Colors.white)),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 180),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                              Container(child: Row(children: [
                                Icon(Icons.access_time,color: Colors.white,size: 15,),
                                Text(videoList[index].time!, textScaleFactor: 1.5,style: TextStyle(fontSize: 10,color: Colors.white))
                              ],),),

                              Visibility(
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
                              ),
                            ],),
                          ),*/
                        ],
                      ),
                    ),
                  );
                },
              ),
         ],
       )
      ),
    );
  }
}
