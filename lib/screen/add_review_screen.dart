import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/BuyDressOrder.dart';
import 'package:amin/model/CourseBuy.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/model/RatingModel.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/screen/home_order_account.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';




class AddReviewScreen extends StatefulWidget {
  BuyDressOrder? dressModel;
  CourseBuy? coursebut;
  CourseList? courseList;
  String? type;
  String? refId;
  AddReviewScreen({Key? key,
    required this.dressModel,
    required this.coursebut,
    required this.courseList,
    required this.refId,
  required this.type}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  BuyDressOrder? dressModel;
  CourseBuy? courseBut;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type == "Dress"){

      dressModel = widget.dressModel!;
      getData();
    }else {

      courseBut = widget.coursebut;
      getCourse();
    }



  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docssDress;
  List<RatingModel> productList = [];
  double ratingValue = 0.0;

  DressModel dressModelNew = DressModel();
  CourseList courseModelNew = CourseList();
  late String refIdDress = "";
  late String refIdCourse = "";
  late bool checkDress = false;

  
  //course
  getCourse()async{


    print("check data type length  Dress API  786  =  "+courseBut!.cId.toString());
    var results = await FirebaseFirestore.instance
        .collection('courses')
        .where('cId', isEqualTo:  courseBut!.cId)
        .get()
        .then((value) => {

      print("check data type length  Dress API    =  "+value.size.toString()),
      if (value.size >= 1)
        {

          docssDress = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              courseModelNew = CourseList.fromJson(docssDress[i].data()),
              refIdCourse = value.docs[i].reference.id,
              print("Course Model value =   "+courseModelNew.toString()),
              print("Course Refrance Id value =   "+refIdCourse.toString()),

            }
        }else {


      }
    });
    var result = await FirebaseFirestore.instance
        .collection('Ratings')
        .where('productId', isEqualTo: courseBut!.cId)
        .where('type', isEqualTo: "Course")
        .get()
        .then((value) => {

      print("check data type length  Rating API  =  "+value.size.toString()),
      if (value.size >= 1)
        {

          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              model = RatingModel.fromJson(docss[i].data()),
              productList.add(model),
              ratingValue =ratingValue +  double.parse(model.rating!),
              print("ratingValue Id value  =   "+ratingValue.toString()),
              setState(() {
                ratingValue;
              })


            }
        }
    });
  }

  // dress
  getData()async{
    var results = await FirebaseFirestore.instance
        .collection('dress')
        .where('id', isEqualTo: dressModel!.dressId)
        .get()
        .then((value) => {

      print("check data type length  Dress API    =  "+value.size.toString()+", product id  =  "+dressModel!.dressId.toString()),
      if (value.size >= 1)
        {

          docssDress = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              dressModelNew = DressModel.fromJson(docssDress[i].data()),
              refIdDress = value.docs[i].reference.id,
              print("Dress Model value =   "+dressModelNew.toString()),
              print("Refrance Id value =   "+refIdDress.toString()),

            }
        }else {
        setState(() {
          checkDress = true;
        })

      }
    });





    var result = await FirebaseFirestore.instance
        .collection('Ratings')
        .where('productId', isEqualTo: dressModel!.dressId)
        .where('type', isEqualTo: "Dress")
        .get()
        .then((value) => {

      print("check data type length  Rating API  =  "+value.size.toString()+", product id  =  "+dressModel!.dressId.toString()),
      if (value.size >= 1)
        {

          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              model = RatingModel.fromJson(docss[i].data()),
              ratingValue =ratingValue +  double.parse(model.rating!),
              print("ratingValue Id value  =   "+ratingValue.toString()),
              setState(() {
                ratingValue;
              })


            }
        }
    });
  }
  String ratingNew = "3.0";
  bool _progress = false;
  late RatingModel model;

  CollectionReference userss = FirebaseFirestore.instance.collection('Ratings');
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
  String? Uname = '';
  String? Uimg = '';
  String? Uid = '';

  double ratingValuenew =0.0;
  sendCourseRating()async{
    int sizeList = productList.length +1;
    print("Rating value After send 786 ratingValuenew =   "+ratingValuenew.toString());
    print("Rating value After send 786 =   "+ratingValue.toString());
    ratingValue = ratingValuenew+ratingValue;
    print("Rating value After send 786 =   "+ratingValue.toString());
    ratingValue = ratingValue/ sizeList;

    print("Rating value After send =   "+ratingValue.toString());
    print("Size value After send  =   "+sizeList.toString());

    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formattcertime = new DateFormat("hh:mm a");
    String formattedDate = formatter.format(now);
    String formattedTime = formattcertime.format(now);


    final pref = getIt<SharedPreferenceHelper>();
    Uname = await pref.getUserName();
    Uimg = await pref.getUserImage();
    Uid = await pref.getUserId();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String courseids = "Review" + randomNumber.toString();
    courseBut!.setReview = "true";
   FirebaseFirestore.instance.collection('course_buy').doc(widget.refId).update(courseBut!.toJson());

    courseModelNew.setRating = ratingValue.toString();
    print("check data refIdCourse = "+refIdCourse+", courseModelNew.toJson() =  "+courseModelNew.toJson().toString());
    FirebaseFirestore.instance.collection('courses').doc(refIdCourse).update(courseModelNew.toJson());

    model = RatingModel(id:courseids,
        productId:courseBut!.cId,
        rating:ratingNew,
        reply:"",
        time:formattedDate+" "+formattedTime,
        type:widget.type,
        userId:Uid,
        userImg:Uimg,
        userMessage:_titleController.text.toString(),
        userName:Uname,
        visible:"1");


    userss
        .add(model.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Rating submit successfully."),
      nextScreen(context, HomeOrderAccount()),



    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }

  sendRating()async {
    int sizeList = productList.length +1;
    print("Rating value After send 786 ratingValuenew =   "+ratingValuenew.toString());
    print("Rating value After send 786 =   "+ratingValue.toString());
    ratingValue = ratingValuenew+ratingValue;
    print("Rating value After send 786 =   "+ratingValue.toString());
    ratingValue = ratingValue/ sizeList;

    print("Rating value After send =   "+ratingValue.toString());
    print("Size value After send  =   "+sizeList.toString());



    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formattcertime = new DateFormat("hh:mm a");
    String formattedDate = formatter.format(now);
    String formattedTime = formattcertime.format(now);


    final pref = getIt<SharedPreferenceHelper>();
    Uname = await pref.getUserName();
    Uimg = await pref.getUserImage();
    Uid = await pref.getUserId();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String courseids = "Review" + randomNumber.toString();

    if(checkDress == false){
      dressModelNew.setRating = ratingValue.toString();
      FirebaseFirestore.instance.collection('dress').doc(refIdDress).update(dressModelNew.toJson());
    }


    dressModel!.setRating= "true";
    FirebaseFirestore.instance.collection('BuyDress').doc(widget.refId).update(dressModel!.toJson());

    model = RatingModel(id:courseids,
        productId:widget.dressModel!.dressId,
        rating:ratingNew,
        reply:"",
        time:formattedDate+" "+formattedTime,
        type:widget.type,
        userId:Uid,
        userImg:Uimg,
        userMessage:_titleController.text.toString(),
        userName:Uname,
        visible:"1");


    userss
        .add(model.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Rating submit successfully."),
      nextScreen(context, HomeOrderAccount()),



    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return widget.type == "Dress"? Scaffold(
      appBar: AppBar(title: Text("Add Review"),centerTitle: true,),
      body: ListView(children: [
        Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Container(width: 100,
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(image: NetworkImage(widget.dressModel!.dressImg!),fit: BoxFit.fill)
          ),),
          Container(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Text(widget.dressModel!.dressTitle!,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("Rs "+widget.dressModel!.dressUnitPrice!,style: TextStyle(color: Colors.grey,fontSize: 12),),
          ],),)
        ],),),

        Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Center(child: Text("Your overall rating of this product",style: TextStyle(color: Colors.grey,fontSize: 12),),),),
        Container(margin: const EdgeInsets.symmetric(horizontal: 20),
        child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingValuenew = rating;
            print(rating);
            ratingNew = rating.toString();
          },
        ),),

        SizedBox(height: 10,),
        EntryField(
          controller: _titleController,
          label: 'Message',
          image: null,
          keyboardType: TextInputType.name,
          maxLength: null,
          readOnly:  false,
          hint: 'Message',
        ),
        SizedBox(height: 10,),
        Container(
          height: 64.0,
          margin: const EdgeInsets.only(top: 100, bottom: 10),
          child: BottomBar(
            check: false,
            text:"Review",
            onTap: () {
              if (_titleController.text.length == 0) {
                showToast("Please enter you coupon title...");
              }else {
                setState(() {
                  _progress = true;
                });
                  sendRating();



              }
            },
          ),
        ),
        Container(
          child: _progress
              ? new LinearProgressIndicator(
            backgroundColor: Colors.cyanAccent,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          )
              : new Container(),)
      ],),
    ):
    Scaffold(
      appBar: AppBar(title: Text("Add Review"),centerTitle: true,),
      body: ListView(children: [
        Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(width: 100,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(image: NetworkImage(widget.courseList!.cThum!),fit: BoxFit.fill)
                ),),
              Container(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.courseList!.cName!,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text("Rs "+widget.courseList!.cPrice!,style: TextStyle(color: Colors.grey,fontSize: 12),),
                ],),)
            ],),),

        Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Center(child: Text("Your overall rating of this product",style: TextStyle(color: Colors.grey,fontSize: 12),),),),
        Container(margin: const EdgeInsets.symmetric(horizontal: 20),
          child: RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              ratingValuenew =  rating;

              print("Rating value After send 77 =   "+ratingValuenew.toString());
              print(rating);
              ratingNew = rating.toString();
              setState(() {
                ratingValuenew;
              });
            },
          ),),

        SizedBox(height: 10,),
        EntryField(
          controller: _titleController,
          label: 'Message',
          image: null,
          keyboardType: TextInputType.name,
          maxLength: null,
          readOnly:  false,
          hint: 'Message',
        ),
        SizedBox(height: 10,),
        Container(
          height: 64.0,
          margin: const EdgeInsets.only(top: 100, bottom: 10),
          child: BottomBar(
            check: false,
            text:"Review",
            onTap: () {
              if (_titleController.text.length == 0) {
                showToast("Please enter your review details...");
              }else {
                setState(() {
                  _progress = true;
                });
                sendCourseRating();



              }
            },
          ),
        ),
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
