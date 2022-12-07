import 'dart:math';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/screen/edit_profile.dart';
import 'package:amin/screen/login.dart';
import 'package:amin/screen/otp.dart';
import 'package:amin/screen/webview.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _adreessController = TextEditingController();
/*  final TextEditingController _confirmpassController = TextEditingController();*/
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String ButtonText = "Continue";
  bool check_terms = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _passController.dispose();
    _adreessController.dispose();/*
    _confirmpassController.dispose();*/
    _emailController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  bool _progress = false;

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



  addUser(String MobileNo) async {

    final pref = getIt<SharedPreferenceHelper>();
   /* if(mobile_code.trim() == "+91"){
      print("check mobile data 777 = "+mobile_code+_mobileController.text);
      bool? mobile = await pref.saveUserMobile(mobile_code+_mobileController.text);
    }else {*/
      print("check mobile data 776 = "+_mobileController.text+"  countru code  =  "+mobile_code);
      bool? mobile = await pref.saveUserMobile(_mobileController.text);
    /*}*/

    bool? pass = await pref.saveUserPass(_passController.text);

    bool? countryCode = await pref.saveUserCountryCodeType(mobile_code);

    bool? name = await pref.saveUserName(_nameController.text);
    bool? country = await pref.saveUserCountry(Your_Country);

    print("check mobile data 775 = "+MobileNo);



    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String userids = "Amina" + randomNumber.toString() + _nameController.text.replaceAll(' ', '').toUpperCase();
    bool? userid = await pref.saveUserId(userids);


    var result = await FirebaseFirestore.instance

        .collection('users')
        .where('mobile', isEqualTo: MobileNo)
        .get()
        .then((value) => {
          print("check user exist or not  = "+MobileNo.toString()+", size = "+value.size.toString()),
              if (value.size >= 1)
                {
                  setState(() {
                    _progress = false;
                  }),
                  Fluttertoast.showToast(
                      msg: "User already exist...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0)
                }
              else
                {
        setState(() {
      _progress = false;
    }),
        /*nextScreen(context, EditProfileScreen(type: false,)),*/
    nextScreen(context, OTPScreen(country_code:mobile_code,mobile: _mobileController.text,type:"signup")),
                }
            });
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /*void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }*/
  bool value = false;
  String Your_Country = "";
  String mobile_code = "+91";
  @override
  Widget build(BuildContext context) {
    const btncolor = const Color(0xff7AC920);
    const backgroundcolor = const Color(0xffFFFFFF);
    const black = const Color(0xff000000);
    const color = const Color(0xffFFFFFF);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(margin: const EdgeInsets.only(top:10),child: Image.asset(
                "assets/images/icons/iconappbar.png", //delivoo logo
                height: 200.0,
                width: 200,
              ),),
              Container(padding:EdgeInsets.symmetric(horizontal: 10,vertical: 10),alignment: Alignment.centerLeft,child: Text('Q3',style: Theme.of(context).textTheme.headline1).tr()),
              Container(padding:EdgeInsets.symmetric(horizontal: 10),margin: const EdgeInsets.only(bottom: 20),alignment: Alignment.centerLeft,child: Text('A3',style:
              Theme.of(context).textTheme.subtitle1).tr()),


              EntryField(
                controller: _nameController,
                label: 'Your Name',
                image: 'assets/images/icons/ic_phone.png',
                keyboardType: TextInputType.name,
                maxLength: null,
                readOnly: false,
                hint: 'Your Name',
              ),

              Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child:InkWell(
                          onTap: (){
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true, // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  mobile_code = "+"+country.phoneCode;

                                });
                                print('Select country: ${country.displayName}');
                              },
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 58,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 15,top: 15,bottom: 15),

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Color(0xff6c6b6b),width: 1)),
                            child:

                            Row(
                                children: [
                                  Container(padding: const EdgeInsets.only(left: 15,top: 15,bottom: 15),
                                      child: Image.asset("assets/images/icons/ic_phone.png",color: kMainColor,)),
                                  SizedBox(width: 10,),
                                  InkWell(onTap: (){
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode: true, // optional. Shows phone code before the country name.
                                      onSelect: (Country country) {
                                        setState(() {
                                          mobile_code = "+"+country.phoneCode;

                                        });
                                        print('Select country: ${country.displayName}');
                                      },
                                    );
                                  },child: Text(mobile_code,style: TextStyle(color: kMainColor))),
                                ]
                            ),

                          ),
                        )
                    ),
                    Expanded(
                        flex: 7,
                        child: Container(
                            width: double.infinity,
                            height: 60,
                            child: EntryField(
                                controller: _mobileController,
                                label: 'Mobile Number',
                                keyboardType: TextInputType.visiblePassword,
                                readOnly: false,
                                hint: 'Mobile Number')
                        )
                    )
                  ]
              ),
              SizedBox(height: 10,),
              EntryField(
                  controller: _passController,
                  label: 'Create Password',
                  image: 'assets/images/icons/pass.png',
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: null,
                  readOnly: false,
                  hint: 'Create Password'),
              SizedBox(height: 10,),


             /* EntryField(
                  controller: _confirmpassController,
                  label: 'Confirm Password',
                  image: 'assets/images/icons/pass.png',
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 8,
                  readOnly: false,
                  hint: 'Confirm Password'),
              EntryField(
                  controller: _adreessController,
                  label: 'Address',
                  image: 'assets/images/icons/homeicon.png',
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 80,
                  readOnly: false,
                  hint: 'Address'),*/

              /*EntryField(
                  controller: _emailController,
                  label: 'Email',
                  image: 'assets/images/icons/ic_mail.png',
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: null,
                  readOnly: false,
                  hint: 'Address'),*/
              SizedBox(height: 10),
              Row(
                children: <Widget>[

                   //SizedBox
 //SizedBox
                  /** Checkbox Widget **/
                  Checkbox(
                    value: this.value,
                    checkColor: kMainColor,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                        check_terms = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(children: [
                    Text('I agree with the ',style: Theme.of(context).textTheme.subtitle1),
                    InkWell(
                      onTap: (){
                        nextScreen(context, WebViewScreen(title: 'terms and conditions',url: "https://www.aminaboutique.in/app-terms-and-condition",));
                      },
                      child: Text( 'Terms of Service ', style: TextStyle(
                          color: kMainColor,
                          fontSize: 10, fontFamily: "Nexa"
                      ),),
                    ),

                    Text('& ',style: Theme.of(context).textTheme.subtitle1),
                    InkWell(
                      onTap: (){
                        nextScreen(context, WebViewScreen(title: 'privacy policy',url: "https://www.aminaboutique.in/app-privacy-policy",));
                      },
                      child: Text('privacy policy.', style: TextStyle(
                          color: kMainColor,
                          fontSize: 10, fontFamily: "Nexa"
                      ),),
                    ),
                  ],),//Te
                ], //<Widget>[]
              ),

              Container(
                height: 64.0,
                margin: const EdgeInsets.only(top: 50,bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      child: _progress
                          ? new LinearProgressIndicator(
                        backgroundColor: Colors.cyanAccent,
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(
                            Colors.red),
                      )
                          : new Container(),
                    ),
                    BottomBar(
                      check: false,
                      text: ButtonText,
                      onTap: () {
                        cprint('User mobile =  ' +
                            _mobileController.text.length.toString());
                        cprint('User pass =  ' +
                            _passController.text.length.toString());
                        if(_nameController.text.length ==0){
                          showToast("Please enter your Name..");
                        }else
                        if (_mobileController.text.length < 10) {
                          showToast("Please enter you mobile number...");

                        } else
                        if (_mobileController.text.length == 0) {
                          showToast("Please enter you mobile number...");

                        } else if (_passController.text.length < 8) {
                          showToast("Please enter at least 8 characters password..");

                        }else if (_passController.text.length == 0) {
                          showToast("Please enter your password..");

                        }else if (!check_terms) {
                          showToast("Please enter click Terms of Service & privacy policy.");

                        }  /*else if (check_terms != ture) {
                          showToast("Please enter your right password..");

                        }   else if (_adreessController.text.length ==0) {
                          showToast("Please enter your address..");

                        }   else if (_emailController.text.length ==0) {
                          showToast("Please enter your email address..");

                        } */ else {
                          setState(() {
                            _progress = true;
                          });
                          addUser(_mobileController.text);

                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                //Center Row contents vertically,
                children: <Widget>[
                  Text(
                    "A5",
                    style: Theme.of(context).textTheme.subtitle1,
                  ).tr(),
                  InkWell(
                    onTap: () {

                      nextScreen(context, LoginScreen());
                    },
                    child: Text(
                      "Q6",
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: 15, fontFamily: "Nexa"
                      ),
                    ).tr(),
                  )
                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
