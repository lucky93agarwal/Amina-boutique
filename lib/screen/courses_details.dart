import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/Coupon.dart';
import 'package:amin/model/CourseBuy.dart';
import 'package:amin/model/RatingModel.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/screen/add_review_list_screen.dart';
import 'package:amin/screen/add_review_screen.dart';
import 'package:amin/screen/course_video_list.dart';
import 'package:amin/screen/razorpay.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class CourseDetailsScreen extends StatefulWidget {
  CourseList courseList;
  bool? adminCheck;
  CourseDetailsScreen({Key? key,required this.courseList,required this.adminCheck}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  CourseList _courseList = CourseList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _courseList = widget.courseList;
    checkBuyApi();
    fillYTlists();
  }
  String ButtonText = "Buy Now";

  String? UserIds = "";
  String? refId = "";
  Map<String, dynamic> cStates = {};
  List <YoutubePlayerController> lYTC = [];
  // late YoutubePlayerController _ytController;
  late PodPlayerController _ytController1;
  late RatingModel model;
  bool? _progressRating = false;
  List<RatingModel> productList = [];
  fillYTlists()async{
    var result = await FirebaseFirestore.instance
        .collection('Ratings')
        .where('productId', isEqualTo: _courseList.cId)
        .where('type', isEqualTo: "Course")
        .get()
        .then((value) => {

      print("check data type length  Rating API  =  "+value.size.toString()),
      if (value.size >= 1)
        {
          setState(() {
            _progressRating = true;
          }),
          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              model = RatingModel.fromJson(docss[i].data()),
              productList.add(model),
              print("ratingValue Id value  =   "+productList.toString()),
              setState(() {
                productList;
                _progressRating = true;
              })


            }
        }else {
        setState(() {
          _progressRating = false;
        }),
      }
    });
   /* _playerState = PlayerState.unknown;*/

    netPrice = int.parse(_courseList.cPrice!);
    setState(() {
      netPrice;
    });
      if(_courseList.video!.length >0){
        // // String _id = YoutubePlayer.convertUrlToId(_courseList.video![0].cvUrl!+"?modestbranding=1")!;
        //
        _ytController1 = PodPlayerController(playVideoFrom:
        PlayVideoFrom.youtube(_courseList.video![0].cvUrl!),
        podPlayerConfig: PodPlayerConfig(
          autoPlay: false
        ))..initialise();
        // _ytController = YoutubePlayerController(
        //   initialVideoId: _id,
        //   flags: const YoutubePlayerFlags(
        //     autoPlay: false,
        //     mute: false,
        //     endAt: -10,
        //     disableDragSeek: true,
        //     hideThumbnail: false,
        //     controlsVisibleAtStart: false,
        //     hideControls: true,
        //   ),
        // );
        //


        setState(() {
          _checkdeforVideo = true;
        });
        // Future.delayed(const Duration(seconds: 2), () { //asynchronous delay
        //   if (this.mounted) { //checks if widget is still active and not disposed
        //     setState(() {
        //       checkstatus = true;
        //     });
        //   }
        // });
      }else {
        setState(() {
          _checkdeforVideo = false;
        });
      }
  }
  late bool checkstatus = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  // void listener() {
  //   if (!_ytController.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _ytController.value.playerState;
  //       _videoMetaData = _ytController.metadata;
  //
  //       print("cxheck payer data = "+_playerState.index.toString());
  //
  //     });
  //   }
  // }
  final TextEditingController _courseController = TextEditingController();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  late CourseBuy dressModelNew;
  bool checkReview = true;
  void checkBuyApi() async{
    final pref = getIt<SharedPreferenceHelper>();
    UserIds = await pref.getUserId();
    var result = await FirebaseFirestore.instance
        .collection('course_buy')
        .where('uId', isEqualTo: UserIds)
        .where('cId', isEqualTo: _courseList.cId)
        .get()
        .then((value) => {

    _checkdesigonornot = true,
      if (value.size >= 1)
       {
         docss = value.docs,
         dressModelNew = CourseBuy.fromJson(docss[0].data()),
         refId = docss[0].reference.id,
         setState(() {

           _progress = false;

           if(dressModelNew.review == "false"){
             refId;
             checkReview = false;
           }else {
             refId;
             checkReview = true;
           }
         }),

          /*showToast("User already exist...")*/
        }
      else
        {
          setState(() {

            _progress = true;
          }),
        }
    });
  }
  bool _progress = false;
  bool _checkdesigonornot = false;
  bool _checkdeforVideo = false;
  final queryPostCoupon = FirebaseFirestore.instance.collection('Coupon').where('type', isEqualTo: "course").withConverter<Coupon>(fromFirestore:(snapshot,_)=> Coupon.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  Widget youtubeHierarchy(){
    // return ClipRRect(
    //   child: PodVideoPlayer(
    //     controller: _ytController1,
    //     // showVideoProgressIndicator: true,
    //     // progressIndicatorColor: Colors.lightBlueAccent,
    //     // topActions: [],
    //     // bottomActions: [
    //     //   CurrentPosition(),
    //     //   ProgressBar(isExpanded: true),
    //     //   FullScreenButton(controller:_ytController),
    //     // ],
    //     // onReady: (){
    //     // },
    //     // onEnded: (YoutubeMetaData _md) {
    //     //   _ytController.seekTo(const Duration(seconds: 0));
    //     // },
    //   ),
    // );
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

  @override
  dispose(){
    _ytController1.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  ScrollController _scrollController = ScrollController();
  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  int netPrice = 0;
  late String? couponId = "0";
  late String? couponStatus = "0";

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docssCoupon;
  checkCouponText()async{
    var result = await FirebaseFirestore.instance
        .collection('Coupon')
        .where('titalName', isEqualTo:  _courseController.text)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {

          docssCoupon = value.docs,
          cprint('login message = reference id = ' +
              docssCoupon[0].reference.id),
    checkCoupon(docssCoupon[0].data()["limitUser"], docssCoupon[0].data()["id"], docssCoupon[0].data()["percentage"], docssCoupon[0].data()["endDate"]),
          /*showToast("User already exist...")*/
        }
      else
        {
          cprint('login message = mobile = false'),
          showToast("wrong coupon")
        }
    });
  }
  checkCoupon(String minUser, String CouponId,String persen,String endDate)async {

    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    /*var formattcertime = new DateFormat("hh:mm a");*/

    DateTime endTempDate = new DateFormat("yyyy-MM-dd").parse(endDate);
    String formattedDate = formatter.format(now);
    DateTime currentTempDate = new DateFormat("yyyy-MM-dd").parse(formattedDate);
    /*String formattedTime = formattcertime.format(now);*/
    final pref = getIt<SharedPreferenceHelper>();
    UserIds = await pref.getUserId();
    double? unitPriceCal = 0.0;
    double? unitPerCal = 0.0;
    double? unitNetPrice = 0.0;
    double? unitQuant = 1.0;
    double? unitShipping = 1.0;
    cprint('login message = user_id = '+UserIds!+", coupon_id =  "+CouponId);
    var result = await FirebaseFirestore.instance
        .collection('BuyDress')
        .where('Coupon_status', isEqualTo: "1")
        .where('uId', isEqualTo: UserIds)
        .where('coupon_id', isEqualTo: CouponId)
        .limit(1)
        .get()
        .then((value) => {
      cprint('login message = user_id = '+UserIds!+", coupon_id =  "+CouponId+", size = "+value.size.toString()),
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),
          docss = value.docs,

          if(value.size >= int.parse(minUser)){
            showToast("Sorry, you have exhausted your 'per user' limit to use this promo code")
          }else{
            if(currentTempDate.isBefore(endTempDate)){
              cprint("currentTempDate is before endTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),

              unitPriceCal = double.tryParse(_courseList.cPrice!.toString()),

              cprint('login message = mobile = unitNetPrice = '+"  , unitPriceCal  = "+unitPriceCal.toString()),
              unitPerCal = double.tryParse(persen)!/100.0,
              unitNetPrice = unitPriceCal! * unitPerCal!,

              unitNetPrice = unitPriceCal! - unitNetPrice!,

              unitNetPrice = unitNetPrice! ,
              netPrice = unitNetPrice!.toInt(),
              cprint('login message = mobile = unitNetPrice = '+unitNetPrice.toString()+"  , unitPerCal  ="+unitPerCal.toString()+"  , unitPriceCal  ="+unitPriceCal.toString()),
              cprint("Accept limit 2 netPrice = "+netPrice.toString()),
              showToast("Coupon code applied successfully"),
              setState(() {
                netPrice;
                couponStatus = "1";
                couponId = CouponId;
              }),
            }else
              {
                cprint("endTempDate is before currentTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),
              },
          }

          /*showToast("User already exist...")*/
        }
      else
        {
          if(currentTempDate.isBefore(endTempDate)){
            cprint("currentTempDate is before endTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),

            unitPriceCal = double.tryParse(_courseList.cPrice!.toString()),

            cprint('login message = mobile = unitNetPrice = '+"  , unitPriceCal  = "+unitPriceCal.toString()),
            unitPerCal = double.tryParse(persen)!/100.0,
            unitNetPrice = unitPriceCal! * unitPerCal!,

            unitNetPrice = unitPriceCal! - unitNetPrice!,

            unitNetPrice = unitNetPrice! ,
            netPrice = unitNetPrice!.toInt(),
            cprint('login message = mobile = unitNetPrice = '+unitNetPrice.toString()+"  , unitPerCal  ="+unitPerCal.toString()+"  , unitPriceCal  ="+unitPriceCal.toString()),
            cprint("Accept limit 1 netPrice = "+netPrice.toString()),
            showToast("Coupon applied successfully"),
            setState(() {
              netPrice;
              couponStatus = "1";
              couponId = CouponId;
            }),
          }else
            {
              cprint("endTempDate is before currentTempDate,  currentTempDate  = "+currentTempDate.toString()+", endTempDate "+endTempDate.toString()),
            },


        }
    });
  }
  bool isPlaying = false;
  bool isExpanded = false;

    @override
  Widget build(BuildContext context) {
    return  OrientationBuilder(builder:
    (BuildContext context, Orientation orientation) {/*OrientationBuilder(builder:
    (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        _ytController.pause();
        return Scaffold(
          body: youtubeHierarchy(),
        );
      } else {
        _ytController.pause();
        return*/
      return  Scaffold(
            appBar:orientation == Orientation.portrait? AppBar(
              title: Text(_courseList.cName!),
            ):null,
            body: Stack(children: [

              ListView(
                controller: _scrollController,
                children: [
                _checkdeforVideo == false ?
                Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  height: 220,
                  color: kMainColor,
                  child: InkWell(
                    onTap: () {
                    },
                    child: Stack(children: [
                      Container(width: MediaQuery
                          .of(context)
                          .size
                          .width,
                        decoration: BoxDecoration(image: DecorationImage(
                            image: NetworkImage(_courseList.cThum!),
                            fit: BoxFit.fill)),),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 220,
                        color: Colors.black.withOpacity(0.35),
                      ),
                      Center(child: Icon(
                        Icons.play_circle_fill, color: Colors.white, size: 50,))
                    ],),
                  ),) :
                Container(
                  child: youtubeHierarchy(),
                ),
                  // Visibility(
                  //   visible: checkstatus,
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
                  //           controller: _ytController,
                  //           isExpanded: true
                  //       ),IconButton(
                  //           icon: isExpanded
                  //               ? const Icon(Icons.fullscreen_exit)
                  //               : const Icon(Icons.fullscreen,),
                  //           onPressed: () {
                  //             _ytController.toggleFullScreenMode();
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
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10), child: SizedBox(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                      child: Text(_courseList.cName!, style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900),)),),
                Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text("Prices", style: TextStyle(color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900),),),
                Visibility(
                  visible: _checkdesigonornot,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text("₹",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 15,
                                color: _progress == true ? Colors.blue : Colors.green,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(_courseList.cPrice!.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 25,
                                color: _progress == true ? Colors.blue : Colors.green,
                                fontWeight: FontWeight.w900),
                          ),

                          SizedBox(width: 10,),
                          Text("M.R.P.: ",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,

                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey, fontWeight: FontWeight.normal),
                          ),
                          Text("₹" + _courseList.cMRP!.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,

                            maxLines: 2,
                            style: TextStyle(
                                decoration:
                                TextDecoration
                                    .lineThrough,
                                decorationColor: Colors.red,
                                decorationStyle: TextDecorationStyle.solid,
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),



                        ],),
                        Visibility(
                          visible: true,
                          child: RatingBarIndicator(
                            rating: _courseList.cRating! == "" ? 0.0 : double.parse(
                                _courseList.cRating!),
                            itemBuilder: (context, index) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            itemCount: 5,
                            itemSize: 18.0,
                            unratedColor: Colors.amber.withAlpha(50),
                            direction: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),),
                ),


                Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text("Details", style: TextStyle(color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w900),),),
                Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(_courseList.cDetails!,
                    style: TextStyle(color: Colors.grey, fontSize: 15),),),
                  Visibility(
                    visible: _progressRating!,
                    child: Container( margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("User reviews",style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 11,
                          ),),

                          // Visibility(
                          //   visible: /*productList.length >5 ?*/ true/* : false*/,
                          //   child: InkWell(
                          //     onTap: (){
                          //
                          //       nextScreen(context, AddReviewListScreen(productList: productList));
                          //     },
                          //     child: Text("All view",
                          //       style: TextStyle(color: Colors.blue,
                          //         fontWeight: FontWeight.normal,
                          //         fontSize: 13,
                          //       ),),
                          //   ),
                          // ),
                        ],),),
                  ),

                  Visibility(
                    visible: _progressRating!,
                    child: Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: productList.length >5 ?5:productList.length,
                          itemBuilder: (BuildContext context,int index){
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                  color: Color(0xff222328),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(
                                    blurRadius: 3.0,
                                    color: Color(0xFF616161),
                                    spreadRadius: 1,
                                    offset: Offset(
                                      1,
                                      1,
                                    ),
                                  ),]),child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(child: Row(children: [
                                      Container(width: 30,height: 30,decoration: BoxDecoration( shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(productList[index].userImg!,),fit: BoxFit.cover)),),
                                      SizedBox(width: 5,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text(productList[index].userName!.length> 25? productList[index].userName!.substring(0,25).toUpperCase()+"...":productList[index].userName!.toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                                        SizedBox(width: 5,),
                                        Text(productList[index].time!,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 8),),
                                      ],),

                                    ],),),
                                    RatingBarIndicator(
                                      rating: productList[index].rating! == ""?0.0: double.parse(productList[index].rating!),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      direction: Axis.horizontal,
                                    ),
                                  ],),
                                SizedBox(height: 10,),
                                Text('"'+productList[index].userMessage!+'"',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 14),),
                                SizedBox(height: 10,),
                                Visibility(
                                    visible: productList[index].reply!.length >5? true:false,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Align(alignment: Alignment.topRight,child:   Text("Admin Reply",style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 12),),),
                                        SizedBox(height: 10,),
                                        Align(alignment: Alignment.topRight,child:   Text('"'+productList[index].reply!+'"',textAlign: TextAlign.end,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),),)
                                      ],)),

                              ],
                            ),);
                          }),),
                  ),


                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    SizedBox(),
                    Visibility(
                      visible: productList.length >5 ? true : false,
                      child: InkWell(
                        onTap: (){

                          nextScreen(context, AddReviewListScreen(productList: productList));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Text("All view",
                            style: TextStyle(color: Colors.blue,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),),
                        ),
                      ),
                    ),
                  ],),


                  Visibility(
                    visible: _progress == true,
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Coupons",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _progress == true,
                    child: Container(

                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child:  EntryField(
                                controller: _courseController,
                                label: 'Enter Course',
                                image: 'assets/images/icons/pass.png',
                                keyboardType: TextInputType.text,
                                readOnly: false,
                                hint: 'Enter Course'),
                          ),


                          InkWell(
                            onTap: (){
                              if(_courseController.text.length >0){
                                checkCouponText();
                              }

                            },
                            child: Container(margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(5.0),
                            color: Colors.green,
                            child: Text("Check",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                          )
                      ],),
                      /*child: FirestoreListView<Coupon>(
                          query: queryPostCoupon,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemBuilder: (context,snapshot){
                            final user = snapshot.data();
                            return ListTile(
                              onTap: (){
                                checkCoupon(user.limitUser!, user.id!,user.percentage!,user.endDate!);
                                // nextScreen(context, AdminCreateCouponScreen(check: false,coupon: user,refId: snapshot.reference.id,));
                              },
                              trailing: Text(user.percentage!+"%",style: Theme.of(context).textTheme.headline2,),

                              leading: CircleAvatar(backgroundImage: NetworkImage("https://img.freepik.com/free-vector/gift-coupon-with-ribbon-offer_24877-55663.jpg?size=626&ext=jpg&ga=GA1.1.1578454833.1643587200"),),
                              title: Text(user.titleName!.toUpperCase(),style: Theme.of(context).textTheme.headline2,),
                            );
                          }
                      ),*/
                    ),
                  ),

                SizedBox(height: 150,),
              ],),
              Visibility(
                visible: orientation == Orientation.portrait?true:false,
                child: Align(alignment: Alignment.bottomCenter,
                  child: widget.adminCheck == false ? _progress == true ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(width: MediaQuery
                        .of(context)
                        .size
                        .width,
                      height: 60,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 150, bottom: 50),


                      decoration: BoxDecoration(
                          color: Color(0xff7b61ff),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Row(children: [
                        Expanded(flex: 6, child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("₹ " + netPrice.toString() + ".00",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),),
                              Text("Total price ", style: TextStyle(
                                  color: Color(0xffc2b6ff), fontSize: 12),),
                            ],),
                        )),
                        Expanded(flex: 4, child: InkWell(
                          onTap: () {
                            nextScreenReplace(
                                context, RazorpayScreen(courseList: _courseList,
                                price: netPrice,
                                couponStatus:couponStatus,
                                couponId:couponId));
                          },
                          child: Container(


                            decoration: BoxDecoration(
                                color: Color(0xff6953d9),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0))
                            ),
                            child: Center(child: Text("Buy Now", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),),
                          ),
                        ))
                      ],),),) :
                  Visibility(
                    visible: _checkdesigonornot,
                    child: Align(alignment: Alignment.bottomCenter,
                      child: Container(width: MediaQuery
                          .of(context)
                          .size
                          .width,
                        height: 60,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 150, bottom: 50),


                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Row(children: [

                          Expanded(flex: 4, child: InkWell(
                            onTap: () {
                              if (_progress == false) {
                                _ytController1.pause();
                                nextScreen(context, CourseVideoListSreen(
                                  courseVideo: _courseList.video!,
                                  categories: _courseList.cName,
                                    adminCheck: widget.adminCheck,
                                    checkReview: checkReview,
                                    refId: refId,
                                    dressModelNew: dressModelNew,
                                    courseList: _courseList));
                              }
                            },
                            child: Container(


                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0), topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0))

                              ),
                              child: Center(child: Text("Start With Course",
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 18),),),
                            ),
                          ))
                        ],),),),
                  ) :
                  Container(),),
              ),
            ],),
          );
      }

    );
  }
}
