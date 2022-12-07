import 'package:amin/admin/admin_faq_reply.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/ChatQuestionList.dart';
import 'package:amin/model/FAQUserListData.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class AdminFAQUserListScreen extends StatefulWidget {
  const AdminFAQUserListScreen({Key? key}) : super(key: key);

  @override
  State<AdminFAQUserListScreen> createState() => _AdminFAQUserListScreenState();
}

class _AdminFAQUserListScreenState extends State<AdminFAQUserListScreen> {
  bool _progress = false;
  bool _progressNoData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> userList = [];
  List<String> userIdList = [];
  List<String> userImg= [];
  List<String> userMessage = [];

  getData() async {
    final pref = getIt<SharedPreferenceHelper>();
    name = await pref.getUserName();
    mobile = await pref.getUserMobile();
    imageUrl = await pref.getUserImage();
    userId = await pref.getUserId();
    setState(() {
      imageUrl;
    });
    var result = await FirebaseFirestore.instance
        .collection('faqUser')
        /*.where("user_id", isNotEqualTo: userId.toString())*/
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
                      if(userList.contains(chatQestion.userName!)==false){
                        userList.add(chatQestion.userName!),
                        userImg.add(chatQestion.userImg!),
                        userMessage.add(chatQestion.userMsg!),
                        userIdList.add(chatQestion.userId!),

                        refIdList.add(docss[i].reference.id),
                        items.add(chatQestion),
                      },


                      setState(() {
                        items;
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

  List<ChatQuestionList> items = [];
  late ChatQuestionList chatQestion;
  List<String> refIdList = [];
  String? name = "A16";
  String? mobile = "0000000000";
  String? imageUrl = "";
  String? userId = "";
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  final queryPost = FirebaseFirestore.instance.collection('faqUser').withConverter<FaqUserListData>(fromFirestore:(snapshot,_)=> FaqUserListData.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Chat"),
      ),
      body: /*_progressNoData == true
          ? Center(
              child: Text("No data"),
            )
          : _progress == true
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (BuildContext, int index) {
                    return ListTile(
                      onTap: (){
                        nextScreen(context, AdminFAQReplyScreen(model:items[index]));
                      },
                      leading: Container(width:50,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(userImg[index]),fit: BoxFit.cover))),
                      title: Text(userList[index],
                          style: TextStyle(color: Colors.white,fontSize: 16)),
                      subtitle: Text(
                        userMessage[index],
                        style: TextStyle(color: Colors.grey,fontSize: 9),
                      ),
                    );
                  })
              : Container(),*/
      FirestoreListView<FaqUserListData>(
          query: queryPost,
          itemBuilder: (context,snapshot){
            final user = snapshot.data();
            return ListTile(
              onTap: (){
                nextScreen(context, AdminFAQReplyScreen(model:user));
              },
              leading: CircleAvatar(backgroundImage: NetworkImage(user.userImg!),),
              title: Text(user.userName!,style: Theme.of(context).textTheme.headline2,),
            );
          }
      ),
    );
  }
}
