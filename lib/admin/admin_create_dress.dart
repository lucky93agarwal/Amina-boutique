import 'dart:io';
import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/utils/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class AdminCreateDressScreen extends StatefulWidget {
  String? categoryId;
  bool? update;
  DressModel? dressModelUpdateData;
  String? refId;

  AdminCreateDressScreen({Key? key, required this.categoryId,required this.update,required this.dressModelUpdateData,required this.refId})
      : super(key: key);

  @override
  State<AdminCreateDressScreen> createState() => _AdminCreateDressScreenState();
}

class _AdminCreateDressScreenState extends State<AdminCreateDressScreen> {
  bool _progress = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  final TextEditingController _infoController = TextEditingController();

  final TextEditingController _sizeSMRPController = TextEditingController();
  final TextEditingController _sizeSNameController = TextEditingController();
  final TextEditingController _sizeSPriceController = TextEditingController();

  final TextEditingController _sizeLMRPController = TextEditingController();
  final TextEditingController _sizeLNameController = TextEditingController();
  final TextEditingController _sizeLPriceController = TextEditingController();

  final TextEditingController _sizeXLMRPController = TextEditingController();
  final TextEditingController _sizeXLNameController = TextEditingController();
  final TextEditingController _sizeXLPriceController = TextEditingController();

  final TextEditingController _sizeMMRPController = TextEditingController();
  final TextEditingController _sizeMNameController = TextEditingController();
  final TextEditingController _sizeMPriceController = TextEditingController();

  final TextEditingController _sizeSXMRPController = TextEditingController();
  final TextEditingController _sizeSXNameController = TextEditingController();
  final TextEditingController _sizeSXPriceController = TextEditingController();

  final TextEditingController _sizeLXMRPController = TextEditingController();
  final TextEditingController _sizeLXNameController = TextEditingController();
  final TextEditingController _sizeLXPriceController = TextEditingController();

  final TextEditingController _sizeXLXMRPController = TextEditingController();
  final TextEditingController _sizeXLXNameController = TextEditingController();
  final TextEditingController _sizeXLXPriceController = TextEditingController();

  final TextEditingController _sizeMXMRPController = TextEditingController();
  final TextEditingController _sizeMXNameController = TextEditingController();
  final TextEditingController _sizeMXPriceController = TextEditingController();

  final TextEditingController _sizeXXLXMRPController = TextEditingController();
  final TextEditingController _sizeXXLXNameController = TextEditingController();
  final TextEditingController _sizeXXLXPriceController =
      TextEditingController();

  final TextEditingController _sizeXXXLXMRPController = TextEditingController();
  final TextEditingController _sizeXXXLXNameController =
      TextEditingController();
  final TextEditingController _sizeXXXLXPriceController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryId = widget.categoryId;

