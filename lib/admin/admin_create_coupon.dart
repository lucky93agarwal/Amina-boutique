import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/Coupon.dart';
import 'package:amin/screen/date_of_birth_frebase.dart';
import 'package:amin/screen/date_of_bith.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AdminCreateCouponScreen extends StatefulWidget {
  Coupon? coupon;
  bool? check;
  String? refId;
  AdminCreateCouponScreen({Key? key,required this.coupon,required this.check,required this.refId}) : super(key: key);

  @override
  State<AdminCreateCouponScreen> createState() => _AdminCreateCouponScreenState();
}

class _AdminCreateCouponScreenState extends State<AdminCreateCouponScreen> {

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
  bool _progress = false;
  bool checkprogress = false;



  CollectionReference userss = FirebaseFirestore.instance.collection('Coupon');

  late Coupon couponList;

  final TextEditingController _titleController = TextEditingController();
/*  final TextEditingController _dateController = TextEditingController();*/
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _limitUserController = TextEditingController();
  String ButtonText = "Create";

  void update()async{
    couponList  = Coupon(id:widget.coupon!.id!,
        titleName:_titleController.text,
        limitUser: _limitUserController.text,
        endDate: /*_dateController.text*/date,
        type:checktype == true?"dress":"course");

    FirebaseFirestore.instance.collection('Coupon').doc(widget.refId).update(couponList.toJson());

    showToast("Coupon update successfully...");
    Navigator.pop(context);
  }
  void sendUrlFromServer()async{
    cprint('data sendUrlFromServer method hit');
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String courseids = "CouponId" + randomNumber.toString();
    couponList = Coupon(id:courseids,
        titleName:_titleController.text,
        limitUser: _limitUserController.text,
      endDate: /*_dateController.text*/date,
        percentage:_percentageController.text,
    type:checktype == true?"dress":"course");

    userss
        .add(couponList.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Coupon created successfully..."),
      Navigator.pop(context),



    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _limitUserController.dispose();
   /* _dateController.dispose();*/
    _percentageController.dispose();
    super.dispose();
  }

  bool checktype = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData(){
    if(widget.check ==false){
      _titleController.text = widget.coupon!.titleName!;
      /*_dateController.text*/date = widget.coupon!.endDate!;
      _limitUserController.text = widget.coupon!.limitUser!;
      _percentageController.text = widget.coupon!.percentage!;
      if(widget.coupon!.type! == "dress"){
        checktype = true;
      }else {
        checktype = false;
      }
    }
  }
  setDate()async{
    final result;

    result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DateOfBirthFirebaseScreen()),
    );
    setState(() {
      if(result.toString() != "null"){
        date = result.toString();
      }
    });
  }
  String? date = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.check == true?"Create Coupon":"Update Coupon"),
      ),
      body: ListView(children: [
        SizedBox(height: 10,),
        EntryField(
          controller: _titleController,
          label: 'Coupon code',
          image: null,
          keyboardType: TextInputType.name,
          maxLength: null,
          readOnly: false,
          hint: 'Coupon code',
        ),


        EntryField(
          controller: _limitUserController,
          label: 'Limit User',
          image: null,
          keyboardType: TextInputType.number,
          maxLength: 2,
          readOnly: false,
          hint: 'Limit User',
        ),

        /*EntryField(
          controller: _dateController,
          label: 'yyyy-mm-dd',
          image: 'assets/images/icons/ic_phone.png',
          keyboardType: TextInputType.name,
          maxLength: 10,
          readOnly: false,
          hint: 'yyyy-mm-dd',
        ),*/
        Container(width: MediaQuery.of(context).size.width,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.blue,width: 1)
        ),
        child: InkWell(
          onTap: (){
            setDate();
          },
          child: Row(children: [
           /* Image.asset("assets/images/icons/ic_phone.png",color: Colors.blue,),*/
            SizedBox(width: 10,),
            Text(date!.length ==0?"YYYY-MM-DD":date!,style: TextStyle(color: Colors.grey),)
          ],),
        ),),

        EntryField(
          controller: _percentageController,
          label: 'Percentage (%)',
          image: null,
          keyboardType: TextInputType.number,
          maxLength: 3,
          readOnly: false,
          hint: 'Percentage (%)',
        ),


      SizedBox(height: 10,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        InkWell(
          onTap: (){
            setState(() {
              checktype = true;
              // dress
            });
          },
          child: Container(width: 150,height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color:checktype == true? Colors.green:Colors.red,

              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //                 <--- border radius here
              ),
            ),
            child: Center(child: Text("Product",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
        ),
        InkWell(
          onTap: (){
            setState(() {
              checktype = false;
              // coupons
            });
          },
          child: Container(width: 150,height: 50,
            decoration: BoxDecoration(
              color:checktype == false? Colors.green:Colors.red,
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //                 <--- border radius here
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(child: Text("Course",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
        ),
      ],),


      Container(
        height: 64.0,
        margin: const EdgeInsets.only(top: 100, bottom: 10),
        child: BottomBar(
          check: false,
          text:widget.check == false?"Update Coupon": "Create Coupon",
          onTap: () {
            if (_titleController.text.length == 0) {
              showToast("Please enter you coupon title...");
            } else if (_limitUserController.text.length == 0) {
              showToast("Please enter your coupon user limit..");
            } else if (date!.length == 0) {
              showToast("Please enter your coupon end date..");
            } else if (_percentageController.text.length == 0) {
              showToast("Please enter your percentage..");
            } else {
              setState(() {
                _progress = true;
              });

              if(widget.check == false){

                update();
              }else {
                sendUrlFromServer();
              }


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
