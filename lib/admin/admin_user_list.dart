import 'package:amin/admin/admin_profile.dart';
import 'package:amin/admin/admin_user_search_list.dart';
import 'package:amin/model/UserList.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class AdminUserListScreen extends StatefulWidget {
  const AdminUserListScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserListScreen> createState() => _AdminUserListScreenState();
}

class _AdminUserListScreenState extends State<AdminUserListScreen> {
  final queryPost = FirebaseFirestore.instance.collection('users').withConverter<UserList>(fromFirestore:(snapshot,_)=> UserList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        actions: [
          IconButton(onPressed: (){
            nextScreen(context, AdminUserSearchListScreen());
          }, icon: Icon(Icons.search,color: Colors.white,)),
        ],
      ),
      body: FirestoreListView<UserList>(
        query: queryPost,
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
    );
  }
}