    getData();
  }

  getData(){
    if(widget.update == true){
      _titleController.text = widget.dressModelUpdateData!.title!;
      _detailsController.text = widget.dressModelUpdateData!.details!;
      _infoController.text = widget.dressModelUpdateData!.info!;
      imageUrlWhite1 = widget.dressModelUpdateData!.imgWhite1!;
      imageUrlwhite2 = widget.dressModelUpdateData!.imgWhite2!;

      sizeM = widget.dressModelUpdateData!.mSize!;
      if(sizeM == "1"){
        _sizeMMRPController.text = widget.dressModelUpdateData!.mmrp!;
        _sizeMNameController.text = widget.dressModelUpdateData!.mname!;
        _sizeMPriceController.text = widget.dressModelUpdateData!.mPrice!;
      }
      if(widget.dressModelUpdateData!.couponApply! == "true"){
        setState(() {
          check_terms = true;
        });

      }



      sizeS = widget.dressModelUpdateData!.sSize!;
      if(sizeS == "1"){
        _sizeSMRPController.text = widget.dressModelUpdateData!.smrp!;
        _sizeSNameController.text = widget.dressModelUpdateData!.sname!;
        _sizeSPriceController.text = widget.dressModelUpdateData!.sPrice!;
      }



      sizeL = widget.dressModelUpdateData!.lSize!;
      if(sizeL == "1"){
        _sizeLMRPController.text = widget.dressModelUpdateData!.lmrp! == null ? "":widget.dressModelUpdateData!.lmrp! ;
        _sizeLNameController.text = widget.dressModelUpdateData!.lname! == null ? "":widget.dressModelUpdateData!.lname! ;
        _sizeLPriceController.text = widget.dressModelUpdateData!.lPrice! == null ? "":widget.dressModelUpdateData!.lname! ;
      }



      sizeXL = widget.dressModelUpdateData!.xLSize!;
      if(sizeXL == "1"){
        _sizeXLMRPController.text = widget.dressModelUpdateData!.xlmrp!;
        _sizeXLNameController.text = widget.dressModelUpdateData!.xlname!;
        _sizeXLPriceController.text = widget.dressModelUpdateData!.xLPrice!;
      }


      sizeMX = widget.dressModelUpdateData!.mxSize!;
      if(sizeMX == "1"){
        _sizeMXMRPController.text = widget.dressModelUpdateData!.mxmrp!;
        _sizeMXNameController.text = widget.dressModelUpdateData!.mxname!;
        _sizeMXPriceController.text = widget.dressModelUpdateData!.mxPrice!;
      }



      sizeSX = widget.dressModelUpdateData!.sxSize!;
      if(sizeSX == "1"){
        _sizeSXMRPController.text = widget.dressModelUpdateData!.sxmrp!;
        _sizeSXNameController.text = widget.dressModelUpdateData!.sxname!;
        _sizeSXPriceController.text = widget.dressModelUpdateData!.sxPrice!;
      }
      sizeLX = widget.dressModelUpdateData!.lxSize!;
      if(sizeLX == "1"){
        _sizeLXMRPController.text = widget.dressModelUpdateData!.lxmrp!;
        _sizeLXNameController.text = widget.dressModelUpdateData!.lxname!;
        _sizeLXPriceController.text = widget.dressModelUpdateData!.lxPrice!;
      }

      sizeXLX = widget.dressModelUpdateData!.xLxSize!;
      if(sizeXLX == "1"){
        _sizeXLXMRPController.text = widget.dressModelUpdateData!.xlxmrp!;
        _sizeXLXNameController.text = widget.dressModelUpdateData!.xlxname!;
        _sizeXLXPriceController.text = widget.dressModelUpdateData!.xLxPrice!;
      }


      sizeXXLX =widget.dressModelUpdateData!.xxLxSize!;
      if(sizeXXLX == "1"){
        _sizeXXLXMRPController.text = widget.dressModelUpdateData!.xxlxmrp!;
        _sizeXXLXNameController.text = widget.dressModelUpdateData!.xxlxname!;
        _sizeXXLXPriceController.text = widget.dressModelUpdateData!.xxLxPrice!;
      }

      sizeXXXLX = widget.dressModelUpdateData!.xxxLxSize!;
      if(sizeXXXLX == "1"){
        _sizeXXXLXMRPController.text = widget.dressModelUpdateData!.xxxlxmrp!;
        _sizeXXXLXNameController.text = widget.dressModelUpdateData!.xxxlxname!;
        _sizeXXXLXPriceController.text = widget.dressModelUpdateData!.xxxLxPrice!;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _detailsController.dispose();
    _infoController.dispose();
    _sizeLMRPController.dispose();
    _sizeLNameController.dispose();
    _sizeLPriceController.dispose();

    _sizeSPriceController.dispose();
    _sizeSNameController.dispose();
    _sizeSMRPController.dispose();

    _sizeXLMRPController.dispose();
    _sizeXLNameController.dispose();
    _sizeXLPriceController.dispose();

    _sizeMMRPController.dispose();
    _sizeMNameController.dispose();
    _sizeMPriceController.dispose();

    _sizeLXMRPController.dispose();
    _sizeLXNameController.dispose();
    _sizeLXPriceController.dispose();

    _sizeSXPriceController.dispose();
    _sizeSXNameController.dispose();
    _sizeSXMRPController.dispose();

    _sizeXLXMRPController.dispose();
    _sizeXLXNameController.dispose();
    _sizeXLXPriceController.dispose();

    _sizeMXMRPController.dispose();
    _sizeMXNameController.dispose();
    _sizeMXPriceController.dispose();

    _sizeXXLXMRPController.dispose();
    _sizeXXLXNameController.dispose();
    _sizeXXLXPriceController.dispose();

    _sizeXXXLXMRPController.dispose();
    _sizeXXXLXNameController.dispose();
    _sizeXXXLXPriceController.dispose();
  }

  String? categoryId = "";
  String? sizeM = "0";
  String? sizeS = "0";
  String? sizeL = "0";
  String? sizeXL = "0";

  String? sizeMX = "0";
  String? sizeSX = "0";
  String? sizeLX = "0";
  String? sizeXLX = "0";

  String? sizeXXLX = "0";
  String? sizeXXXLX = "0";

  String? imageUrlBlackTotal =
      "assets/images/upload.png";

  bool checkprogressWhite1 = false;
  bool checkprogressWhite2 = false;
  String? imageUrlWhite1 =
      "assets/images/upload.png";
  String? imageUrlwhite2 =
      "assets/images/upload.png";
//https://ajaxuploader.com/document/scr/images/drag-drop-file-upload.png
  String ButtonText = "Create";

  String ButtonTextSize = "Add Size";
  int addSize = 0;

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
          }
        });
      }
    } else {
      showToast('Permission not granted. Try Again with permission access');
    }

