import 'dart:async';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/screen/change_add.dart';
import 'package:amin/screen/change_pass.dart';
import 'package:amin/screen/home.dart';
import 'package:amin/screen/home_order_account.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPScreen extends StatefulWidget {
  String mobile;
  String country_code;
  String type;
  OTPScreen({Key? key,required this.mobile,required this.country_code,required this.type}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _controller = TextEditingController();
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
  int _counter = 60;
  late Timer _timer;

  _startTimer() {
    //shows timer
    _counter = 60; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();

      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
    sendOTPNew();

  }
  sendOTPNew()async{
    getVerifiID();
    await Future.delayed(Duration(seconds: 5));
    verifyPhone();
    cprint("lucky check prient =   "+widget.type.toString()+", mobile = "+widget.mobile);
  }
  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
  bool _progress = false;


  late String verificationId = "";
  late String message = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  late PhoneCodeSent smsOTPSent;

  getVerifiID()async{
    smsOTPSent = (String verId, int? resentToken){
      this.verificationId = verId;
      cprint('message =2 verificationId = '+verId);
    };
  }
  Future<void> verifyPhone()async{


    cprint('message =1 verificationId = '+verificationId);
    cprint('message = phoneNumber = '+"+91"+widget.mobile);
    await _auth.verifyPhoneNumber(phoneNumber: widget.country_code+widget.mobile, verificationCompleted: (AuthCredential phoneAuthCredential){
      setState(() {
        message = "Verification Complete = "+phoneAuthCredential.toString();
        cprint('message = '+message);
      });
    }, verificationFailed: (FirebaseAuthException exceptiion){
      setState(() {
        message = exceptiion.message!;
        cprint('message failed = '+message);
      });
    }, codeSent: smsOTPSent, codeAutoRetrievalTimeout: (String verid){
      this.verificationId = verid;
    });
  }
  signIn(String smsOTP)async{
    try{
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsOTP);

      final User? user = (await _auth.signInWithCredential(credential)).user;
      if(user!.uid == _auth.currentUser!.uid){
        setState(() {
          message = "OTP Verification Successfully";
          cprint('message = '+message);
        });
        if(widget.type == "edit"){
          addUser();
        }else if(widget.type == "signup"){
          addUser();
        }else if(widget.type == "changeAdd"){
          changeAdd();
        }else{
          forget();
        }
      }else {
        setState(() {
          message = "OTP not Verification";
          _progress = false;
          cprint('message = '+message);
        });

      }
    }catch (e){
      setState(() {
        message = e.toString();
        _progress = false;
        showToast(message);
        cprint('message = '+message);
      });
    }
  }

  forget()async{
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('mobile', isEqualTo: widget.mobile)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),


            nextScreenReplace(context, ChangePassScreen(mobile: widget.mobile, doc: value.docs[0].reference.id)),



        }
      else
        {
          showToast("User details not exist")
        }
    });
  }

  changeAdd()async{
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('mobile', isEqualTo: widget.mobile)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),


          nextScreenReplace(context, ChangeAddressScreen(mobile: widget.mobile, doc: value.docs[0].reference.id)),



        }
      else
        {
          showToast("User details not exist")
        }
    });
  }

  CollectionReference userss = FirebaseFirestore.instance.collection('users');
  addUser() async {
    final pref = getIt<SharedPreferenceHelper>();
    String? names = await pref.getUserName();
    String? pass = await pref.getUserPass();
    String? email = await pref.getUserEmail();
    String? add = await pref.getUserAdd();
    String? country_code = await pref.getUserCountryCodeType();

    String? city = await pref.getUserCity();
    String? state = await pref.getStateName();

    String? pincode = await pref.getUserPinCode();
    String? dob = await pref.getUserDOB();
    String? gender = await pref.getUserGender();

    String? country = await pref.getUserCountry();
    String? mobile = await pref.getUserMobile();

    String? userid = await pref.getUserId();

    String? image = await pref.getUserImage();

    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('mobile', isEqualTo: mobile)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),
          cprint("lucky check reference.id =  "+value.docs[0].reference.id),
          cprint("lucky check pincode =  "+pincode.toString()),
          cprint("lucky check dob =  "+dob.toString()),
    FirebaseFirestore.instance.collection('users').doc(value.docs[0].reference.id).update({
    'email': email, // John Doe
    'mobile': mobile,
    'pass': pass,
    'name': names,
    'address': add,
      'country_code':country_code,
    'id': userid,
    'state':state,
    'city':city,
    'country':country,
    'pincode':pincode,
    'dob':dob,
    'gender':gender,
    'image':image,
    'type': "user",
    'wallet': "0",
    'blocked': "0",
    'maintenance': "0",
    }),

            showToast("User Details Update sucssfully..."),
    cprint("lucky check prient =  User Details Update sucssfully... "),
          login()

        }
      else
        {
          userss
              .add({
            'email': email, // John Doe
            'mobile': mobile,
            'pass': pass,
            'name': names,
            'address': add,
            'country_code':country_code,
            'id': userid,
            'state':state,
            'city':city,
            'country':country,
            'pincode':pincode,
            'dob':dob,
            'gender':gender,
            'image':image,
            'type': "user",
            'wallet': "0",
            'blocked': "0",
            'maintenance': "0",
          })
              .then((value) => {
            cprint('data insert'),
            setState(() {
              _progress = false;
            }),
            showToast("User create sucssfully..."),

            login(),

          })
          // ignore: invalid_return_type_for_catch_error
              .catchError(
                  (error) => cprint('Failed to add user: error'))
        }
    });
  }
  login()async{
    final pref = getIt<SharedPreferenceHelper>();
    bool? userid = await pref.setLogin(true);
    bool? user = await pref.saveUserType("user");
    if(userid){
      nextScreenReplace(context, HomeOrderAccount());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          SizedBox(height: 50,),
          Container(padding:EdgeInsets.symmetric(horizontal: 20,vertical: 10),alignment: Alignment.centerLeft,child: Text('A7',style: Theme.of(context).textTheme.headline1).tr()),
          Container(padding:EdgeInsets.symmetric(horizontal: 20),margin: const EdgeInsets.only(bottom: 20),alignment: Alignment.centerLeft,child: Text('Q8',style:
          Theme.of(context).textTheme.subtitle1).tr()),
          /*Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "enter verification code we've sent in "+widget.mobile+".",
              style: Theme.of(context)
                  .textTheme
                  .headline1,
            ).tr(),
          ),*/
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 20.0),
            child: EntryField(
              controller: _controller,
              readOnly: false,
              label: 'ENTER VERIFICATION CODE',
              maxLength: 6,
              keyboardType: TextInputType.number, hint: 'ENTER VERIFICATION CODE',       image: null,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'A8',
                  style: Theme.of(context).textTheme.subtitle1,
                ).tr(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  '$_counter sec',
                  style: TextStyle(color: kMainColor, fontSize: 10,letterSpacing: 0.5, fontWeight: FontWeight.w600,)
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Row(children: [
              Expanded(
                flex: 1,
                child: BottomBar(
                    check: true,
                    text: "resend",
                    onTap: () {
                      setState(() {
                        _progress = true;
                      });
                      if(_controller.text.length == 0){
                        showToast(_controller.text);
                      }else {


                        /*signIn(_controller.text.toString());*/
                        _startTimer();
                        sendOTPNew();
                      }
                      /* ClickBottom();
                  ClickBottom();
                  ClickBottom();*/

//                  _verificationBloc.add(SubmittedEvent(
//                      _controller.text, widget.name, widget.email));
                    }),
              ),
              Expanded(
                flex: 1,
                child: BottomBar(
                  check: false,
                    text: "Continue",
                    onTap: () {

                      if(_controller.text.length == 0){
                        showToast("Please enter 6 digit OTP.");
                        setState(() {
                          _progress = false;
                        });
                      }else if(_controller.text.length < 6){
                        showToast("Please enter 6 digit OTP.");
                        setState(() {
                          _progress = false;
                        });
                      }else {
                        setState(() {
                          _progress = true;
                        });

                        signIn(_controller.text.toString());
                      }
                      /* ClickBottom();
                  ClickBottom();
                  ClickBottom();*/

//                  _verificationBloc.add(SubmittedEvent(
//                      _controller.text, widget.name, widget.email));
                    }),
              ),
            ],),
          ),
          Spacer(),
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


        ],
      ),
    );
  }
}
