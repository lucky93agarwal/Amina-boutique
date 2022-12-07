import 'package:amin/Components/entry_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../helper/uitils.dart';
import '../model/UserList.dart';
import '../utils/next_screen.dart';
import 'admin_profile.dart';



class AdminUserSearchListScreen extends StatefulWidget {
  const AdminUserSearchListScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserSearchListScreen> createState() => _AdminUserSearchListScreenState();
}

class _AdminUserSearchListScreenState extends State<AdminUserSearchListScreen> {

  late Query<UserList> queryPost;

  searchVideo(String word)async {

    bool checkchara = RegExp(r'^[a-z]').hasMatch(word);
    cprint("check total crater in title =  "+word+" , checkchara = "+checkchara.toString());
    if(checkchara == true){
      queryPost = FirebaseFirestore.instance.collection("users").where('name', isEqualTo:word).withConverter<UserList>(fromFirestore:(snapshot,_)=> UserList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
    }else {
      queryPost = FirebaseFirestore.instance.collection("users").where('mobile', isEqualTo:word).withConverter<UserList>(fromFirestore:(snapshot,_)=> UserList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
    }


    setState(() {
      checkdata = true;
    });
    cprint("check total crater in "+" , checkdata = "+checkdata.toString());
  }
  final TextEditingController _searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  bool checkdata = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search User List"),),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Stack(
            children: [
              EntryField(
                controller: _searchController,
                label: 'Find something..',
                image: 'assets/images/icons/ic_search.png',
                keyboardType: TextInputType.emailAddress,
                maxLength: null,
                readOnly: false,
                hint: 'Find something..',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                  child: InkWell(
                    onTap: (){
                      searchVideo(_searchController.text);
                      /*if(widget.title == "courses"){
                        searchCorses(_searchController.text);
                      }else {
                        searchVideo(_searchController.text);
                      }*/

                    },
                    child: Text(
                      "Search",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          checkdata ? Container(
            height: MediaQuery.of(context).size.height-150,
            child: FirestoreListView<UserList>(
                query: queryPost,
                shrinkWrap: true,
                pageSize: 10,
                errorBuilder:  (context,snapshot,stackTrace){
                  return Container(height: MediaQuery.of(context).size.height-150,alignment: Alignment.center,child: Text("No Data Found"),);
                },
                itemBuilder: (context,snapshot){

                  final user = snapshot.data();


                  return ListTile(
                    onTap: (){
                      nextScreen(context, AdminProfileScreen(userlist:user));
                    },
                    leading: CircleAvatar(backgroundImage: NetworkImage(user.image!),),
                    title: Text(user.name!,style: Theme.of(context).textTheme.headline2,),
                    subtitle: Text(user.mobile!,style: TextStyle(color: Colors.white,fontSize: 13)),
                  );
                }
            ),
          ):
          Container(height: MediaQuery.of(context).size.height-150,alignment: Alignment.center,child: Text("Please search any user"),)
        ],),
    );
  }
}
