import 'dart:io';
import 'package:amin/screen/forget_pass.dart';
import 'package:country_picker/country_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/statemodel.dart';
import 'package:amin/screen/date_of_bith.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amin/screen/gender.dart';
import 'package:amin/screen/other_details.dart';
import 'package:amin/screen/otp.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  bool? type;
 EditProfileScreen({Key? key,required this.type}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? mobile = "0000000000";
  String? pass = "0000000000";
  String? email = "xyz@gmail.com";
  String? dob = "dd-mm-yyyy";
  String? address = "address";
  String? city = "city";
  String? state = "state";
  String? countryNew = "india";
  String? pincode = "000000";
  String? name = "A16";
  String? gender = 'Q13';
  String? country_code_new = "";
  String? imageUrl;

  getdata()async{
    final pref = getIt<SharedPreferenceHelper>();
    name = await pref.getUserName();
    mobile = await pref.getUserMobile();
    country_code_new = await pref.getUserCountryCodeType();
    pass = await pref.getUserPass();
    address = await pref.getUserAdd();
    city = await pref.getUserCity();
    state = await pref.getStateName();
    countryNew = await pref.getUserCountry();
    pincode = await pref.getUserPinCode();
    cprint("lucky check pincode =   "+pincode.toString());
    gender = await pref.getUserGender();
    dob = await pref.getUserDOB();
    cprint("lucky check dob =   "+dob.toString());
    email = await pref.getUserEmail();
    imageUrl = await pref.getUserImage();
    setState(() {
      country_code_new;
      mobile;
      pass;
      state;
      city;
      countryNew;
      pincode;
      gender;
      email;
      imageUrl;
    });
  }
  final _firebaseStorage = FirebaseStorage.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    Langitems.addAll(StateListDataModel.stateitems);

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
  saveState(String title, int id) async{
    final pref = getIt<SharedPreferenceHelper>();
    state = title;
    bool? add = await pref.saveStateName(title);
    setState(() {
      state;
    });
    Navigator.pop(context);
  }
  _navigateAndDisplaySelection(BuildContext context,String title,String hint,int? num) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen. Your Address (House No/Street/Area)
    final pref = getIt<SharedPreferenceHelper>();
    final result;
    if(title == "dob"){
      result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DateOfBirth()),
      );
    }else if(title == "gender"){
      result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GenderScreen()),
      );
    }else{
      result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtherDetailsScreen(title: title,hint: hint,Lengthnumber: num,)),
      );
    }

    if(title == "Your name"){

      setState(() {
        if(result.toString() != "null"){
          name = result.toString();
        }

      });
      bool? add = await pref.saveUserName(name!);

    }else if(title == "Your email"){

      setState(() {
        if(result.toString() != "null"){
          email = result.toString();
        }
      });
      bool? add = await pref.saveUserEmail(email!);
    }else if(title == "Your Address (House No/Street/Area) "){

      setState(() {
        if(result.toString() != "null"){
          address = result.toString();
        }
      });
      bool? add = await pref.saveUserAdd(address!);
    }else if(title == "Your Pin Code"){

      setState(() {
        if(result.toString() != "null"){
          pincode = result.toString();
        }
      });
      bool? add = await pref.saveUserPinCode(pincode!);
    }else if(title == "Your City"){

      setState(() {
        if(result.toString() != "null"){
          city = result.toString();
        }
      });
      bool? add = await pref.saveUserCity(city!);
    }else if(title == "dob"){

      setState(() {
        if(result.toString() != "null"){
          dob = result.toString();
        }
      });
      bool? add = await pref.saveUserDOB(dob!);
    }else if(title == "gender"){

      setState(() {
        if(result.toString() != "null"){
          gender = result.toString();
        }
      });
      bool? add = await pref.saveUserGender(gender!);
    }else if(title == "Your Mobile number"){

      setState(() {
        if(result.toString() != "null"){
          mobile = result.toString();
        }
      });
      bool? add = await pref.saveUserMobile(mobile!);
    }
    cprint('User gender =  ' +gender.toString());

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
  }

  List<StateListItem> Langitems = [];
  // state popup
  _statePOPUP(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 400,
          child: Column(
            children: [
              Container(
                height: 50,
                color: Color(0xfff3f3f3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select State (राज्य चुनें)",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:  Icon(Icons.close,color: Colors.black,)
                    ),

                  ],),
              ),
              Container(height: 350,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Langitems.length,
                    itemBuilder: (context, index){
                      StateListItem itemsnew = Langitems[index];
                      return Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: (){


                            saveState(itemsnew.title,itemsnew.id);

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(itemsnew.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white,fontWeight:FontWeight.normal))

                            ],),
                        ),);
                    }),)
            ],),
        ),
      );
    });
  }

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
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? photo;
  XFile? _image;
  bool isDefault = false;

  bool checkprogress = false;
  bool checkimage = true;
  File? imageFile;
  String imgpath = "";
  pickimage()async {
    final pref = getIt<SharedPreferenceHelper>();
    photo = await _picker.pickImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
    await Permission.photos.request();
    if(photo!.path.length > 0){
      setState(() {
        _image = photo;
        uploadFile(_image);
        checkprogress = true;
        print("Lucky camera path =  " + _image!.path.toString());
        print("Lucky camera name =  " + _image!.name.toString());
        isDefault = true;
        imgpath = _image!.path;
        print("Lucky camera name =  " + _image!.name.toString());
        checkimage = false;
      });

      var file = File(imgpath);
      var snapshot = await _firebaseStorage.ref()
          .child('images/'+_image!.name)
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
        print("Lucky pickimage imageUrl=  " + imageUrl.toString());
      });
      await pref.saveUserImage(imageUrl!);
    }
  }


  _cameraPermission() async {
    final pref = getIt<SharedPreferenceHelper>();
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
          isDefault = true;
          imgpath = _image!.path;
          print("Lucky camera name =  " + _image!.name.toString());
          checkimage = false;
        });
        var file = File(imgpath);

        var snapshot = await _firebaseStorage.ref()
            .child('images/'+_image!.name)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        await pref.saveUserImage(imageUrl!);
        print("Lucky camera pickimage imageUrl=  " + imageUrl.toString());
      }
    }else {
      showToast('Permission not granted. Try Again with permission access');
    }

