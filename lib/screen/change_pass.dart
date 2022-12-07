import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/screen/home.dart';
import 'package:amin/screen/splash.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ChangePassScreen extends StatefulWidget {
  String mobile;
  String doc;
  ChangePassScreen({Key? key,required this.mobile,required this.doc}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  String ButtonText = "Continue";


  bool _progress = false;

  CollectionReference userss = FirebaseFirestore.instance.collection('users');
  addUser(String pass)async{
    FirebaseFirestore.instance.collection('users').doc(widget.doc).update({'pass':_passController.text});
    nextScreenReplace(context, SplashScreen());
    showToast("Your Password Updated Successfully");
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "change Password",
        ).tr(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Stack(
          children: <Widget>[

            new Positioned(
                child: new Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: 64.0,
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
                                  _confirmpassController.text.length.toString());
                              cprint('User pass =  ' +
                                  _passController.text.length.toString());
                              if (_passController.text.length == 0) {
                                showToast("Please enter your password..");

                              } else if (_passController.text.toString() != _confirmpassController.text.toString()) {
                                showToast("Please enter your right password..");

                              } else {
                                setState(() {
                                  _progress = true;
                                });
                                addUser(_passController.text);

                              }
                            },
                          ),
                        ],
                      ),
                    ))),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(
                children: <Widget>[
                  EntryField(
                      controller: _passController,
                      label: 'Your Password',
                      image: 'assets/images/icons/pass.png',
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 8,
                      readOnly: false,
                      hint: 'Your Password'),
                  EntryField(
                      controller: _confirmpassController,
                      label: 'Confirm Password',
                      image: 'assets/images/icons/pass.png',
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 8,
                      readOnly: false,
                      hint: 'Confirm Password'),
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
