import 'package:amin/model/CourseBuy.dart';
import 'package:amin/model/UserList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';





class AdminCourseBuyList extends StatefulWidget {
  const AdminCourseBuyList({Key? key}) : super(key: key);

  @override
  State<AdminCourseBuyList> createState() => _AdminCourseBuyListState();
}

class _AdminCourseBuyListState extends State<AdminCourseBuyList> {

  final queryPost = FirebaseFirestore.instance.collection('course_buy').withConverter<CourseBuy>(fromFirestore:(snapshot,_)=> CourseBuy.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Buy"),
        // actions: [
        //   IconButton(onPressed: (){
        //     nextScreen(context, AdminUserSearchListScreen());
        //   }, icon: Icon(Icons.search,color: Colors.white,)),
        // ],
      ),
      body: FirestoreListView<CourseBuy>(
          query: queryPost,
          itemBuilder: (context,snapshot){
            final user = snapshot.data();
            return ListTile(
              onTap: (){
          //      nextScreen(context, AdminProfileScreen(userlist:user));
              },
              // leading: CircleAvatar(backgroundImage: NetworkImage(user.image!),),
              title: Row(children: [
                Text("title : ",style: TextStyle(color: Colors.white,fontSize: 13)),
                Text(user.title!,style: Theme.of(context).textTheme.headline2,),
              ],),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text("MRP Amount : ",style: TextStyle(color: Colors.blue,fontSize: 13)),
                        Text(user.price!+" Rs",style: Theme.of(context).textTheme.headline2,),
                      ],),
                      Row(children: [
                        Text("Paid Amount : ",style: TextStyle(color: Colors.blue,fontSize: 13)),
                        Text(user.paidAmount!+" Rs",style: Theme.of(context).textTheme.headline2,),
                      ],),
                  ],),

                Text(user.paidAmount!+"\n"+user.date!,style: TextStyle(color: Colors.white,fontSize: 13)),
              ],),

            );
          }
      ),
    );
  }
}
