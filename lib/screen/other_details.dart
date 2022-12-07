import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class OtherDetailsScreen extends StatefulWidget {
  String? title;
  String? hint;
  int? Lengthnumber;
  OtherDetailsScreen({Key? key,required this.title, this.hint, this.Lengthnumber}) : super(key: key);

  @override
  State<OtherDetailsScreen> createState() => _OtherDetailsScreenState();
}

class _OtherDetailsScreenState extends State<OtherDetailsScreen> {
  final TextEditingController _Controller = TextEditingController();
  String ButtonText = "Continue";
  @override
  void dispose() {
    _Controller.dispose();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(shrinkWrap: true,children: [
        SizedBox(height: 50,),
        EntryField(
            controller: _Controller,
            label: widget.title!,
            image: 'assets/images/icons/pass.png',
            keyboardType:widget.Lengthnumber == null ?  TextInputType.visiblePassword: TextInputType.number,
            maxLength: widget.Lengthnumber == null ? null:widget.Lengthnumber,
            readOnly: false,
            hint: widget.title! == null ? widget.title! : widget.hint!),

        SizedBox(height: 80,),

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
                      _Controller.text.length.toString());
                  /*if(_nameController.text.length ==0){
                          showToast("Please enter your Name..");
                        }else*/

                  if (_Controller.text.length == 0) {
                    showToast("Please enter you details...");

                  }/*else if (_passController.text.toString() != _confirmpassController.text.toString()) {
                          showToast("Please enter your right password..");

                        }   else if (_adreessController.text.length ==0) {
                          showToast("Please enter your address..");

                        }   else if (_emailController.text.length ==0) {
                          showToast("Please enter your email address..");

                        } */ else {

                    Navigator.pop(context,_Controller.text);

                  }
                },
              ),
            ],
          ),
        ),
      ],),),
    );
  }
}
