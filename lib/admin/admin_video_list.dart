import 'dart:io';

import 'package:amin/admin/admin_create_video_category.dart';
import 'package:amin/model/videoCategory.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/screen/video.dart';
import 'package:amin/screen/video_play.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AdminVideoListScreen extends StatefulWidget {
  const AdminVideoListScreen({Key? key}) : super(key: key);

  @override
  State<AdminVideoListScreen> createState() => _AdminVideoListScreenState();
}

class _AdminVideoListScreenState extends State<AdminVideoListScreen> {


  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title:
              new Text(content, style: Theme.of(context).textTheme.headline6),
          onTap: () {
            nextScreen(
                context,
                VideoPlayScreen(
                  subCategory: content,
                  categories: vehicle.title,
                  check: true,
                ));
          },
        ),
      );

    return columnContent;
  }

  final queryPost = FirebaseFirestore.instance
      .collection('videoCategory')
      .withConverter<VideoCategory>(
          fromFirestore: (snapshot, _) =>
              VideoCategory.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson());
  deleteDress(String refId){
    FirebaseFirestore.instance.collection('videoCategory').doc(refId).delete();
    Navigator.pop(context);
  }
  late VideoCategory videoCategory;
  updateapi(String refId, String id, String img,String title ){
    String title = _updatetite.text.toString();
    videoCategory = VideoCategory(id:id,
        image:img,
        title: title);

    FirebaseFirestore.instance.collection('videoCategory').doc(refId).update(videoCategory.toJson());
  }
  ScrollController _controller = ScrollController();

  TextEditingController _updatetite = new TextEditingController();

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
          // if (type == "white2") {
            imageUrlwhite2 = downloadUrl;
            checkprogressWhite2 = false;
          // }
        });
      }
    } else {
      showToast('Permission not granted. Try Again with permission access');
    }

  }
  String? imageUrlwhite2 ="assets/images/upload.png";
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
        // if (type == "white2") {
          imageUrlwhite2 = downloadUrl;
          checkprogressWhite2 = false;
        // }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Video List").tr(),
        ),
        body: Stack(
          children: [
            ListView(
              controller: _controller,
              children: [
                /*Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                    border: Border.all(color: Color(0xff595961)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/ic_search.png",
                        width: 20,
                        height: 20,
                        color: Color(0xff595961),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Find something..",
                        style: TextStyle(
                          color: Color(0xff595961),
                        ),
                      )
                    ],
                  ),
                ),*/
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(
                      "Categories",
                      style: Theme.of(context).textTheme.headline5,
                    )),
                FirestoreListView<VideoCategory>(
                    shrinkWrap: true,
                    query: queryPost,
                    controller: _controller,
                    itemBuilder: (context, snapshot) {
                      final user = snapshot.data();

                      String redid = snapshot.reference.id;
                      return InkWell(onTap: (){
                        nextScreenReplace(
                            context,
                            VideoPlayScreen(
                              subCategory: "user.title!",
                              categories: user.title!,
                              check: true,
                            ));
                      },child: Container(width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(user.image!),fit: BoxFit.fill
                        )
                      ),
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(color: Color(0x70000000),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                          child: Row(
                            children: [
                              Text(user.title!,     style: Theme.of(context).textTheme.headline2,),
                              IconButton(onPressed: (){



                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Selected Category Video').tr(),
                                        content: Text('are you sure').tr(),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('no').tr(),
                                            textColor: kMainColor,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(color: kTransparentColor)),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                          FlatButton(
                                              child: Text('yes').tr(),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(color: kTransparentColor)),
                                              textColor: kMainColor,
                                              onPressed: () {

                                                deleteDress(snapshot.reference.id);

                                              })
                                        ],
                                      );
                                    });
                              },icon: Icon(Icons.delete,color: Colors.blue,)),

                              IconButton(onPressed: (){



                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Edit Video Category').tr(),
                                        content: SizedBox(
                                          height: 250,
                                          child: Column(
                                            children: [
                                              new Row(
                                                children: <Widget>[
                                                  new Expanded(
                                                    child: new TextField(
                                                      controller: _updatetite,
                                                      autofocus: true,
                                                      decoration: new InputDecoration(
                                                          labelText: 'Category Title', hintText: user.title!),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 25),
                                              SizedBox(height: 168,
                                              width:168,
                                              child: InkWell(
                                                onTap:(){
                                                  _onButtonPressed("white2");
                                                },
                                                child: Stack(children: [
                                                  Container(
                                                    width: 168,
                                                    height: 168,
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
                                              ),),

                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('no').tr(),
                                            textColor: kMainColor,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(color: kTransparentColor)),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                          FlatButton(
                                              child: Text('yes').tr(),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(color: kTransparentColor)),
                                              textColor: kMainColor,
                                              onPressed: () {
                                                updateapi(snapshot.reference.id,user.id!,imageUrlwhite2 == "assets/images/upload.png" ? user.image! : imageUrlwhite2!,
                                                    _updatetite.text.length >0 ? _updatetite.text : user.title!);
                                                Navigator.pop(context);

                                              })
                                        ],
                                      );
                                    });
                              },icon: Icon(Icons.edit,color: Colors.blue,)),


                              // IconButton(onPressed: (){
                              //
                              //
                              //
                              //   showDialog(
                              //       context: context,
                              //       barrierDismissible: false,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: Text('Delete Selected Category Video').tr(),
                              //           content: Text('are you sure').tr(),
                              //           actions: <Widget>[
                              //             FlatButton(
                              //               child: Text('no').tr(),
                              //               textColor: kMainColor,
                              //               shape: RoundedRectangleBorder(
                              //                   side: BorderSide(color: kTransparentColor)),
                              //               onPressed: () => Navigator.pop(context),
                              //             ),
                              //             FlatButton(
                              //                 child: Text('yes').tr(),
                              //                 shape: RoundedRectangleBorder(
                              //                     side: BorderSide(color: kTransparentColor)),
                              //                 textColor: kMainColor,
                              //                 onPressed: () {
                              //
                              //                   deleteDress(snapshot.reference.id);
                              //
                              //                 })
                              //           ],
                              //         );
                              //       });
                              // },icon: Icon(Icons.edit_attributes,color: Colors.blue,)),
                            ],
                          ),),
                        )
                      ],),),);
                      /*return ListTile(
                          trailing: IconButton(onPressed: (){

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Video Cateory').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('no').tr(),
                                        textColor: kMainColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(color: kTransparentColor)),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      FlatButton(
                                          child: Text('yes').tr(),
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(color: kTransparentColor)),
                                          textColor: kMainColor,
                                          onPressed: () {

                                            deleteDress( snapshot.reference.id);

                                          })
                                    ],
                                  );
                                });




                      },icon: Icon(Icons.delete,color: Colors.blue,)),
                        onTap: () {
                          nextScreenReplace(
                              context,
                              VideoPlayScreen(
                                subCategory: "user.title!",
                                categories: user.title!,
                                check: true,
                              ));
                        },
                        title: Text(
                          user.title!,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      );*/
                    }),
                SizedBox(height: 100,)
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  nextScreen(context, AdminCreateVideoCategoryScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text("create video category").tr(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
