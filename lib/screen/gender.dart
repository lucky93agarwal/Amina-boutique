
import 'package:amin/Components/bottom_bar.dart';
import 'package:flutter/material.dart';


class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String ButtonText = "Continue";
  // ChooseGender _character = ChooseGender.male;
  String _gender = 'male';
  String _genderid = '1';
  String _selected = 'male';

  _nextHandler() async{

 /*   prefs.setString("gender",_gender);
    prefs.setString("genderid",_genderid);*/
    Navigator.pop(context,_gender);
/*    Navigator.push(context, MaterialPageRoute(builder: (context) =>Mobile()));*/
  }

  _backHandler() {
    Navigator.of(context).pop();
  }

  _chooseGenderHandler() {
    print('male button ');
    print(_selected);

    setState(() {
      _selected = _selected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(
              top: 50,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10, right: 10
                  ),
                  child: Text(
                    "What's your gender ?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 0,
                      left: 10, right: 10
                  ),
                  child: Text(
                    'You can change who sees your gender on your profile later',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print("set data lucky  = "+_selected.toString());
                          setState(() {

                            _selected = _selected;
                            _gender =  'male';
                            _genderid = "1";
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Male',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontFamily: 'Roboto'
                                  )
                              ),
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  value: 'male',
                                  activeColor:Colors.white,
                                  groupValue: _gender,

                                  onChanged: (value) {
                                    print(value.runtimeType);
                                    setState(() {

                                      _selected = value.toString();
                                      _gender =  _selected;
                                      _genderid = "1";
                                      print("set data lucky  = "+_selected.toString());
                                    });
                                  },
                                ),
                              )
                            ]),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      InkWell(
                        onTap: () {
                          print("set data lucky  = "+_selected.toString());
                          setState(() {

                            _selected = _selected;
                            _gender =  'female';
                            _genderid = "2";
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Female',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontFamily: 'Roboto'
                                ),
                              ),
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  value: 'female',
                                  activeColor:  Colors.white,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value.toString();
                                      _gender =  _selected;
                                      _genderid = "2";
                                    });
                                  },
                                ),
                              )
                            ]),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      InkWell(
                        onTap: () {
                          print("set data lucky  = "+_selected.toString());
                          setState(() {
                            _selected = _selected;
                            _gender =  'other';
                            _genderid = "3";
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Custom',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontFamily: 'Roboto'
                                ),
                              ),
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  value: 'other',
                                  activeColor:  Colors.white,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value.toString();
                                      _gender =  _selected;
                                      _genderid = "3";
                                    });
                                  },
                                ),
                              )
                            ]),
                      ),



                      InkWell(onTap: (){
                        print("set data lucky  = "+_selected.toString());
                        setState(() {
                          _selected = _selected;
                          _gender =  'other';
                        });
                      },child: Container(
                        margin: const EdgeInsets.only(
                          top: 2,
                          bottom: 10,
                        ),
                        child: Text(
                          'Select Custom to choose another gender,\nor if you\'d rather not to say.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),),

                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 64.0,
                  margin: const EdgeInsets.only(top: 50,bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      BottomBar(
                        check: false,
                        text: ButtonText,
                        onTap: () {
                          /*if(_nameController.text.length ==0){
                          showToast("Please enter your Name..");
                        }else*/
                          _nextHandler();


                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
