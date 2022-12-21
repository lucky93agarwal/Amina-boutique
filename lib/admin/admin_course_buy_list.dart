import 'package:amin/admin/admin_course_details_screen.dart';
import 'package:amin/model/CourseBuy.dart';
import 'package:amin/model/UserList.dart';
import 'package:amin/utils/next_screen.dart';
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
            return Column(
              children: [
                ListTile(
                  onTap: (){
                nextScreen(context, AdminCourseDetailsScreen(cName:user.title,cId: user.cId,cPaidPrice: user.paidAmount,DateTime:user.date,userId:user.uId));
                  },
                  // leading: CircleAvatar(backgroundImage: NetworkImage(user.image!),),
                  title: Row(children: [
                    Text("Title : ",style: TextStyle(color: Colors.blue,fontSize: 13)),
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
                            Text("MRP Amount : ",style: TextStyle(color: Colors.blue,fontSize: 11)),
                            Text(user.price!+" Rs",style:TextStyle(color: Colors.white,fontSize: 14)),
                          ],),
                          Row(children: [
                            Text("Paid Amount : ",style: TextStyle(color: Colors.blue,fontSize: 11)),
                            Text(user.paidAmount!+" Rs",style: TextStyle(color: Colors.white,fontSize: 14)),
                          ],),
                      ],),
                      Row(children: [
                        Text("Date and Time : ",style: TextStyle(color: Colors.blue,fontSize: 11)),
                        Text(user.date!,style: TextStyle(color: Colors.white,fontSize: 11),),
                      ],),

                //    Text("Date and Time : "+user.date!,style: TextStyle(color: Colors.white,fontSize: 13)),
                  ],),

                ),
                Container(width: MediaQuery.of(context).size.width,
                  height: 1,
                  margin: const EdgeInsets.only(top: 10,bottom: 5),
                  color: Color(0xFFE57373),)
              ],
            );
          }
      ),
    );
  }
}
