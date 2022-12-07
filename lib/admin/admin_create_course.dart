import 'dart:io';
import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AdminCreateCourseScreen extends StatefulWidget {
  bool? admin;
  CourseList? courseList;
  String? refId;
  AdminCreateCourseScreen({Key? key,required this.admin,required this.courseList,required this.refId}) : super(key: key);

  @override
  State<AdminCreateCourseScreen> createState() => _AdminCreateCourseScreenState();
}

class _AdminCreateCourseScreenState extends State<AdminCreateCourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  String rating = "0.0";
  getData()async{
    if(widget.admin == true){
      _courseDetailsController.text = widget.courseList!.cDetails!;
      _courseTitleController.text = widget.courseList!.cName!;
      _priceController.text = widget.courseList!.cPrice!;
      _mrpController.text = widget.courseList!.cMRP!;
      imageUrl = widget.courseList!.cThum;
      totalvideo = widget.courseList!.video!.length;
      rating = widget.courseList!.cRating!;
      for(int i=0;i<=totalvideo-1;i++){
        _cvDetailsControllers.add(new TextEditingController());
        _cvTimeControllers.add(new TextEditingController());
        _cvTitleControllers.add(new TextEditingController());
        _cvUrlControllers.add(new TextEditingController());

        _cvDetailsControllers[i].text = widget.courseList!.video![i].cvDetails!;
        print("Lucky  cvDetails =  "+widget.courseList!.video![i].cvDetails!);
        _cvTimeControllers[i].text = widget.courseList!.video![i].cvTime!;
        _cvTitleControllers[i].text = widget.courseList!.video![i].cvTitle!;
        _cvUrlControllers[i].text = widget.courseList!.video![i].cvUrl!;
      }
      setState(() {

      });
    }

  }
  final TextEditingController _courseDetailsController = TextEditingController();
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _mrpController = TextEditingController();

  final List<TextEditingController> _cvDetailsControllers = [];
  final List<TextEditingController> _cvTimeControllers = [];
  final List<TextEditingController> _cvTitleControllers = [];
  final List<TextEditingController> _cvUrlControllers = [];


  final ScrollController _scrollController = ScrollController();


  int totalvideo = 0;
  @override
  void dispose() {
    _courseDetailsController.dispose();
    _courseTitleController.dispose();
    _priceController.dispose();
    _mrpController.dispose();


    for(int i=0;i<=totalvideo-1;i++){
      _cvDetailsControllers[i].dispose();
      _cvTimeControllers[i].dispose();
      _cvTitleControllers[i].dispose();
      _cvUrlControllers[i].dispose();
    }

    super.dispose();
  }
  String? url ="";



  CollectionReference userss = FirebaseFirestore.instance.collection('courses');
  late CourseList courseList;
  late CourseVideo courseVideo;
  late List<CourseVideo>? courseVideoList = [];
  void video()async{


    Random randomx = Random();
    int randomNumbers = randomx.nextInt(10000);
    String courseVideoids = "CourseVideo" + randomNumbers.toString();

    for(int i=0;i<=totalvideo-1;i++){

      cprint('data video courseVideoList length index '+i.toString()+" totalvideo");
     /* cprint('data video courseVideoList length _cvTitleControllers[i].text '+_cvTitleControllers[i].text.toString()+"  index = "+i.toString()+" total count  =   "+_cvTitleControllers.length.toString());*/
      courseVideo = CourseVideo(cvId:courseVideoids,
          cvTitle:_cvTitleControllers[i].text,
          cvDetails: _cvDetailsControllers[i].text,
          cvUrl: _cvUrlControllers[i].text,
          cvTime: _cvTimeControllers[i].text);
      courseVideoList!.add(courseVideo);
      cprint('data video courseVideoList length hit '+courseVideoList!.length.toString()+"  index = "+i.toString()+" total = "+totalvideo.toString());
      if(i == totalvideo-1){
        cprint('data video courseVideoList two length hit'+courseVideoList!.length.toString()+"  index = "+i.toString());
       sendUrlFromServer();
      }
    }



  }
  void sendUrlFromServer()async{

    if(widget.admin == true){
      courseList = CourseList(cId:widget.courseList!.cId,
          cName:_courseTitleController.text,
          cDetails: _courseDetailsController.text,
          cMRP: _mrpController.text,
          cPrice: _priceController.text,
          cThum: imageUrl,
          cRating: rating,
          video: courseVideoList);
      FirebaseFirestore.instance.collection('courses').doc(widget.refId).update(courseList.toJson());
      /*  userss
        .add(dressModel.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),*/
      showToast("Course update sucssfully...");
      Navigator.pop(context);
    }else{
      cprint('data sendUrlFromServer method hit');
      Random random = Random();
      int randomNumber = random.nextInt(10000);
      String courseids = "Course" + randomNumber.toString();
      courseList = CourseList(cId:courseids,
          cName:_courseTitleController.text,
          cDetails: _courseDetailsController.text,
          cMRP: _mrpController.text,
          cPrice: _priceController.text,
          cThum: imageUrl,
          cRating: rating,
          video: courseVideoList);

      userss
          .add(courseList.toJson())
          .then((value) => {
        cprint('data insert'),
        setState(() {
          _progress = false;
        }),
        showToast("Course create sucssfully..."),
        Navigator.pop(context),



      })
      // ignore: invalid_return_type_for_catch_error
          .catchError(
              (error) => cprint('Failed to add user: error'));
    }

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
  String? imageUrl = "assets/images/upload.png";

  // for upload image
  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 300,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  pickimage()async {
    final pref = getIt<SharedPreferenceHelper>();
    photo = await _picker.pickImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    if(photo!.path.length > 0){
      setState(() {
        _image = photo;

        checkprogress = true;
        print("Lucky camera path =  " + _image!.path.toString());
        print("Lucky camera name =  " + _image!.name.toString());

        imgpath = _image!.path;
        print("Lucky camera name =  " + _image!.name.toString());

      });

      var file = File(imgpath);
      var snapshot = await _firebaseStorage.ref()
          .child('images/'+_image!.name)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        checkprogress = false;
        imageUrl = downloadUrl;
        print("Lucky pickimage imageUrl=  " + imageUrl.toString());
      });
    }
  }
  Container _buildBottomNavigationMenu() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: Theme.of(context).colorScheme.onSurface,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Pick from Gallery or Camera",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Choose from",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 28),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 00.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            _cameraPermission();
                          },
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
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
                                ]),
                            child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/camera.png",
                                  width: 50,
                                  height: 50,
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);

                            //
                            // AssetPicker.pickAssets(
                            //   context,
                            //   maxAssets:1,
                            //    selectedAssets: assets,
                            //   requestType: RequestType.image,
                            //   textDelegate: EnglishTextDelegate(),
                            // );
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: (BuildContext context) => MultiAssetsPage());

                            pickimage();

                            // showModalBottomSheet(
                            //   isScrollControlled: true,
                            //   backgroundColor: Colors.transparent,
                            //   context: context,
                            //   builder: (context){
                            //     return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                            //       // return buildScreen();
                            //       return BottomSheetData(listimagedata: getimages,listimagedatatwo: getimages, locations: _locations, listvideodata: getvideos,listvideodatatwo: getvideos, onChangedTextField: _nextHandler,);
                            //     });
                            //   },
                            // );
                          },
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
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
                                ]),
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/image-gallery.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkprogress = false;
  String imgpath = "";
  final _firebaseStorage = FirebaseStorage.instance;
  _cameraPermission() async {
    photo = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted){

      if(photo!.path.length > 0){
        setState(() {
          _image = photo;



          /* uploadFile(_image);*/
          /* uploadFiles(file);*/

          checkprogress = true;
          print("Lucky camera path =  " + _image!.path.toString());
          print("Lucky camera name =  " + _image!.name.toString());

          imgpath = _image!.path;
          print("Lucky camera name =  " + _image!.name.toString());

        });
        var file = File(imgpath);

        var snapshot = await _firebaseStorage.ref()
            .child('images/'+_image!.name)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          checkprogress = false;
          imageUrl = downloadUrl;
        });
        print("Lucky camera pickimage imageUrl=  " + imageUrl.toString());
      }
    }else {
      showToast('Permission not granted. Try Again with permission access');
    }

