import 'dart:math';

import 'package:amin/Components/MyChatItem.dart';
import 'package:amin/Components/OtherChatItem.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/ChatQuestionList.dart';
import 'package:amin/model/FAQUserListData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getData();
  }

  var _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? name = "A16";
  String? mobile = "0000000000";
  String? imageUrl = "";
  String? email = '';
  String? userId = "";
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  late ChatQuestionList chatQestion;
  CollectionReference userss = FirebaseFirestore.instance.collection('faq');
  CollectionReference usersss = FirebaseFirestore.instance.collection('faqUser');
  FaqUserListData faqlist = FaqUserListData();
  sendMsg(ChatQuestionList model)async{
    userss
        .add(model.toJson())
        .then((value) => {
      cprint('data insert'),
      setState(() {
        _progress = true;
        _progressNoData = false;
      }),
    }).catchError((error) => cprint('Failed to add user: error'));

    if(items.length == 1){
      faqlist = FaqUserListData(id: userId,userName: name,userEmail:email,userMobile:mobile,userImg:imageUrl);
      usersss
          .add(faqlist.toJson())
          .then((value) => {
        cprint('data insert'),
        setState(() {
          _progress = true;
          _progressNoData = false;
        }),
      }).catchError((error) => cprint('Failed to add user: error'));
    }
  }

  getData()async {
    final pref = getIt<SharedPreferenceHelper>();
    name = await pref.getUserName();
    mobile = await pref.getUserMobile();
    imageUrl = await pref.getUserImage();
    userId = await pref.getUserId();
    email = await pref.getUserEmail();
    setState(() {
      imageUrl;
    });
    var result = await FirebaseFirestore.instance
        .collection('faq')
    .where("user_id",isEqualTo: userId.toString())
        .get()
        .then((value) => {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {
          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              chatQestion = ChatQuestionList.fromJson(docss[i].data()),
              itemsNot.add(chatQestion),
              if(i == value.docs.length- 1){
                itemsNot.sort((a, b) => a.index!.compareTo(b.index!)),
                setState(() {
                  items = itemsNot.reversed.toList();
                }),

              },

              setState(() {
                itemsNot;
                _progress = true;
              }),
            }
        }
      else
        {
          setState(() {
            _progress = false;
            _progressNoData = true;
          }),
          cprint('login message = mobile = false'),

        }
    });
  }
  int clickindex = 0;
  bool _progress = false;
  bool _progressNoData = false;
  List<ChatQuestionList> items = [];
  List<ChatQuestionList> itemsNot = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                              NetworkImage(imageUrl!),
                            ),Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name!,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),/*
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.videocam,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    maxRadius: 18,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.drive_folder_upload,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),*/
            ],
          ),),
          Expanded(flex: 1,
          child:_progressNoData == true?Center(child: Text("No data"),):_progress == true? ListView.builder(shrinkWrap: true,
              itemCount: items.length,
              reverse: true,
              controller: _scrollController,itemBuilder: (BuildContext,int index){
            return items[index].type == "0"? OtherChatItem(
                listItem:
                items[index]): MyChatItem(
              listItem: items[index],
              user: (ChatQuestionList? value) {
                setState(() {
                  items.add(value!);
                });
              },
            );
          }):Container(),),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 71,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 15.0, height: 2.0, color: Colors.white),
                    onSubmitted: (value){
                      //value is entered text after ENTER press
                      //you can also call any function here or make setState() to assign value to other variable

                      setState(() {
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('hh:mm a').format(now);


                        /*print("Check Size = "+clickindex.toString());
                        clickindex = clickindex +1;
                        if(items.length >= clickindex){
                          print("Check Size true= "+clickindex.toString());
                          ChatQuestionList? value = ChatQuestionList(id: 7,question: _controller.text,image: [],video: [],thum: [],layoutType: "type",rightOrLeft: false,time: formattedDate,userName: "");
                          duplicateItems.add(value);
                          if(items.length > clickindex){
                            duplicateItems.add(items[clickindex]);
                            if(items[clickindex].layoutType == "type"){
                              type = 0;
                            }else  if(items[clickindex].layoutType == "scroll"){
                              type = 1;
                            }else  if(items[clickindex].layoutType == "button"){
                              type = 2;
                            }else  if(items[clickindex].layoutType == "birthday"){
                              type = 3;
                            }
                          }


                        }else {
                          print("Check Size false= "+clickindex.toString());
                        }*/
                        _controller.clear();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      labelText: "Enter a message",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _controller.clear,
                        icon: Icon(Icons.clear),
                      ),
                    ),

                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {


                   if(_controller.text.length >0){
                     Random random = Random();
                     int randomNumber = random.nextInt(10000);
                     String chatids = "ChatId" + randomNumber.toString();

                     DateTime now = new DateTime.now();
                     var formatter = new DateFormat('yyyy-MM-dd');
                     var formattcertime = new DateFormat("hh:mm a");
                     String formattedDate = formatter.format(now);
                     String formattedTime = formattcertime.format(now);


                     ChatQuestionList? value = ChatQuestionList(
                         chatId: chatids,
                         userId: userId,
                         userName:name,
                         userImg:imageUrl,
                         userEmale: email,
                         userMobile:mobile,
                         userMsg:_controller.text,
                         userDate:formattedDate,
                         userTime: formattedTime,
                         adminImg:"",
                         adminName:"",
                         adminId:"",
                         adminMsg:"",
                         adminDate:"",
                         adminTime:"",
                         status:"1",
                         type: "1",
                         index: items.length);
                     items.insert(0,value);
                     sendMsg(value);

                     _controller.clear();
                   }



                    });

                  },
                  child: Icon(Icons.send, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    primary: Colors.blue, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                )

              ],),
          ),

        ],),
      ),
    );
  }
}
