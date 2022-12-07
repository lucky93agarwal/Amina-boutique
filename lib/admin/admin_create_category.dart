import 'dart:io';
import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/CategoryModel.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AdminCreateCategoryScreen extends StatefulWidget {
  CategoryModel? model;
  String? redId;
  bool? checkCreateandUpdate;
  AdminCreateCategoryScreen({Key? key,required this.model,required this.redId,required this.checkCreateandUpdate}) : super(key: key);

  @override
  State<AdminCreateCategoryScreen> createState() => _AdminCreateCategoryScreenState();
}

class _AdminCreateCategoryScreenState extends State<AdminCreateCategoryScreen> {
  final TextEditingController _titleController = TextEditingController();
  String ButtonText = "Create";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData()async {
    if(widget.checkCreateandUpdate == true){
      imageUrl = widget.model!.cImg!;
      _titleController.text = widget.model!.cName!;
      setState(() {
        ButtonText = "Update";
      });
    }
  }
  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
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
  String? imageUrl = "assets/images/upload.png";
  bool _progress = false;
  bool checkprogress = false;

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


  void video()async{
    Random randomx = Random();
    int randomNumbers = randomx.nextInt(10000);
    String courseVideoids = "Category" + randomNumbers.toString();





  }

  CollectionReference userss = FirebaseFirestore.instance.collection('category');
  late CategoryModel courseList;


  void updateUrlFromServer()async {
    widget.model!.setImg = imageUrl!;
    widget.model!.setName = _titleController.text;
    FirebaseFirestore.instance.collection('category').doc(widget.redId).update(widget.model!.toJson());
    Navigator.pop(context);
  }
  void sendUrlFromServer()async{
    cprint('data sendUrlFromServer method hit');
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String courseids = "Category" + randomNumber.toString();
    courseList = CategoryModel(cId:courseids,
        cName:_titleController.text,
        cImg: imageUrl);

    userss
        .add(courseList.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),
      showToast("Category create sucssfully..."),
      Navigator.pop(context),



    })
    // ignore: invalid_return_type_for_catch_error
        .catchError(
            (error) => cprint('Failed to add user: error'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Category"),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: (){
              _onButtonPressed();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration:imageUrl == "assets/images/upload.png" ?  BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/upload.png"),
              )
              ): BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl!)
              )
              ),
              child: checkprogress == true? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())):Container(),),
          ),
          EntryField(
            controller: _titleController,
            label: 'Category title',
            image: null,
            keyboardType: TextInputType.name,
            maxLength: null,
            readOnly: false,
            hint: 'Category title',
          ),
          Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 100, bottom: 10),
            child: BottomBar(
              check: false,
              text: ButtonText,
              onTap: () {
                if (_titleController.text.length == 0) {
                  showToast("Please enter you category title...");
                } else if (imageUrl == 0) {
                  showToast("Please upload category image...");
                } else {

    if(widget.checkCreateandUpdate == true){
      setState(() {
        _progress = true;
      });
      updateUrlFromServer();
    }else {
      setState(() {
        _progress = true;
      });
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
                : new Container(),
          )
        ],
      ),
    );
  }
}