//

  }
  UploadTask? uploadFiled(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print("Lucky camera pickimage error =  " + e.toString());
      return null;
    }
  }
  UploadTask? task;
  Future uploadFiles(File? file) async {


    final fileName = _image!.name;
    final destination = 'files/$fileName';

    task = uploadFiled(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }
  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/'+_image!.name);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    print("Lucky camera file.path =  " + file.path.toString());
    var files = File(file.path);
      uploadTask = ref.putFile(files, metadata);



    return Future.value(uploadTask);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Profile"),
        centerTitle: true,
  /*      actions: [
    FlatButton.icon(onPressed: (){
      if(state == "Select state" || state!.length == 0){
        showToast("Please enter your state");
      }else
      if(name == "Your name" || name == "null"){
        showToast("Please enter your name");
      }else if(email == "xyz@gmail.com" || email == "null"){
        showToast("Please enter your email");
      }else if(address== "House No/Street/Area"  || address == "null"){
        showToast("please enter your address");
      }else if(city== "Select City"  || city == "null"){
        showToast("please select your city");
      }else if(state== "Select state"  || state == "null"){
        showToast("please select your state");
      }else if(pincode== "000000"  || pincode == "null"){
        showToast("please enter your pincode");
      }else if(dob== "dd-mm-yyyy"  || dob == "null"){
        showToast("please enter your Date of birth");
      }else {
        nextScreen(context, OTPScreen(mobile: mobile!,type:widget.type! == false?"signup":"edit"));
      }
    }, icon: new Icon(Icons.edit,color: Color(0xff7b61ff)), label: Text("Edit",style: TextStyle(color: Color(0xff7b61ff)),)),


        ],*/
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(children: [
          ListView(shrinkWrap:true,children: [
            SizedBox(height: 20,),
            Row(children: [
              SizedBox(width: 5,),
              InkWell(
                onTap: (){
                  _onButtonPressed();
                },
                child: Container(width: 50,height: 50,

                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.grey,
                          spreadRadius: 3,
                          offset: Offset(
                            1,
                            1,
                          ),
                        ),
                      ],
                      image: DecorationImage(image: NetworkImage(imageUrl!),fit: BoxFit.cover)
                  ),),
              ),
              Container(margin:const EdgeInsets.symmetric(horizontal: 10),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                Text(name!,style: TextStyle(fontWeight: FontWeight.bold),),
                Text(mobile!),
              ],),)
            ],),
            SizedBox(height: 10,),

            ListTile(
              onTap: (){
                // Nmae
                //  _navigateAndDisplaySelection(context,"Your name","Your name",null);
              },
              title: Text('Q10',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(name!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),
            ListTile(
              onTap: (){
                // Mobile No
                _navigateAndDisplaySelection(context,"Your Mobile number","Your Mobile number",10);
              },
              title: Text('Q11',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(mobile!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),
            ListTile(
              onTap: (){
                // Email
                _navigateAndDisplaySelection(context,"Your email","abc@gmail.com",null);
              },
              title: Text('Q12',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(email!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),

            ListTile(
              onTap: (){
                // Address
                _navigateAndDisplaySelection(context,"Your Address (House No/Street/Area) ","Your Address (House No/Street/Area) ",null);
              },
              title: Text('Q14',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(address!.length>15?address!.substring(0, 14)+"...":address!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),

            ListTile(
              onTap: (){
                // City
                _navigateAndDisplaySelection(context,"Your City","Your City",null);
              },
              title: Text('A14',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(city!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),

            ListTile(
              onTap: (){
                // State
                _statePOPUP();
              },
              title: Text('Q15',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(state!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),

            ListTile(
              onTap: (){
                // Country Selection
                showCountryPicker(
                  context: context,
                  showPhoneCode: true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    setState(() {
                      countryNew = country.displayNameNoCountryCode.toString();
                      country_code_new = country.phoneCode.toString();

                    });
                    print('Select country: ${country.displayName}');
                  },
                );
              },
              title: Text('A15',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(countryNew!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),

            ListTile(
              onTap: (){
                // Pin Code
                _navigateAndDisplaySelection(context,"Your Pin Code","Your Pin Code",6);
              },
              title: Text('Q16',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(pincode!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),
            Divider(height: 1,color: Colors.grey,),
            ListTile(
              onTap: (){
                // DOB
                _navigateAndDisplaySelection(context,"dob","dob",null);
              },
              title: Text('A10',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(dob!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),

            Divider(height: 1,color: Colors.grey,),
            ListTile(
              onTap: (){
                // Gender
                _navigateAndDisplaySelection(context,"gender","gender",null);
              },
              title: Text('A11',style:
              Theme.of(context).textTheme.subtitle1).tr(),
              trailing: Text(gender!,style:
              Theme.of(context).textTheme.headline2).tr(),
            ),

            Visibility( visible: widget.type!,child: Divider(height: 1,color: Colors.grey,)),
            Visibility(
              visible: widget.type!,
              child: ListTile(
                onTap: (){
                  // Password
                  nextScreen(context, ForgetPassScreen(type: "forPass",title: "reset Password",));
                },
                title: Text('A12',style:
                Theme.of(context).textTheme.subtitle1).tr(),
                trailing: Text('change Password',style:
                Theme.of(context).textTheme.headline3).tr(),
              ),
            ),

            SizedBox(height: 190,)
          ],),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Color(0xff6953d9),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: InkWell(
                        onTap: () {
                          if(state == "Select state" || state!.length == 0){
                            showToast("Please enter your state");
                          }else
                          if(name == "Your name" || name == "null"){
                            showToast("Please enter your name");
                          }else if(email == "xyz@gmail.com" || email == "null"){
                            showToast("Please enter your email");
                          }else if(address== "House No/Street/Area"  || address == "null"){
                            showToast("please enter your address");
                          }else if(city== "Select City"  || city == "null"|| city!.length ==0){
                            showToast("please select your city");
                          }else if(state== "Select state"  || state == "null" || state!.length ==0){
                            showToast("please select your state");
                          }else if(pincode== "000000"  || pincode == "null"){
                            showToast("please enter your pincode");
                          }else if(dob== "dd-mm-yyyy"  || dob == "null"){
                            showToast("please enter your Date of birth");
                          }else {
                            nextScreen(context, OTPScreen(country_code:country_code_new!,mobile: mobile!,type:widget.type! == false?"signup":"edit"));
                          }
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xff6953d9),
                              /*borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))*/),
                          child: Center(
                            child: Text(
                              "Update Info",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],),

      ),
    );
  }


}
