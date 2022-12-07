import 'dart:io';

import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/admin/admin_home.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/screen/forget_pass.dart';
import 'package:amin/screen/home.dart';
import 'package:amin/screen/home_order_account.dart';
import 'package:amin/screen/signup.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/*import 'package:toast/toast.dart';*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String ButtonText = "Login";

  @override
  void dispose() {
    _mobileController.dispose();
    _passController.dispose();

    super.dispose();
  }

  bool _progress = false;

  /*void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }*/

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'are you sure',
          style: Theme.of(context).textTheme.headline1,
        ).tr(),
        content: new Text('do you want to exit the App',
                style: Theme.of(context).textTheme.bodyText2)
            .tr(),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () {
              /*Navigator.of(context).pop(true);*/
              exit(0);
            },
            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
          ),
        ],
      ),
    );
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

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  savedata(
      String mobile,
      String country_code,
      String pass,
      String adds,
      String name,
      String emails,
      String ids,
      String type,
      String pincode,
      String dob,
      String state,
      String city) async {
    final pref = getIt<SharedPreferenceHelper>();
    bool? names = await pref.saveUserName(name);
    bool? pass = await pref.saveUserPass(_passController.text);
    bool? email = await pref.saveUserEmail(emails);
    bool? add = await pref.saveUserAdd(adds);
    bool? mobile = await pref.saveUserMobile(_mobileController.text);
    bool? country_codes = await pref.saveUserCountryCodeType(country_code);
    bool? id = await pref.saveUserId(ids);
    bool? userid = await pref.setLogin(true);
    bool? usertype = await pref.saveUserType(type);
    bool? userpincode = await pref.saveUserPinCode(pincode);
    bool? userdob = await pref.saveUserDOB(dob);
    bool? userstate = await pref.saveStateName(state);
    bool? usercity = await pref.saveUserCity(city);
    cprint('login message = type 786 = ' + type);
    if (type == "admin") {
      cprint('login message = type 7867 = ' + type);
      nextScreenReplace(context, AdminHomeScreen());
    } else {
      nextScreenReplace(context, HomeOrderAccount());
    }
  }

  doAddition() async {
    String mobile = /*mobile_code+*/ _mobileController.text;
    String pass = _passController.text;

    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('mobile', isEqualTo: mobile)
        .where('pass', isEqualTo: pass)
        .limit(1)
        .get()
        .then((value) => {
              if (value.size >= 1)
                {
                  setState(() {
                    _progress = false;
                  }),
                  docss = value.docs,
                  cprint('login message = reference id = ' +
                      docss[0].reference.id),
                  cprint(
                      'login message = mobile = ' + docss[0].data()["mobile"]),
                  cprint('login message = pass = ' + docss[0].data()["pass"]),
                  cprint('login message = name = ' + docss[0].data()["name"]),
                  cprint('login message = add = ' + docss[0].data()["address"]),
                  cprint('login message = email = ' + docss[0].data()["email"]),
                  cprint('login message = id = ' + docss[0].data()["id"]),
                  cprint('login message = type = ' + docss[0].data()["type"]),
                  savedata(
                      docss[0].data()["mobile"],
                      docss[0].data()["country_code"],
                      docss[0].data()["pass"],
                      docss[0].data()["address"],
                      docss[0].data()["name"],
                      docss[0].data()["email"],
                      docss[0].data()["id"],
                      docss[0].data()["type"],
                      docss[0].data()["pincode"],
                      docss[0].data()["dob"],
                      docss[0].data()["state"],
                      docss[0].data()["city"]),
                  /*showToast("User already exist...")*/
                }
              else
                {
                  setState(() {
                    _progress = false;
                  }),
                  cprint('login message = mobile = false'),
                  showToast("wrong credentials")
                }
            });
  }

  String mobile_code = "+91";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/icons/iconappbar.png", //delivoo logo
                height: 200.0,
                width: 200,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text('Q1', style: Theme.of(context).textTheme.headline1)
                    .tr()),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text('A1', style: Theme.of(context).textTheme.subtitle1)
                    .tr()),
            Row(children: [
              Expanded(
                  flex: 3,
                  child: InkWell(onTap: (){
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
                      margin:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Color(0xff6c6b6b), width: 1)),
                      child: Row(children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 15, bottom: 15),
                            child: Image.asset(
                              "assets/images/icons/ic_phone.png",
                              color: kMainColor,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  setState(() {
                                    mobile_code = "+" + country.phoneCode;
                                  });
                                  print('Select country: ${country.displayName}');
                                },
                              );
                            },
                            child: Text(mobile_code,
                                style: TextStyle(color: kMainColor))),
                      ]),
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Container(
                      width: double.infinity,
                      height: 60,
                      child: EntryField(
                          controller: _mobileController,
                          label: 'Mobile Number',
                          keyboardType: TextInputType.number,
                          readOnly: false,
                          hint: 'Mobile Number')))
            ]),
            EntryField(
                controller: _passController,
                label: 'Your Password',
                image: 'assets/images/icons/pass.png',
                keyboardType: TextInputType.visiblePassword,
                readOnly: false,
                hint: 'Your Password'),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  nextScreen(
                      context,
                      ForgetPassScreen(
                        type: "forPass",
                        title: "Password recovery",
                      ));
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),*/
                  /* );*/
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    child: Text('forgot password',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )).tr()),
              ),
            ),
            Container(
              height: 64.0,
              margin: const EdgeInsets.only(top: 50, bottom: 10),
              child: BottomBar(
                check: false,
                text: ButtonText,
                onTap: () {
                  cprint('User mobile =  ' +
                      _mobileController.text.length.toString());
                  cprint(
                      'User pass =  ' + _passController.text.length.toString());
                  if (_mobileController.text.length == 0) {
                    showToast("Please enter you mobile number...");
                  } else if (_passController.text.length == 0) {
                    showToast("Please enter your password..");
                  } else {
                    setState(() {
                      _progress = true;
                    });

                    doAddition();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              //Center Row contents vertically,
              children: <Widget>[
                Text(
                  "Q2",
                  style: Theme.of(context).textTheme.subtitle1,
                ).tr(),
                InkWell(
                  onTap: () {
                    nextScreen(context, SignUpScreen());
                  },
                  child: Text(
                    "A2",
                    style: TextStyle(
                        color: kMainColor, fontSize: 15, fontFamily: "Nexa"),
                  ).tr(),
                )
              ],
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
      ),
    );
  }
}
