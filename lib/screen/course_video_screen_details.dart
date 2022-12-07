import 'package:amin/model/course_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class CourseVideoScreenDetailsScreen extends StatefulWidget {
  CourseVideo mcouse;
  CourseVideoScreenDetailsScreen({Key? key,required this.mcouse}) : super(key: key);

  @override
  State<CourseVideoScreenDetailsScreen> createState() => _CourseVideoScreenDetailsScreenState();
}

class _CourseVideoScreenDetailsScreenState extends State<CourseVideoScreenDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillYTlists();
  }
  bool checkstatus = false;
  late PodPlayerController _ytController;
  fillYTlists(){
    String _id = YoutubePlayer.convertUrlToId(widget.mcouse.cvUrl!)!;
    _ytController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.mcouse.cvUrl!),
    )..initialise();
    Future.delayed(const Duration(seconds: 2), () { //asynchronous delay
      if (this.mounted) { //checks if widget is still active and not disposed
        setState(() {
          checkstatustwo = true;
        });
      }
    });
    setState(() {
      checkstatus = true;
    });

  }
  bool checkstatustwo = false;
  bool isPlaying = false;
  bool isExpanded = false;
  Widget youtubeHierarchy(){

    return Container(
      child:
      PodVideoPlayer(
        controller: _ytController,
        alwaysShowProgressBar: false,
        podProgressBarConfig: const PodProgressBarConfig(
            playingBarColor: Colors.deepPurpleAccent,
            circleHandlerColor: Colors.deepPurpleAccent,
            padding: EdgeInsets.only(left: 8,right: 8, bottom: 12),
            alwaysVisibleCircleHandler: true
        ),
      ),

    );//PodPlayer for youtube

    // return  ClipRRect(
    //   // child: YoutubePlayer(
    //   //   controller: _ytController,
    //   //   showVideoProgressIndicator: true,
    //   //   progressIndicatorColor: Colors.lightBlueAccent,
    //   //   topActions: [],
    //   //   bottomActions: [
    //   //     CurrentPosition(),
    //   //     ProgressBar(isExpanded: true),
    //   //     FullScreenButton(),
    //   //   ],
    //   //   onReady: (){
    //   //   },
    //   //   onEnded: (YoutubeMetaData _md) {
    //   //     _ytController.seekTo(const Duration(seconds: 0));
    //   //   },
    //   // ),
    //   child:
    //   Container(
    //     child:
    //     PodVideoPlayer(
    //       controller: _ytController,
    //       alwaysShowProgressBar: false,
    //       podProgressBarConfig: const PodProgressBarConfig(
    //           playingBarColor: Colors.deepPurpleAccent,
    //           circleHandlerColor: Colors.deepPurpleAccent,
    //           padding: EdgeInsets.only(left: 8,right: 8, bottom: 12),
    //           alwaysVisibleCircleHandler: true
    //       ),
    //     ),
    //
    //   ), //PodPlayer for youtube
    // );
  }
  Future<bool> _onWillPop() async{

    if (MediaQuery.of(context).orientation == Orientation.portrait){
      // is portrait
      _ytController.pause();
      return true;
    }else{
// is landscape
      _ytController.pause();
      return true;
    }
  }


  @override
  dispose(){
    _ytController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: OrientationBuilder(builder:
          (BuildContext context, Orientation orientation) {
   /*     if (orientation == Orientation.landscape) {
          _ytController.pause();
          return Scaffold(
            body: youtubeHierarchy(),
          );
        } else {
          _ytController.pause();*/
          return Scaffold(
            appBar:orientation == Orientation.portrait? AppBar(title: Text("Video Details"),):null,
            body: ListView(children: [






              //
              // Container(width: MediaQuery.of(context).size.width,
              //   height: orientation == Orientation.portrait?200:MediaQuery.of(context).size.height,
              //   child: checkstatus  == true? youtubeHierarchy(): Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator()),),),

              // Visibility(
              //   visible: false,
              //   child: Row(
              //     children: [
              //       IconButton(
              //           icon: isPlaying
              //               ? const Icon(Icons.pause)
              //               : const Icon(Icons.play_arrow,),
              //           onPressed: () {
              //             if(isPlaying){
              //               _ytController.pause();
              //             } else {
              //               _ytController.play();
              //             }
              //             setState(() {
              //               // Here we changing the icon.
              //               isPlaying = !isPlaying;
              //             });
              //           }),
              //       ProgressBar(
              //           // controller: _ytController,
              //           isExpanded: true
              //       ),IconButton(
              //           icon: isExpanded
              //               ? const Icon(Icons.fullscreen_exit)
              //               : const Icon(Icons.fullscreen,),
              //           onPressed: () {
              //             // _ytController.toggleFullScreenMode();
              //             setState(() {
              //               isExpanded = !isExpanded;
              //             });
              //           }),
              //
              //
              //     ],
              //   ),
              // ),

              Container(
                child:
                PodVideoPlayer(
                  controller: _ytController,
                  alwaysShowProgressBar: false,
                  podProgressBarConfig: const PodProgressBarConfig(
                      playingBarColor: Colors.deepPurpleAccent,
                      circleHandlerColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.only(left: 8,right: 8, bottom: 12),
                      alwaysVisibleCircleHandler: true
                  ),
                ),

              ), //PodPlayer for youtube


              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text(widget.mcouse.cvTitle!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
              ),

              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Row(
                    children: [
                      Text("Duration : ",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 10),),
                      Text(widget.mcouse.cvTime!,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 10),),
                    ],
                  ),),
              ),

              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text("Description",style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontSize: 23),),),
              ),


              Visibility(
                visible: orientation == Orientation.portrait?  true:false,
                child: Container(width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Text(widget.mcouse.cvDetails!,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),),),
              ),
            ],),
          );
       /* }*/
      }),
    );
  }
}
