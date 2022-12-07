import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/screen/otp.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassScreen extends StatefulWidget {
  String type;
  String title;
  ForgetPassScreen({Key? key,required this.type,required this.title}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  final TextEditingController _mobileController = TextEditingController();
  String ButtonText = "Continue";
  @override
  void dispose() {
    _mobileController.dispose();


    super.dispose();
  }
  bool _progress = false;
  /*void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }*/
  String mobile_code = "+91";
  checkMobile(String MobileNo)async{
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
          nextScreenReplace(context, OTPScreen(country_code:mobile_code,mobile: _mobileController.text,type:widget.type)),

        }
      else
        {
          setState(() {
            _progress = false;
          }),
          _mobileController.text = "",
          Fluttertoast.showToast(
              msg: "User not exist...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0)
          /*nextScreen(context, EditProfileScreen(type: false,)),*/

        }
    });
  }
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
        child: new Stack(
          children: <Widget>[

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50,),
                      Container(padding:EdgeInsets.symmetric(horizontal: 10,vertical: 10),alignment: Alignment.centerLeft,child: Text( widget.title,style: Theme.of(context).textTheme.headline1).tr()),
                      Container(padding:EdgeInsets.symmetric(horizontal: 10),margin: const EdgeInsets.only(bottom: 20),alignment: Alignment.centerLeft,child: Text('Q7',style:
                      Theme.of(context).textTheme.subtitle1).tr()),

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
                      )

                    ],
                  ),
                ),
                Container(
                  height: 64.0,
                  margin: const EdgeInsets.only(bottom: 50),
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
                          cprint('User mobile =  '+_mobileController.text.length.toString());
                          if (_mobileController.text.length == 0) {
                            /* showToast("Please enter you mobile number...", gravity: Toast.bottom);*/
                            Fluttertoast.showToast(
                                msg: "Please enter you mobile number...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            /* Toast.show("Please enter you mobile number...",
                              duration: Toast.lengthShort,
                              gravity: Toast.bottom);*/
                          } else {
                            setState(() {
                              _progress = true;
                            });
                            checkMobile(_mobileController.text);

                          }
                        },
                      ),

                    ],),




                )

              ],
            ),

          ],
        ),
      ),
    );
  }
}
