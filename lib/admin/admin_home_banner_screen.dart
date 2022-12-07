

import 'dart:io';

import 'package:amin/Components/entry_fields.dart';
import 'package:amin/admin/admin_couponList.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/home_banner.dart';
import 'package:amin/screen/courses.dart';
import 'package:amin/screen/date_of_birth_frebase.dart';
import 'package:amin/screen/full_dress_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AdminHomeBannerScreen extends StatefulWidget {
  const AdminHomeBannerScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeBannerScreen> createState() => _AdminHomeBannerScreenState();
}

class _AdminHomeBannerScreenState extends State<AdminHomeBannerScreen> {



  @override
  void initState() {
    super.initState();
    getData();
    // scamera = widget.camera;
  }

  String? imageUrlWhite1 ="assets/images/upload.png";
  String? imageUrlwhite2 ="assets/images/upload.png";

  String? imageUrlWhite3 ="assets/images/upload.png";
  String? imageUrlwhite4 ="assets/images/upload.png";
  int? firstBannerType = 1;
  int? secondBannerType =2;
  int? threeBannerType =3;
  int? fourBannerType =4;

  String? firstProductId = "";

  bool checkprogressWhite1 = false;
  bool checkprogressWhite2 = false;
  bool checkprogressWhite3 = false;
  bool checkprogressWhite4 = false;
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

  _cameraPermission(String type) async {
    photo = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      if (photo!.path.length > 0) {
        setState(() {
          _image = photo;

          /* uploadFile(_image);*/
          /* uploadFiles(file);*/

          if (type == "white1") {
            checkprogressWhite1 = true;
          } else if (type == "white2") {
            checkprogressWhite2 = true;
          }else  if (type == "white3") {
            checkprogressWhite3 = true;
          } else if (type == "white4") {
            checkprogressWhite4 = true;
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
          if (type == "white1") {
            imageUrlWhite1 = downloadUrl;
            checkprogressWhite1 = false;
          } else if (type == "white2") {
            imageUrlwhite2 = downloadUrl;
            checkprogressWhite2 = false;
          }else if (type == "white3") {
            imageUrlWhite3 = downloadUrl;
            checkprogressWhite3 = false;
          } else if (type == "white4") {
            imageUrlwhite4 = downloadUrl;
            checkprogressWhite4 = false;
          }
        });
      }
    } else {
      showToast('Permission not granted. Try Again with permission access');
    }

//
  }

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
  pickimage(String type) async {
    photo = await _picker.pickImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    if (photo!.path.length > 0) {
      setState(() {
        _image = photo;

        if (type == "white1") {
          checkprogressWhite1 = true;
        } else if (type == "white2") {
          checkprogressWhite2 = true;
        }else if (type == "white3") {
          checkprogressWhite3 = true;
        } else if (type == "white4") {
          checkprogressWhite4 = true;
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
        if (type == "white1") {
          imageUrlWhite1 = downloadUrl;
          checkprogressWhite1 = false;
        } else if (type == "white2") {
          imageUrlwhite2 = downloadUrl;
          checkprogressWhite2 = false;
        }else if (type == "white3") {
          imageUrlWhite3 = downloadUrl;
          checkprogressWhite3 = false;
        } else if (type == "white4") {
          imageUrlwhite4= downloadUrl;
          checkprogressWhite4 = false;
        }
      });
    }
  }
  bool _progress = false;

  CollectionReference userss = FirebaseFirestore.instance.collection('home_banner');
  late HomeBanner homeBanner;
  HomeBanner homeBannerList = HomeBanner();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  bool banenrvisit = false;

  String? refId = "";


  getData()async{
    var results = await FirebaseFirestore.instance
        .collection('home_banner')
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
              homeBannerList = HomeBanner.fromJson(docss[i].data()),
              imageUrlWhite1 = homeBannerList.firstImgUrl!,
              imageUrlwhite2 = homeBannerList.secImgUrl!,
              imageUrlWhite3 = homeBannerList.thirdImgUrl!,
              imageUrlwhite4 = homeBannerList.fourImgUrl!,
              refId = value.docs[i].reference.id,
              setState(() {
                refId;
                homeBannerList;
                banenrvisit = true;
              }),
            }
        }
      else
        {
          setState(() {
            banenrvisit = false;
          }),
          cprint('login message = mobile = false'),
          // showToast("No Data")
        }
    });
  }



  updateData()async{
    homeBanner = HomeBanner(
      firstImgUrl: imageUrlWhite1,
      firstImgType: "1",
      secImgUrl: imageUrlwhite2,
      secImgType: "2",
      thirdImgUrl: imageUrlWhite3,
      thirdImgType: "3",
      fourImgUrl: imageUrlwhite4,
      fourImgType: "4",
    );
    FirebaseFirestore.instance.collection('home_banner').doc(refId).update(homeBanner.toJson());
    showToast("Banner update sucssfully...");
    Navigator.pop(context);
  }
  sendData()async{
    homeBanner = HomeBanner(
        firstImgUrl: imageUrlWhite1,
        firstImgType: "1",
      secImgUrl: imageUrlwhite2,
      secImgType: "2",
      thirdImgUrl: imageUrlWhite3,
      thirdImgType: "3",
      fourImgUrl: imageUrlwhite4,
      fourImgType: "4",
    );
    userss
        .add(homeBanner.toJson())
        .then((value) => {
      setState(() {
        _progress = false;
      }),
      showToast("Banner create sucssfully..."),
      Navigator.pop(context),
    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen Banner"),),
      body: ListView(children: [
        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Upload image for First Banner",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: (){
            _onButtonPressed("white1");
          },
          child:checkprogressWhite1 == true?Center(child: CircularProgressIndicator(),):  Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration:imageUrlWhite1 == "assets/images/upload.png" ?  BoxDecoration(
              image: DecorationImage(
                image:  AssetImage("assets/images/upload.png"),),
            ):  BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(imageUrlWhite1!),
                fit: BoxFit.cover,),
            ),

          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(width: 70,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: firstBannerType == 1 ? Colors.blue: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(5))

            ),
            child: Center(child: Text("Product"),),),
          ],
        ),





        // seconds img

        SizedBox(height: 20,),
        Container(height: 1,color: Colors.grey,),

        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Upload image for Second Banner",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: (){
            _onButtonPressed("white2");
          },
          child:checkprogressWhite2 == true?Center(child: CircularProgressIndicator(),):   Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration:imageUrlwhite2 == "assets/images/upload.png" ?  BoxDecoration(
              image: DecorationImage(
                image:  AssetImage("assets/images/upload.png"),),
            ) : BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(imageUrlwhite2!),
                fit: BoxFit.cover,),
            ),

          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(width: 70,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color:  Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5))

              ),
              child: Center(child: Text("Course"),),),
          ],
        ),

        SizedBox(height: 20,),
        Container(height: 1,color: Colors.grey,),


        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Upload image for Third Banner",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: (){
            _onButtonPressed("white3");
          },
          child: checkprogressWhite3 == true?Center(child: CircularProgressIndicator(),):  Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration:imageUrlWhite3 == "assets/images/upload.png" ?  BoxDecoration(
              image: DecorationImage(
                image:  AssetImage("assets/images/upload.png"),),
            ) :  BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(imageUrlWhite3!),
                fit: BoxFit.cover,),
            ),

          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(width: 70,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5))

              ),
              child: Center(child: Text("Video"),),),
          ],
        ),








        SizedBox(height: 20,),
        Container(height: 1,color: Colors.grey,),

