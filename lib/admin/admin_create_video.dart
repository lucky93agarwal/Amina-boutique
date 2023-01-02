import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AdminCreateVideoScreen extends StatefulWidget {
  String? categories;
  String? subCategory;
  String? cId;
  AdminCreateVideoScreen({Key? key, required this.subCategory, required this.categories,required this.cId}) : super(key: key);

  @override
  State<AdminCreateVideoScreen> createState() => _AdminCreateVideoScreenState();
}

class _AdminCreateVideoScreenState extends State<AdminCreateVideoScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discrptionController = TextEditingController();
  final TextEditingController _timerController = TextEditingController();
  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
    _discrptionController.dispose();
    _timerController.dispose();
    super.dispose();
  }
  String? url ="";

  CollectionReference userss = FirebaseFirestore.instance.collection('video');
  void video()async{
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String videoids = "Video" + randomNumber.toString();


    userss
        .add({"subCategory":widget.subCategory,
      "cId":widget.cId,
      "categories":widget.categories,
      "time":_timerController.text,
      "title":_titleController.text,
      "discription":_discrptionController.text,
      "id": videoids,
      "url":_urlController.text})
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Video create sucssfully..."),


      Navigator.pop(context),

    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }
  showToast(String test){
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
  bool _progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Video").tr(),),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 50,),
          EntryField(
            controller: _urlController,
            label: 'YouTube Full Video Url',
            image: null,
            keyboardType: TextInputType.emailAddress,
            maxLength: null,
            readOnly: false,
            hint:'Please enter only YouTube full video url',
          ),
          SizedBox(height: 10,),
        EntryField(
          controller: _titleController,
          label: 'Video Title',
          image: null,
          keyboardType: TextInputType.emailAddress,
          maxLength: null,
          readOnly: false,
          hint:'Video Title',
        ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
            child: TextField(
              minLines: 1,
              autofocus: false,
              maxLines: 5,  // allow user to enter 5 line in textfield
              keyboardType: TextInputType.multiline,  // user keyboard will have a button to move cursor to next line
              controller: _discrptionController,
              maxLength: 5000,
              decoration: InputDecoration(
                labelText: 'Video Description',
                labelStyle: Theme.of(context).textTheme.caption,
                hintText: 'Video Description',

                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: kMainColor, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 0.0),
                ),

               /* prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(

                    'assets/images/icons/ic_phone.png',
                    color: kMainColor,
                    width: 20.0,
                    height: 20.0,
                  ),
                ),*/
              ),
            ),
          ),
          SizedBox(height: 10,),
          EntryField(
            controller: _timerController,
            label: 'Video Timming',
            image: null,
            keyboardType: TextInputType.emailAddress,
            maxLength: null,
            readOnly: false,
            hint:'hh:mm:ss',
          ),
          Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 50,bottom: 10),
            child: BottomBar(
              check: false,
              text: "Create Video",
              onTap: () {
                bool _validURL = Uri.parse(_urlController.text).isAbsolute;
                if(_validURL==false){
                  showToast("Please enter YouTube video url ...");
                }else
                if (_urlController.text.length == 0) {
                  showToast("Please enter YouTube video url...");
                } else if (_titleController.text.length == 0) {
                  showToast("Please enter YouTube video title..");

                } else if (_discrptionController.text.length == 0) {
                  showToast("Please enter YouTube video description.");

                }  else if (_timerController.text.length == 0) {
                  showToast("Please enter YouTube video time.");

                }else   {
                  setState(() {
                    _progress = true;
                  });

                  video();
                }
              },
            ),




          ),
          Container(
            child: _progress
                ? new LinearProgressIndicator(
              backgroundColor: Colors.cyanAccent,
              valueColor:
              new AlwaysStoppedAnimation<Color>(
                  Colors.red),
            )
                : new Container(),
          )
      ],),
    );
  }
}
