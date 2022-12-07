import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/screen/home_order_account.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ChangeAddressScreen extends StatefulWidget {
  String mobile;
  String doc;
  ChangeAddressScreen({Key? key,required this.mobile,required this.doc}) : super(key: key);

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final TextEditingController _addController = TextEditingController();

  String ButtonText = "Continue";


  bool _progress = false;

  CollectionReference userss = FirebaseFirestore.instance.collection('users');
  addUser(String pass)async{
    FirebaseFirestore.instance.collection('users').doc(widget.doc).update({'address':_addController.text});
    nextScreenReplace(context, HomeOrderAccount());
    showToast("Your Address Updated Successfully");
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
          "Change Address",
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
                  child: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: Image.asset(
                      "assets/images/loginbackimgone.png", //delivoo logo
//                height: 100.0,
                      width: double.infinity,
                    ),
                  ),
                )),
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
                                  _addController.text.length.toString());
                              if (_addController.text.length == 0) {
                                showToast("Please enter your address..");

                              } else {
                                setState(() {
                                  _progress = true;
                                });
                                addUser(_addController.text);

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
                      controller: _addController,
                      label: 'Your Address',
                      image: 'assets/images/icons/pass.png',
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 108,
                      readOnly: false,
                      hint: 'Your Address'),
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
