import 'package:amin/model/video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoDetailsScreen extends StatefulWidget {
  VideoList authgetfriendship;
  VideoDetailsScreen({Key? key,required this.authgetfriendship}) : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillYTlists();
  }
  bool checkstatus = false;
  late YoutubePlayerController _ytController;
  fillYTlists(){
    String _id = YoutubePlayer.convertUrlToId(widget.authgetfriendship.url!)!;
    _ytController = YoutubePlayerController(
      initialVideoId: _id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        endAt: -10,
        disableDragSeek: true,
        hideThumbnail: false,
        controlsVisibleAtStart: false,
        hideControls: true,
      ),
    );
    Future.delayed(const Duration(seconds: 2), () { //asynchronous delay
      if (this.mounted) { //checks if widget is still active and not disposed
        setState(() {
          checkstatus = true;
        });
      }
    });


  }

  late PodPlayerController _ytController1 = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.authgetfriendship.url!),
    podPlayerConfig: PodPlayerConfig(
      autoPlay: false
    )
  )..initialise();

  Widget youtubeHierarchy(){
    return Container(
      child:
      PodVideoPlayer(
        controller: _ytController1,
        alwaysShowProgressBar: false,
        podProgressBarConfig: const PodProgressBarConfig(
            playingBarColor: Colors.deepPurpleAccent,
            circleHandlerColor: Colors.deepPurpleAccent,
            padding: EdgeInsets.only(left: 8,right: 8, bottom: 12),
            alwaysVisibleCircleHandler: true
        ),
      ),

    );
  }
  Future<bool> _onWillPop() async{

    if (MediaQuery.of(context).orientation == Orientation.portrait){
      // is portrait
      _ytController1.pause();
      return true;
    }else{
// is landscape
      _ytController1.pause();
      return true;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ytController1.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }
  bool isPlaying = false;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: OrientationBuilder(builder:
          (BuildContext context, Orientation orientation) {
     /*   if (orientation == Orientation.landscape) {
          _ytController.pause();
          return Scaffold(
            body: youtubeHierarchy(),
          );
        } else {
          _ytController.pause();*/
          return Scaffold(
            appBar:orientation == Orientation.portrait?  AppBar(title: Text("Video Details"),):null,
            body: ListView(children: [


              Container(width: MediaQuery.of(context).size.width,
                height: orientation == Orientation.portrait?  200:MediaQuery.of(context).size.height,
                child: youtubeHierarchy()),


              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text(widget.authgetfriendship.title!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
              ),

              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Row(
                    children: [
                      Text("Duration : ",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 10),),
                      Text(widget.authgetfriendship.time!,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 10),),
                    ],
                  ),),
              ),

              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text("Description",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 13),),),
              ),


              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text(widget.authgetfriendship.discription!,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),),),
              ),
            ],),
          );
       /* }*/
      }),
    );
  }
}