//

  }
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? photo;
  XFile? _image;
  // for upload image
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Course").tr(),),
      body: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
//checkprogress
          InkWell(
            onTap: (){
              _onButtonPressed();
            },
            child: Container(width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: imageUrl == "assets/images/upload.png" ? BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/upload.png"),
            )
            ): BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl!)
            )
            ),
              child: checkprogress == true? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())):Container(),),
          ),

          SizedBox(height: 50,),
          EntryField(
            controller: _courseTitleController,
            label: 'Course Title',
            image: null,
            keyboardType: TextInputType.emailAddress,
            maxLength: null,
            readOnly: false,
            hint:'Please enter course title',
          ),
          SizedBox(height: 10,),
          EntryField(
            controller: _courseDetailsController,
            label: 'Course Details',
            image: null,
            keyboardType: TextInputType.emailAddress,
            maxLength: 5000,
            readOnly: false,
            hint:'Please enter course details',
          ),
          SizedBox(height: 10,),

          EntryField(
            controller: _priceController,
            label: 'Sale Price',
            image:null,
            keyboardType: TextInputType.number,
            maxLength: 4,
            readOnly: false,
            hint:'Sale Price',
          ),
          SizedBox(height: 10,),
          EntryField(
            controller: _mrpController,
            label: 'Regular Price',
            image: null,
            keyboardType: TextInputType.number,
            maxLength: 4,
            readOnly: false,
            hint:'Regular Price',
          ),
          SizedBox(height: 10,),
          Container(  margin: const EdgeInsets.symmetric(horizontal: 20),child: Text("Videos",style: TextStyle(color: Colors.white,fontSize: 15),),),
          Container(child: ListView.builder(shrinkWrap: true,
              controller: _scrollController,
              itemCount: totalvideo,itemBuilder: (BuildContext context,int index){
            if(_cvDetailsControllers.length <totalvideo){
              _cvDetailsControllers.add(new TextEditingController());
              _cvTimeControllers.add(new TextEditingController());
              _cvTitleControllers.add(new TextEditingController());
              _cvUrlControllers.add(new TextEditingController());
            }


            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff595961),width: 1),
              ),
              child: Column(children: [
                SizedBox(height: 10,),
                InkWell(onTap: (){


                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Video ').tr(),
                          content: Text('are you sure').tr(),
                          actions: <Widget>[
                            new GestureDetector(
                              onTap: () => Navigator.of(context).pop(false),
                              child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                            ),
                            SizedBox(height: 16),
                            new GestureDetector(
                              onTap: () {
                                setState(() {
                                  totalvideo = totalvideo-1;
                                  _cvDetailsControllers.removeAt(index);
                                  _cvTimeControllers.removeAt(index);
                                  _cvTitleControllers.removeAt(index);
                                  _cvUrlControllers.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                              child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                            ),
                          /*  new GestureDetector(
                              onTap: () {
                                setState(() {
                                  totalvideo = totalvideo-1;
                                  _cvDetailsControllers.removeAt(index);
                                  _cvTimeControllers.removeAt(index);
                                  _cvTitleControllers.removeAt(index);
                                  _cvUrlControllers.removeAt(index);
                                });
                                Navigator.pop(context);
                                  },
                              child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                            ),*/
                           /* FlatButton(
                                child: Text('yes').tr(),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: kTransparentColor)),
                                textColor: kMainColor,
                                onPressed: () {

                                  setState(() {
                                    totalvideo = totalvideo-1;
                                    _cvDetailsControllers.removeAt(index);
                                    _cvTimeControllers.removeAt(index);
                                    _cvTitleControllers.removeAt(index);
                                    _cvUrlControllers.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                })*/
                          ],
                        );
                      });

                },child: Icon(Icons.delete,color: Colors.blue,),),
                SizedBox(height: 10,),

                EntryField(
                  controller: _cvTitleControllers[index],
                  label: 'Course video title',
                  image: null,
                  keyboardType: TextInputType.text,
                  maxLength: null,
                  readOnly: false,
                  hint:'Course video title',
                ),
                SizedBox(height: 10,),

                EntryField(
                  controller: _cvDetailsControllers[index],
                  label: 'Course video details',
                  image: null,
                  keyboardType: TextInputType.text,
                  maxLength: 5000,
                  readOnly: false,
                  hint:'Course details',
                ),

                SizedBox(height: 10,),

                EntryField(
                  controller: _cvTimeControllers[index],
                  label: 'Course video timming',
                  image: null,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: null,
                  readOnly: false,
                  hint:'mm',
                ),

                SizedBox(height: 10,),

                EntryField(
                  controller: _cvUrlControllers[index],
                  label: 'Course video full url',
                  image: null,
                  keyboardType: TextInputType.text,
                  maxLength: null,
                  readOnly: false,
                  hint:'Course video full url',
                ),
                SizedBox(height: 10,),
              ],),
            );
          }),),
          SizedBox(height: 10,),
          Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 50,bottom: 10),
            child: BottomBar(
              check: false,
              text: "Add Video",
              onTap: () {
                if(totalvideo == 0){
                  totalvideo = totalvideo +1;
                  setState(() {
                    totalvideo;
                  });
                }else {
                  for(int i=0;i<=totalvideo-1;i++){

                    if (_cvDetailsControllers[i].text.length == 0) {
                      showToast("Please enter video details...");
                    } else if (_cvTimeControllers[i].text.length == 0) {
                      showToast("Please enter video time");

                    } else if (_cvTitleControllers[i].text.length == 0) {
                      showToast("Please enter video title");

                    }  else if (_cvUrlControllers[i].text.length == 0) {
                      showToast("Please enter video url");

                    } else  {
                      if(i==totalvideo-1){
                        totalvideo = totalvideo +1;
                        setState(() {
                          totalvideo;
                        });
                      }
                    }
                  }
                }




              },
            ),




          ),
          Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 50,bottom: 10),
            child: BottomBar(
              check: false,
              text:  widget.admin == true?"Update Video":"Create Video",
              onTap: () {
                if (_courseDetailsController.text.length == 0) {
                  showToast("Please enter course details...");
                } else if (_courseTitleController.text.length == 0) {
                  showToast("Please enter course title..");

                } else if (_priceController.text.length == 0) {
                  showToast("Please enter course price.");

                }  else if (_mrpController.text.length == 0) {
                  showToast("Please enter course MRP.");

                } else  if(totalvideo == 0){
                  setState(() {
                    _progress = true;
                  });

                  sendUrlFromServer();
                }else{


                  for(int i=0;i<=totalvideo-1;i++){
                    bool _validURL = Uri.parse(_cvUrlControllers[i].text).isAbsolute;
                    if(_validURL == false){
                      showToast("Please enter video url");
                    }else
                    if (_cvDetailsControllers[i].text.length == 0) {
                      showToast("Please enter video details...");
                    } else if (_cvTimeControllers[i].text.length == 0) {
                      showToast("Please enter video time");

                    } else if (_cvTitleControllers[i].text.length == 0) {
                      showToast("Please enter video title");

                    }  else if (_cvUrlControllers[i].text.length == 0) {
                      showToast("Please enter video url");

                    } else  {
                      if(i==totalvideo-1){
                        setState(() {
                          _progress = true;
                        });

                        video();
                      }
                    }
                  }






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
