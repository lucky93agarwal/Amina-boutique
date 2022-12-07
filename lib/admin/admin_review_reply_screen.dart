import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/model/RatingModel.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AdmiReviewReplyScreen extends StatefulWidget {
  RatingModel? ratingModel;
  String? refId;
  AdmiReviewReplyScreen({Key? key,required this.ratingModel,required this.refId}) : super(key: key);

  @override
  State<AdmiReviewReplyScreen> createState() => _AdmiReviewReplyScreenState();
}

class _AdmiReviewReplyScreenState extends State<AdmiReviewReplyScreen> {
  RatingModel? ratingModel;
  bool _progress = false;
  bool _progressProduct = false;
  bool _progressBtn = true;
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
  bool checkprogress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ratingModel = widget.ratingModel;
    getData();
  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  DressModel authgetfriendship = DressModel();
  CourseList authgetfriendshipCourse = CourseList();
  void getData()async{

    _titleController.text = (widget.ratingModel!.reply! == ""?"":widget.ratingModel!.reply!)!;

    if(widget.ratingModel!.reply!.length >0){
      setState(() {
        _progressBtn = false;
      });

    }
    if(widget.ratingModel!.type == "Dress"){
      var result = await FirebaseFirestore.instance
          .collection('dress')
          .where('id', isEqualTo: widget.ratingModel!.productId)
      /*.where('subCategory', isEqualTo: widget.subCategory)*/
          .get()
          .then((value) => {
        cprint(
            'login message =786 value.size = ' + value.size.toString()),
        if (value.size >= 1)
          {

            docss = value.docs,
            for (int i = 0; i < value.docs.length; i++)
              {
                authgetfriendship = DressModel.fromJson(docss[i].data()),

                setState(() {
                  authgetfriendship;
                _progressProduct = true;
                }),
              }
          }
        else
          {
            setState(() {
              _progressProduct = false;
            }),
            cprint('login message = mobile = false'),
           // showToast("No Data")
          }
      });
    }
    else{


      var result = await FirebaseFirestore.instance
          .collection('courses')
          .where('cId', isEqualTo: widget.ratingModel!.productId)
      /*.where('subCategory', isEqualTo: widget.subCategory)*/
          .get()
          .then((value) => {
        cprint(
            'Course list  login message =786 value.size = ' + value.size.toString()),
        if (value.size >= 1)
          {

            docss = value.docs,
            for (int i = 0; i < value.docs.length; i++)
              {
                authgetfriendshipCourse = CourseList.fromJson(docss[i].data()),

                setState(() {
                  authgetfriendshipCourse;
                  _progressProduct = true;
                }),
              }
          }
        else
          {
            setState(() {
              _progressProduct = false;
            }),
            cprint('login message = mobile = false'),
         //   showToast("No Data")
          }
      });
    }

  }
  final TextEditingController _titleController = TextEditingController();
  String ButtonText = "Replay";
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
  void updateVisible(String refId, RatingModel model){


    model.setReply = _titleController.text;

    FirebaseFirestore.instance.collection('Ratings').doc(refId).update(model.toJson());
    showToast("YOUR REPLY TO THE REVIEW FOR THE RESPECTIVE PRODUCT WILL BE REFLECT SHORTLY");
    Navigator.pop(context);
  }

  bool checktype = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        SizedBox(height: 10,),
        _progressProduct == true?ratingModel!.type! == "Dress"? Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: CachedNetworkImage(
                  imageUrl: authgetfriendship.imgWhite1!,
                  imageBuilder: (context, imageProvider) => Container(width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(image: DecorationImage(image: imageProvider)),),
                  placeholder: (context, url) => SizedBox(width: MediaQuery.of(context).size.width,
                    height: 200,
                  child: Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())),),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 10,),/*
              Container(width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(authgetfriendship.imgWhite1!))),),*/
              Text(authgetfriendship.title!,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              Text(authgetfriendship.details!,style: TextStyle(color: Colors.grey,fontSize: 13),),

              SizedBox(height: 20,),
              Text("Review Details",style: TextStyle(color: Colors.grey,fontSize: 13),),


              SizedBox(height: 20,),

            ],
          ),
        ):
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(authgetfriendshipCourse.cThum!))),),
              Text(authgetfriendshipCourse.cName!,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              Text(authgetfriendshipCourse.cDetails!,style: TextStyle(color: Colors.grey,fontSize: 13),),

              SizedBox(height: 20,),
              Text("Review Details",style: TextStyle(color: Colors.grey,fontSize: 13),),


              SizedBox(height: 20,),

            ],
          ),
        ):Container(),
        SizedBox(height: 10,),
        ListTile(



          leading: CircleAvatar(backgroundImage: NetworkImage(ratingModel!.userImg!),),
          title: Text(ratingModel!.userName!,style: Theme.of(context).textTheme.headline2,),
          /*subtitle: Text(user.userMessage!),*/
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ratingModel!.userMessage!,style: TextStyle(color: Colors.grey,fontSize: 11),),
              /*     Text(user.rating!),*/

              RatingBarIndicator(
                rating:ratingModel!.rating! == ""?0.0: double.parse(ratingModel!.rating!),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                unratedColor: Colors.amber.withAlpha(50),
                direction: Axis.horizontal,
              ),
              Text(ratingModel!.time!,style: TextStyle(color: Colors.grey,fontSize: 11),),
            ],),

        ),
        SizedBox(height: 10,),
        EntryField(
          controller: _titleController,
          label: 'Review Reply',
          image: null,
          keyboardType: TextInputType.name,
          maxLength: null,
          readOnly:  _progressBtn == true?false:true,
          hint: 'Review Reply',
        ),

        _progressBtn == true? Container(
          height: 64.0,
          margin: const EdgeInsets.only(top: 100, bottom: 10),
          child: BottomBar(
            check: false,
            text:"Review Reply",
            onTap: () {
              if (_titleController.text.length == 0) {
                showToast("Please enter your rating reply...");
              }else {
                setState(() {
                  _progress = true;
                });

                updateVisible(widget.refId!,ratingModel!);



              }
            },
          ),
        ): Container(),
        Container(
          child: _progress
              ? new LinearProgressIndicator(
            backgroundColor: Colors.cyanAccent,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          )
              : new Container(),)


      ],),
    );
  }
}