/*        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Upload image for fourth Banner",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: (){
            _onButtonPressed("white4");
          },
          child:checkprogressWhite4 == true?Center(child: CircularProgressIndicator(),):   Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: imageUrlwhite4 == "assets/images/upload.png" ?  BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(imageUrlwhite4!),),
            ) : BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(imageUrlwhite4!),
                fit: BoxFit.cover,),
            ),

          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(width: 70,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5))

              ),
              child: Center(child: Text("Video"),),),
          ],
        ),


        SizedBox(height: 20,),
        Container(height: 1,color: Colors.grey,),*/
        SizedBox(height: 20,),




        InkWell(
          onTap: (){
            if(imageUrlWhite1 ==  "assets/images/upload.png"){
              showToast("Please upload first banner");
            }else if(imageUrlwhite2 ==  "assets/images/upload.png"){
              showToast("Please upload second banner");
            }else if(imageUrlWhite3 ==  "assets/images/upload.png"){
              showToast("Please upload third banner");
            }/*else if(imageUrlwhite4 ==  "assets/images/upload.png"){
              showToast("Please upload fourth banner");
            }*/else {
              setState(() {
                _progress = true;
              });
              if(banenrvisit == false){
                sendData();
              }else {
                updateData();
              }


            }

          },
          child: Container(width: 70,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5))

            ),
            child: Center(child: Text(banenrvisit == false ?"SAVE BANNER":"UPDATE BANNER"),),),
        ),
        SizedBox(height: 20,),
        Container(
          child: _progress
              ? new LinearProgressIndicator(
            backgroundColor: Colors.cyanAccent,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          )
              : new Container(),
        ),
        SizedBox(height: 20,),

      ],),
    );
  }
}
