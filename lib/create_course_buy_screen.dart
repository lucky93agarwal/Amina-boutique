import 'package:amin/Components/bottom_bar.dart';
import 'package:amin/Components/entry_fields.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateCoursebuyScreen extends StatefulWidget {
  const CreateCoursebuyScreen({Key? key}) : super(key: key);

  @override
  State<CreateCoursebuyScreen> createState() => _CreateCoursebuyScreenState();
}

class _CreateCoursebuyScreenState extends State<CreateCoursebuyScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool _progress = false;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  final List<String> courseName = [];
  final List<String> courseAmount = [];
  final List<String> courseId = [];

  final List<String> userName = [];
  final List<String> userId = [];

  String? selectedCouseValue;
  String? selectedCouseAmount;

  String selectedCouseID = "";

  String selectedUserID = "";
  String? selectedUserValue;

  final TextEditingController textCourseEditingController =
      TextEditingController();
  final TextEditingController textUserEditingController =
      TextEditingController();
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;

  getCourseList() async {
    final pref = getIt<SharedPreferenceHelper>();

    UserId = await pref.getUserId();
    var result = await FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((value) => {
              if (value.size >= 1)
                {
                  setState(() {
                    _progress = false;
                  }),
                  docss = value.docs,
                  //showToast(docss.length.toString()),
                  cprint('login message = reference id = ' +
                      docss.length.toString()),
                  for (int i = 0; i < docss.length; i++)
                    {
                      courseName.add(docss[i].data()["cName"]),
                      courseId.add(docss[i].data()["cId"]),
                      courseAmount.add(docss[i].data()["cPrice"]),
                    },

                  setState(() {
                    courseName;
                    courseId;
                    courseAmount;
                  })
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

  getUserList() async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => {
              if (value.size >= 1)
                {
                  setState(() {
                    _progress = false;
                  }),
                  docss = value.docs,
                  //  showToast(docss.length.toString()),
                  // cprint('login message = reference id = ' +
                  //     docss.length.toString()),
                  for (int i = 0; i < docss.length; i++)
                    {
                      userName.add(docss[i].data()["name"]),
                      userId.add(docss[i].data()["id"]),
                    },

                  setState(() {
                    userName;
                    userId;
                  })
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourseList();

    getUserList();
  }

  @override
  void dispose() {
    textCourseEditingController.dispose();
    textUserEditingController.dispose();
    super.dispose();
  }

  Widget CourseList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            'Select Course',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: courseName
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedCouseValue,
          onChanged: (value) {
            setState(() {
              selectedCouseValue = value as String;
              var index = courseName.indexOf(selectedCouseValue!);
              selectedCouseID = courseId[index].toString();
              selectedCouseAmount = courseAmount[index].toString();
              // showToast(selectedCouseID);
            });
          },
          buttonHeight: 40,
          buttonWidth: MediaQuery.of(context).size.width - 30,
          itemHeight: 40,
          dropdownMaxHeight: 300,
          searchController: textCourseEditingController,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              controller: textCourseEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an course...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return (item.value.toString().contains(searchValue));
          },
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textCourseEditingController.clear();
            }
          },
        ),
      ),
    );
  }

  Widget UserList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            'Select User',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: userName
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedUserValue,
          onChanged: (value) {
            setState(() {
              selectedUserValue = value as String;
              var index = userName.indexOf(selectedUserValue!);
              selectedUserID = userId[index].toString();
              //  showToast(selectedUserID);
            });
          },
          buttonHeight: 40,
          buttonWidth: MediaQuery.of(context).size.width - 30,
          itemHeight: 40,
          dropdownMaxHeight: 300,
          searchController: textUserEditingController,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              controller: textUserEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an user...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return (item.value.toString().contains(searchValue));
          },
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textUserEditingController.clear();
            }
          },
        ),
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

  String? UserId = "";

  buyCourse() {
    CollectionReference userss =
        FirebaseFirestore.instance.collection('course_buy');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    userss
        .add({
          'uId': UserId, // John Doe
          'cId': selectedCouseID,
          'date': formattedDate,
          'transectionId': "Admin buy this course",
          'price': selectedCouseAmount.toString(),
          'review': "false",
          'coupon_id': "0",
          'Coupon_status': "0",

          'title': selectedCouseValue,
          'userName': selectedUserValue,
          'paid_Amount': _mobileController.text.toString(),
        })
        .then((value) => {
              showToast("Course Purchased Successfully"),
              Navigator.pop(context),
            })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => cprint('Failed to add user: error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Buy"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            EntryField(
                controller: _mobileController,
                label: 'Amount',
                keyboardType: TextInputType.number,
                maxLength: 5,
                readOnly: false,
                hint: 'Mobile Number'),
            CourseList(),
            SizedBox(
              height: 10,
            ),
            UserList(),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 64.0,
              margin: const EdgeInsets.only(top: 100, bottom: 10),
              child: BottomBar(
                check: false,
                text: " Course Buy",
                onTap: () {
                  //    showToast("Please upload category image..."+selectedUserValue!);
                  if (_mobileController.text.length == 0) {
                    showToast("Please enter you amount...");
                  } else if (selectedUserValue == null) {
                    showToast("Please select user...");
                  } else if (selectedCouseValue == null) {
                    showToast("Please select course...");
                  } else {
                    setState(() {
                      _progress = true;
                    });
                    // showToast(
                    //     "Please upload category image..." + selectedUserValue!);
                    buyCourse();
                    //
                    //   // if(widget.checkCreateandUpdate == true){
                    //   //   setState(() {
                    //   //     _progress = true;
                    //   //   });
                    //   //   updateUrlFromServer();
                    //   // }else {
                    //   //   setState(() {
                    //   //     _progress = true;
                    //   //   });
                    //   //   sendUrlFromServer();
                    //   // }
                    //
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
      ),
    );
  }
}