//
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
        }
      });
    }
  }

  ScrollController _controller = ScrollController();

  late DressModel dressModel;

  late DressModel dressModelUpdate = DressModel();

  CollectionReference userss = FirebaseFirestore.instance.collection('dress');

  void sendData() async {
    cprint('data sendUrlFromServer method hit');
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String courseids = "Dress" + randomNumber.toString();

    cprint('data sendUrlFromServer method mSize = '+sizeM!);
    cprint('data sendUrlFromServer method sizeS = '+sizeS!);
    cprint('data sendUrlFromServer method sizeXL = '+sizeXL!);
    cprint('data sendUrlFromServer method sizeL = '+sizeL!);
    cprint('data sendUrlFromServer method sizeMX = '+sizeMX!);
    cprint('data sendUrlFromServer method sizeSX = '+sizeSX!);

    dressModel = DressModel(
      couponApply: check_terms.toString(),
      id: courseids,
      category: categoryId,
      title: _titleController.text.toString(),
      details: _detailsController.text.toString(),
      info: _infoController.text.toString(),


      mSize: sizeM,
      mname: _sizeMNameController.text.toString().toString().length == 0?"0":_sizeMNameController.text.toString(),
      mPrice: _sizeMPriceController.text.toString().toString().length == 0?"0":_sizeMPriceController.text.toString(),
      mmrp: _sizeMMRPController.text.toString().toString().length == 0?"0":_sizeMMRPController.text.toString(),

      sSize: sizeS,
      sPrice: _sizeSPriceController.text.toString().toString().length == 0?"0":_sizeSPriceController.text.toString(),
      smrp: _sizeSMRPController.text.toString().toString().length == 0?"0":_sizeSMRPController.text.toString(),
      sname: _sizeSNameController.text.toString().toString().length == 0?"0":_sizeSNameController.text.toString(),

      lSize: sizeL,
      lPrice: _sizeLPriceController.text.toString().toString().length == 0?"0":_sizeLPriceController.text.toString(),
      lmrp: _sizeLMRPController.text.toString().toString().length == 0?"0":_sizeLMRPController.text.toString(),
      lname: _sizeLNameController.text.toString().toString().length == 0?"0":_sizeLMRPController.text.toString(),

      xLSize: sizeXL,
      xLPrice: _sizeXLPriceController.text.toString().length == 0?"0":_sizeXLPriceController.text.toString(),
      xlmrp: _sizeXLMRPController.text.toString().length == 0?"0":_sizeXLMRPController.text.toString(),
      xlname: _sizeXLNameController.text.toString().length == 0?"0":_sizeXLNameController.text.toString(),


      mxSize: sizeMX,
      mxname: _sizeMXNameController.text.toString().length == 0?"0":_sizeMXNameController.text.toString(),
      mxPrice: _sizeMXPriceController.text.toString().length == 0?"0":_sizeMXPriceController.text.toString(),
      mxmrp: _sizeMXMRPController.text.toString().length == 0?"0":_sizeMXMRPController.text.toString(),

      sxSize: sizeSX,
      sxPrice: _sizeSXPriceController.text.toString().length == 0?"0":_sizeSXPriceController.text.toString(),
      sxmrp: _sizeSXMRPController.text.toString().length == 0?"0":_sizeSXMRPController.text.toString(),
      sxname: _sizeSXNameController.text.toString().length == 0?"0":_sizeSXNameController.text.toString(),


      lxSize: sizeLX,
      lxPrice: _sizeLXPriceController.text.toString().length == 0?"0":_sizeLXPriceController.text.toString(),
      lxmrp: _sizeLXMRPController.text.toString().length == 0?"0":_sizeLXMRPController.text.toString(),
      lxname: _sizeLXNameController.text.toString().length == 0?"0":_sizeLXNameController.text.toString(),

      xLxSize: sizeXLX,
      xLxPrice: _sizeXLXPriceController.text.toString().length == 0?"0":_sizeXLXPriceController.text.toString(),
      xlxmrp: _sizeXLXMRPController.text.toString().length == 0?"0":_sizeXLXMRPController.text.toString(),
      xlxname: _sizeXLXNameController.text.toString().length == 0?"0":_sizeXLXNameController.text.toString(),

      xxLxSize: sizeXXLX,
      xxLxPrice: _sizeXXLXPriceController.text.toString().length == 0?"0":_sizeXXLXPriceController.text.toString(),
      xxlxmrp: _sizeXXLXMRPController.text.toString().length == 0?"0":_sizeXXLXMRPController.text.toString(),
      xxlxname: _sizeXXLXNameController.text.toString().length == 0?"0":_sizeXXLXNameController.text.toString(),


      xxxLxSize: sizeXXXLX,
      xxxLxPrice: _sizeXXXLXPriceController.text.toString().length == 0?"0":_sizeXXXLXPriceController.text.toString(),
      xxxlxmrp: _sizeXXXLXMRPController.text.toString().length == 0?"0":_sizeXXXLXMRPController.text.toString(),
      xxxlxname: _sizeXXXLXNameController.text.toString().length == 0?"0":_sizeXXXLXNameController.text.toString(),

      imgWhite1: imageUrlWhite1,
      imgWhite2: imageUrlwhite2,
        rating:"0.0",
    );

    userss
        .add(dressModel.toJson())
        .then((value) => {
              cprint('data insert'),
              setState(() {
                _progress = false;
              }),
              showToast("Product created successfully..."),
              Navigator.pop(context),
            })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => cprint('Failed to add user: error'));
  }


  void sendUpdateData() async {
    cprint('data sendUrlFromServer method hit');
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String courseids = "Dress" + randomNumber.toString();




    dressModel = DressModel(
      couponApply: check_terms.toString(),
      id: widget.dressModelUpdateData!.id,
      category: categoryId,
      title: _titleController.text.toString(),
      details: _detailsController.text.toString(),
      info: _infoController.text.toString(),


      mSize: sizeM,
      mname: _sizeMNameController.text.toString(),
      mPrice: _sizeMPriceController.text.toString().length == 0?"0":_sizeMPriceController.text.toString(),
      mmrp: _sizeMMRPController.text.toString().length == 0?"0":_sizeMMRPController.text.toString(),

      sSize: sizeS,
      sPrice: _sizeSPriceController.text.toString().length == 0?"0":_sizeSPriceController.text.toString(),
      smrp: _sizeSMRPController.text.toString().length == 0?"0":_sizeSMRPController.text.toString(),
      sname: _sizeSNameController.text.toString(),

      lSize: sizeL,
      lPrice: _sizeLPriceController.text.toString().length == 0?"0":_sizeLPriceController.text.toString(),
      lmrp: _sizeLMRPController.text.toString().length == 0?"0":_sizeLMRPController.text.toString(),
      lname: _sizeLNameController.text.toString(),

      xLSize: sizeXL,
      xLPrice: _sizeXLPriceController.text.toString().length == 0?"0":_sizeXLPriceController.text.toString(),
      xlmrp: _sizeXLMRPController.text.toString().length == 0?"0":_sizeXLMRPController.text.toString(),
      xlname: _sizeXLNameController.text.toString(),


      mxSize: sizeMX,
      mxname: _sizeMXNameController.text.toString(),
      mxPrice: _sizeMXPriceController.text.toString().length == 0?"0":_sizeMXPriceController.text.toString(),
      mxmrp: _sizeMXMRPController.text.toString().length == 0?"0":_sizeMXMRPController.text.toString(),

      sxSize: sizeSX,
      sxPrice: _sizeSXPriceController.text.toString().length == 0?"0":_sizeSXPriceController.text.toString(),
      sxmrp: _sizeSXMRPController.text.toString().length == 0?"0":_sizeSXMRPController.text.toString(),
      sxname: _sizeSXNameController.text.toString(),


      lxSize: sizeLX,
      lxPrice: _sizeLXPriceController.text.toString().length == 0?"0":_sizeLXPriceController.text.toString(),
      lxmrp: _sizeLXMRPController.text.toString().length == 0?"0":_sizeLXMRPController.text.toString(),
      lxname: _sizeLXNameController.text.toString(),

      xLxSize: sizeXLX,
      xLxPrice: _sizeXLXPriceController.text.toString().length == 0?"0":_sizeXLXPriceController.text.toString(),
      xlxmrp: _sizeXLXMRPController.text.toString().length == 0?"0":_sizeXLXMRPController.text.toString(),
      xlxname: _sizeXLXNameController.text.toString(),

      xxLxSize: sizeXXLX,
      xxLxPrice: _sizeXXLXPriceController.text.toString().length == 0?"0":_sizeXXLXPriceController.text.toString(),
      xxlxmrp: _sizeXXLXMRPController.text.toString().length == 0?"0":_sizeXXLXMRPController.text.toString(),
      xxlxname: _sizeXXLXNameController.text.toString(),


      xxxLxSize: sizeXXXLX,
      xxxLxPrice: _sizeXXXLXPriceController.text.toString().length == 0?"0":_sizeXXXLXPriceController.text.toString(),
      xxxlxmrp: _sizeXXXLXMRPController.text.toString().length == 0?"0":_sizeXXXLXMRPController.text.toString(),
      xxxlxname: _sizeXXXLXNameController.text.toString(),

      imgWhite1: imageUrlWhite1,
      imgWhite2: imageUrlwhite2,
        rating: "0.0",
    );



    FirebaseFirestore.instance.collection('dress').doc(widget.refId).update(dressModel.toJson());
  /*  userss
        .add(dressModel.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = false;
      }),*/
      showToast("Product update successfully...");
      Navigator.pop(context);
/*    })
    // ignore: invalid_return_type_for_catch_error
        .catchError((error) => cprint('Failed to add user: error'));*/
  }
  bool check_terms = false;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.update == true?"Update Product":"Create Product"),
      ),
      body: ListView(
        controller: _controller,
        children: [
          SizedBox(
            height: 30,
          ),
          EntryField(
            controller: _titleController,
            label: 'Product Title',
            image: null,
            keyboardType: TextInputType.emailAddress,
            maxLength: null,
            readOnly: false,
            hint: 'Please enter Product title',
          ),
         /* SizedBox(
            height: 10,
          ),
          EntryField(
            controller: _detailsController,
            label: 'Product Details',
            image: null,
            keyboardType: TextInputType.multiline,
            maxLength: 5000,
            readOnly: false,
            hint: 'Please enter Product details',
          ),*/
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
            child: TextField(
              minLines: 1,
              autofocus: false,
              maxLines: 5,  // allow user to enter 5 line in textfield
              keyboardType: TextInputType.multiline,  // user keyboard will have a button to move cursor to next line
              controller: _detailsController,
              maxLength: 5000,
              decoration: InputDecoration(
                labelText: 'Product Details',
                labelStyle: Theme.of(context).textTheme.caption,
                hintText: 'Please enter Product details',

                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: kMainColor, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Colors.grey, width: 0.0),
                ),

              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          EntryField(
            controller: _infoController,
            label: 'Shipping charges',
            image: null,
            keyboardType: TextInputType.number,
            maxLength: null,
            readOnly: false,
            hint: 'Please enter Shipping charges',
          ),
          Row(
            children: <Widget>[

              //SizedBox
              //SizedBox
              /** Checkbox Widget **/
              Checkbox(
                value: check_terms,
                checkColor: kMainColor,
                onChanged: (bool? value) {
                  setState(() {
                    this.value = value!;
                    check_terms = value!;
                    print("check copon code apply or not = "+check_terms.toString());
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: 'Please select to prevent user from applying\n promo code to this product ',style: Theme.of(context).textTheme.subtitle1),

              ])), //Te
            ], //<Widget>[]
          ),
          /*  Container(margin:const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          InkWell(onTap: (){
            setState(() {
              if(sizeS == "0"){
                setState(() {
                  sizeS = "1";
                });
              }else {
                setState(() {
                  sizeS = "0";
                });
              }
            });
          },child: Container(width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: sizeS == "0"? Colors.transparent: Colors.blue,
              border: Border.all(
                width: 1,
                color: sizeS == "0"? Colors.blue: Colors.blue,
              ),
            ),
            child: Center(child: Text("S",style: TextStyle(color: Colors.white,
                fontWeight: sizeS == "1"?FontWeight.bold:FontWeight.normal,
              fontSize: sizeS == "1"?20:15,
            ),),),),),

          InkWell(onTap: (){
            setState(() {
              if(sizeM == "0"){
                setState(() {
                  sizeM = "1";
                });
              }else {
                setState(() {
                  sizeM = "0";
                });
              }
            });
          },child: Container(width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: sizeM == "0"? Colors.transparent: Colors.blue,
              border: Border.all(
                width: 1,
                color: sizeM == "0"? Colors.blue: Colors.blue,
              ),
            ),
            child: Center(child: Text("M",style: TextStyle(color: Colors.white,
              fontWeight: sizeM == "1"?FontWeight.bold:FontWeight.normal,
              fontSize: sizeM == "1"?20:15,
            ),),),),),

          InkWell(onTap: (){
            setState(() {
              if(sizeL == "0"){
                setState(() {
                  sizeL = "1";
                });
              }else {
                setState(() {
                  sizeL = "0";
                });
              }
            });
          },child: Container(width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: sizeL == "0"? Colors.transparent: Colors.blue,
              border: Border.all(
                width: 1,
                color: sizeL == "0"? Colors.blue: Colors.blue,
              ),
            ),
            child: Center(child: Text("L",style: TextStyle(color: Colors.white,
              fontWeight: sizeL == "1"?FontWeight.bold:FontWeight.normal,
              fontSize: sizeL == "1"?20:15,
            ),),),),),


          InkWell(onTap: (){
            setState(() {
              if(sizeXL == "0"){
                setState(() {
                  sizeXL = "1";
                });
              }else {
                setState(() {
                  sizeXL = "0";
                });
              }
            });
          },child: Container(width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: sizeXL == "0"? Colors.transparent: Colors.blue,
              border: Border.all(
                width: 1,
                color: sizeXL == "0"? Colors.blue: Colors.blue,
              ),
            ),
            child: Center(child: Text("XL",style: TextStyle(color: Colors.white,
              fontWeight: sizeXL == "1"?FontWeight.bold:FontWeight.normal,
              fontSize: sizeXL == "1"?20:15,
            ),),),),),


        ],),),*/

          Visibility(
              visible: sizeS == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Size",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){



                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () {
                                            Navigator.pop(context);

                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            sizeS = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeSNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeSPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeSMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Small Size",style: Theme.of(context).textTheme.headline2,),),*/

                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeM == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeM = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),

                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeMNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeMPriceController,
                    label: ' Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeMMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /* SizedBox(height: 10,),*/
                  /* Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Medium Size",style: Theme.of(context).textTheme.headline2,),),*/

                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeL == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeL = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                     /* FlatButton(
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

                                            setState(() {
                                              sizeL = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeLNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeLPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeLMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /* SizedBox(height: 10,),
                  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Large Size",style: Theme.of(context).textTheme.headline2,),),
*/
                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeXL == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeXL = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                     /* FlatButton(
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

                                            setState(() {
                                              sizeXL = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child: Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeXLNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXLPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXLMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /* SizedBox(height: 10,),
                  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Extra Large Size",style: Theme.of(context).textTheme.headline2,),),
*/
                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeSX == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  /* Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Size",style: Theme.of(context).textTheme.headline2,),),*/
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){



                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeSX = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                  /*    FlatButton(
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

                                            setState(() {
                                              sizeSX = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeSXNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeSXPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeSXMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Small Size",style: Theme.of(context).textTheme.headline2,),),*/

                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeMX == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeMX = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                   /*   FlatButton(
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

                                            setState(() {
                                              sizeMX = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeMXNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeMXPriceController,
                    label: ' Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeMXMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /* Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Medium Size",style: Theme.of(context).textTheme.headline2,),),*/

                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeLX == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeLX = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      /*FlatButton(
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

                                            setState(() {
                                              sizeLX = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeLXNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeLXPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeLXMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /*SizedBox(height: 10,),
                  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Large Size",style: Theme.of(context).textTheme.headline2,),),
*/
                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeXLX == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeXLX = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                     /* FlatButton(
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

                                            setState(() {
                                              sizeXLX = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeXLXNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXLXPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXLXMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /*SizedBox(height: 10,),
                  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Extra Large Size",style: Theme.of(context).textTheme.headline2,),),
*/
                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeXXLX == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){


                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){

                                          setState(() {
                                            sizeXXLX = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      /*FlatButton(
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

                                            setState(() {
                                              sizeXXLX = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeXXLXNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXXLXPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXXLXMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /* SizedBox(height: 10,),
                  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Extra Large Size",style: Theme.of(context).textTheme.headline2,),),
*/
                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          Visibility(
              visible: sizeXXXLX == "0" ? false : true,
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details for Size",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        InkWell(
                          onTap: (){

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Product Size').tr(),
                                    content: Text('are you sure').tr(),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                      SizedBox(height: 16),
                                      new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            sizeXXXLX = "0";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                                      ),
                                    /*  FlatButton(
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

                                            setState(() {
                                              sizeXXXLX = "0";
                                              Navigator.pop(context);
                                            });

                                          })*/
                                    ],
                                  );
                                });
                          },
                          child:  Icon(Icons.delete,color: Colors.blue,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  EntryField(
                    controller: _sizeXXXLXNameController,
                    label: 'Size Name',
                    image: null,
                    keyboardType: TextInputType.text,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Size Name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXXXLXPriceController,
                    label: 'Price',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Price',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    controller: _sizeXXXLXMRPController,
                    label: 'Please enter Stock',
                    image: null,
                    keyboardType: TextInputType.number,
                    maxLength: null,
                    readOnly: false,
                    hint: 'Please enter Stock',
                  ),

                  /* SizedBox(height: 10,),
                  Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Select Color for Extra Large Size",style: Theme.of(context).textTheme.headline2,),),
*/
                  Divider(
                    color: Colors.grey,
                  )
                ],
              )),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 50, bottom: 10),
            child: BottomBar(
              check: false,
              text: ButtonTextSize,
              onTap: () {
                setState(() {
                  if (addSize == 0) {
                    addSize = addSize + 1;
                    sizeS = "1";
                  } else if (addSize == 1) {
                    addSize = addSize + 1;
                    sizeM = "1";
                  } else if (addSize == 2) {
                    addSize = addSize + 1;
                    sizeL = "1";
                  } else if (addSize == 3) {
                    addSize = addSize + 1;
                    sizeXL = "1";
                  } else if (addSize == 4) {
                    addSize = addSize + 1;
                    sizeSX = "1";
                  } else if (addSize == 5) {
                    addSize = addSize + 1;
                    sizeMX = "1";
                  } else if (addSize == 6) {
                    addSize = addSize + 1;
                    sizeLX = "1";
                  } else if (addSize == 7) {
                    addSize = addSize + 1;
                    sizeXLX = "1";
                  } else if (addSize == 8) {
                    addSize = addSize + 1;
                    sizeXXLX = "1";
                  } else if (addSize == 9) {
                    addSize = addSize + 1;
                    sizeXXXLX = "1";
                  }
                });
              },
            ),
          ),

          /*Container(margin:const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              InkWell(onTap: (){
                setState(() {
                  if(SgreenColor == "0"){
                    setState(() {
                      SgreenColor = "1";
                    });
                  }else {
                    setState(() {
                      SgreenColor = "0";
                    });
                  }
                });
              },child: Container(width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  color: SgreenColor == "0"? Colors.transparent: Colors.green,
                  border: Border.all(
                    width: 1,
                    color: SgreenColor == "0"? Colors.green: Colors.green,
                  ),
                ),
                child: Center(child: Text("Green",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 09,
                ),),),),),

              InkWell(onTap: (){
                setState(() {
                  if(SblackColor == "0"){
                    setState(() {
                      SblackColor = "1";
                    });
                  }else {
                    setState(() {
                      SblackColor = "0";
                    });
                  }
                });
              },child: Container(width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  color: SblackColor == "0"? Colors.transparent: Colors.black,
                  border: Border.all(
                    width: 1,
                    color: SblackColor == "0"? Colors.black: Colors.black,
                  ),
                ),
                child: Center(child: Text("Black",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 09,
                ),),),),),

              InkWell(onTap: (){
                setState(() {
                  if(SwhiteColor == "0"){
                    setState(() {
                      SwhiteColor = "1";
                    });
                  }else {
                    setState(() {
                      SwhiteColor = "0";
                    });
                  }
                });
              },child: Container(width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  color: SwhiteColor == "0"? Colors.transparent: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: SwhiteColor == "0"? Colors.white: Colors.white,
                  ),
                ),
                child: Center(child: Text("White",style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 09,
                  color: SwhiteColor == "0"? Colors.white: Colors.black,
                ),),),),),


              InkWell(onTap: (){
                setState(() {
                  if(SyallowColor == "0"){
                    setState(() {
                      SyallowColor = "1";
                    });
                  }else {
                    setState(() {
                      SyallowColor = "0";
                    });
                  }
                });
              },child: Container(width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  color: SyallowColor == "0"? Colors.transparent: Colors.yellow,
                  border: Border.all(
                    width: 1,
                    color: SyallowColor == "0"? Colors.yellow: Colors.yellow,
                  ),
                ),
                child: Center(child: Text("Yellow",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 09,
                ),),),),),

              InkWell(onTap: (){
                setState(() {
                  if(SpinkColor == "0"){
                    setState(() {
                      SpinkColor = "1";
                    });
                  }else {
                    setState(() {
                      SpinkColor = "0";
                    });
                  }
                });
              },child: Container(width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  color: SpinkColor == "0"? Colors.transparent: Colors.pink,
                  border: Border.all(
                    width: 1,
                    color: SpinkColor == "0"? Colors.pink: Colors.pink,
                  ),
                ),
                child: Center(child: Text("Pink",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 09,
                ),),),),),
              InkWell(onTap: (){
                setState(() {
                  if(SredColor == "0"){
                    setState(() {
                      SredColor = "1";
                    });
                  }else {
                    setState(() {
                      SredColor = "0";
                    });
                  }
                });
              },child: Container(width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  color: SredColor == "0"? Colors.transparent: Colors.red,
                  border: Border.all(
                    width: 1,
                    color: SredColor == "0"? Colors.red: Colors.red,
                  ),
                ),
                child: Center(child: Text("Red",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 09,
                ),),),),),
            ],),),*/

          /*Visibility(visible: SblackColor == "1"?true:false,
          child: ListView(
            shrinkWrap: true,
            controller: _controller,
            children: [
              SizedBox(height: 20,),
              Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Upload image for Black Color",style: Theme.of(context).textTheme.headline2,),),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(
                  onTap:(){
                    _onButtonPressed("black1");

                  },
                  child: Container(width: 150,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrlBlack1!),fit: BoxFit.fill)),child: checkprogressBlack1 == true? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())):Container(),),
                ),

                InkWell(
                  onTap: (){
                    _onButtonPressed("black2");
                  },
                  child: Container(width: 150,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrlBlack2!),fit: BoxFit.fill)),child: checkprogressBlack2 == true? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())):Container(),),
                )
              ],),
              SizedBox(height: 20,),
              Divider(color: Colors.grey,)
            ],),),



          Visibility(visible: SgreenColor == "1"?true:false,
            child: ListView(
              shrinkWrap: true,
              controller: _controller,
              children: [
                SizedBox(height: 20,),
                Container(margin:const EdgeInsets.symmetric(horizontal: 20),child: Text("Upload image for Green Color",style: Theme.of(context).textTheme.headline2,),),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
                        _onButtonPressed("green1");

                      },
                      child: Container(width: 150,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrlGreen1!),fit: BoxFit.fill)),child: checkprogressGreen1 == true? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())):Container(),),
                    ),

                    InkWell(
                      onTap: (){
                        _onButtonPressed("green2");
                      },
                      child: Container(width: 150,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrlGreen2!),fit: BoxFit.fill)),child: checkprogressGreen2 == true? Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator())):Container(),),
                    )
                  ],),
                SizedBox(height: 20,),
                Divider(color: Colors.grey,)
              ],),),*/

          Visibility(
            visible: true,
            child: ListView(
              shrinkWrap: true,
              controller: _controller,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Upload image for Product",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap:(){
                        _onButtonPressed("white1");
                      },
                      child:Stack(children: [
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration:imageUrlWhite1 == "assets/images/upload.png" ? BoxDecoration(
                            image: DecorationImage(
                              image:AssetImage("assets/images/upload.png"),),
                          ):BoxDecoration(
                            image: DecorationImage(
                              image:NetworkImage(imageUrlWhite1!),
                              fit: BoxFit.cover,),
                          ),
                          
                        ),
                        checkprogressWhite1 == true ? SizedBox(width: 150,
                            height: 100,child: Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator()))):Container(),
                        widget.update == true? InkWell(onTap:(){
                          setState(() {

                            imageUrlWhite1 ="assets/images/upload.png";
                          });
                        },child: Align(alignment:Alignment.topRight,child: Container(padding: const EdgeInsets.all(10.0),child: Icon(Icons.delete,color: Colors.blue,),))):Container(),
                      ],),
                    ),
                    InkWell(
                      onTap:(){
                        _onButtonPressed("white2");
                      },
                      child: Stack(children: [
                        Container(
                          width: 150,
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration:imageUrlwhite2 == "assets/images/upload.png" ? BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/upload.png"),
                            ),
                          ): BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrlwhite2!),
                              fit: BoxFit.cover,),
                          ),
                        ),
                        checkprogressWhite2 == true ? SizedBox(width: 150,
                            height: 100,child: Center(child: SizedBox(width: 30,height: 30,child: CircularProgressIndicator()))):Container(),
                        widget.update == true? InkWell(onTap:(){
                          setState(() {

                            imageUrlwhite2 ="assets/images/upload.png";
                          });
                        },child: Container(padding: const EdgeInsets.all(10),alignment: Alignment.topRight,width:30,height: 30,child: Icon(Icons.delete,color: Colors.blue,),)):Container(),
                      ],),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),

          SizedBox(
            height: 50,
          ),
          Container(
            height: 64.0,
            margin: const EdgeInsets.only(top: 50, bottom: 10),
            child: BottomBar(
              check: false,
              text: widget.update == true?"Update Product":"Create Product",
              onTap: () {
                if (_titleController.text.length == 0) {
                  showToast("Please enter you dress title...");
                } else if (_detailsController.text.length == 0) {
                  showToast("Please enter your dress details..");
                } else if (_infoController.text.length == 0) {
                  showToast("Please enter you dress info...");
                } else if (sizeXL == "0" &&
                    sizeL == "0" &&
                    sizeS == "0" &&
                    sizeM == "0") {
                  showToast("Please select size ..");
                } else if (_sizeMPriceController.text.length == 0 &&
                    sizeM == "1") {
                  showToast("Please enter Medium size price..");
                } else if (_sizeMMRPController.text.length == 0 &&
                    sizeM == "1") {
                  showToast("Please enter Medium size MRP..");
                } else
                /*if (SblackColor == "0" && SgreenColor == "0" &&  SpinkColor == "0" &&  SredColor == "0" &&  SwhiteColor == "0" &&  SyallowColor == "0" && sizeS == "1") {
                  showToast("Please select small color..");
                }else */
                if (_sizeLPriceController.text.length == 0 && sizeL == "1") {
                  showToast("Please enter Large size price..");
                } else if (_sizeLMRPController.text.length == 0 &&
                    sizeL == "1") {
                  showToast("Please enter Large size MRP..");
                } else if (_sizeSMRPController.text.length == 0 &&
                    sizeS == "1") {
                  showToast("Please enter Small size MRP..");
                } else if (_sizeSPriceController.text.length == 0 &&
                    sizeS == "1") {
                  showToast("Please enter Small size Price..");
                }
                /* else if (int.parse(_sizeSMRPController.text.toString()) <= int.parse(_sizeSPriceController.text.toString()) && sizeS == "1") {
                  showToast("Note: Small Size Dress Price is Greater than MRP please change ..");
                }  else if (int.parse(_sizeMMRPController.text.toString()) <= int.parse(_sizeMPriceController.text.toString()) && sizeM == "1") {
                  showToast("Note: Medius Size Dress Price is Greater than MRP please change ..");
                }  else if (int.parse(_sizeLMRPController.text.toString()) <= int.parse(_sizeLPriceController.text.toString()) && sizeL == "1") {
                  showToast("Note: Large Size Dress Price is Greater than MRP please change ..");
                }  else if (int.parse(_sizeXLMRPController.text.toString()) <= int.parse(_sizeXLPriceController.text.toString()) && sizeXL == "1") {
                  showToast("Note: Extra Large Size Dress Price is Greater than MRP please change ..");
                }*/
                else if (_sizeXLMRPController.text.length == 0 &&
                    sizeXL == "1") {
                  showToast("Please enter Extra Large size MRP..");
                } else if (_sizeXLPriceController.text.length == 0 &&
                    sizeXL == "1") {
                  showToast("Please enter Extra Large size Price..");
                } else {
                  setState(() {
                    _progress = true;
                  });
    if(widget.update == true){
      sendUpdateData();
    }else {
      sendData();
    }

                  // doAddition();
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
