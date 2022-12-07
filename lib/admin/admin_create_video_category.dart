import 'dart:io';
import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AdminCreateVideoCategoryScreen extends StatefulWidget {
  const AdminCreateVideoCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminCreateVideoCategoryScreen> createState() => _AdminCreateVideoCategoryScreenState();
}

class _AdminCreateVideoCategoryScreenState extends State<AdminCreateVideoCategoryScreen> {
  final TextEditingController _mobileController = TextEditingController();

  String ButtonText = "Create Category";

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }
  CollectionReference userss = FirebaseFirestore.instance.collection('videoCategory');
  void video()async {
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String videoids = "VideoCategory" + randomNumber.toString();



    userss
        .add({
      "id": videoids,
      "title":_mobileController.text,
    "image":imageUrlwhite2})
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Video category create sucssfully..."),


      Navigator.pop(context),

    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }
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
  String? imageUrlwhite2 ="assets/images/upload.png";

  // for upload image
  void _onButtonPressed(String type) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 300,
            child: Container(
              child: _buildBottomNavigationMenu(type),
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

  Container _buildBottomNavigationMenu(String type) {
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
                            _cameraPermission(type);
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

                            pickimage(type);
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

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? photo;
  XFile? _image;
  String imgpath = "";
  final _firebaseStorage = FirebaseStorage.instance;
  bool checkprogressWhite2 = false;
  _cameraPermission(String type) async {
    photo = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      if (photo!.path.length > 0) {
        setState(() {
          _image = photo;


          if (type == "white2") {
            checkprogressWhite2 = true;
          }

          imgpath = _image!.path;
        });
        var file = File(imgpath);

        var snapshot = await _firebaseStorage
            .ref()
            .child('images/' + _image!.name)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          if (type == "white2") {
            imageUrlwhite2 = downloadUrl;
            checkprogressWhite2 = false;
          }
        });
      }
    } else {
      showToast('Permission not granted. Try Again with permission access');
    }

  }

  pickimage(String type) async {
    photo = await _picker.pickImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    if (photo!.path.length > 0) {
      setState(() {
        _image = photo;

        if (type == "white2") {
          checkprogressWhite2 = true;
        }

        imgpath = _image!.path;
      });

      var file = File(imgpath);
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/' + _image!.name)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        if (type == "white2") {
          imageUrlwhite2 = downloadUrl;
          checkprogressWhite2 = false;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Video Category"),),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 50,),
          InkWell(
            onTap:(){
              _onButtonPressed("white2");
            },
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration:imageUrlwhite2 == "assets/images/upload.png" ?  BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/upload.png"),),
                ):BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrlwhite2!),
                    fit: BoxFit.cover,),
                ),
              ),
            ],),
          ),
          SizedBox(height: 50,),
          EntryField(
            controller: _mobileController,
            label: 'Video Category Name',
            image: null,
            keyboardType: TextInputType.text,
            maxLength: null,
            readOnly: false,
            hint: 'Video Category Name',
          ),



      Container(
        height: 64.0,
        margin: const EdgeInsets.only(top: 50, bottom: 10),
        child: BottomBar(
          check: false,
          text: ButtonText,
          onTap: () {
            if (_mobileController.text.length == 0) {
              showToast("Please enter you mobile number...");
            } else {
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
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        )
            : new Container(),)
        ],),
    );
  }
}
