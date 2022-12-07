import 'package:amin/admin/admin_create_category.dart';
import 'package:amin/admin/admin_create_dress.dart';
import 'package:amin/admin/admin_dress_list.dart';
import 'package:amin/admin/admin_profile.dart';
import 'package:amin/model/CategoryModel.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class AdminCategoryScreen extends StatefulWidget {
  const AdminCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AdminCategoryScreen> createState() => _AdminCategoryScreenState();
}

class _AdminCategoryScreenState extends State<AdminCategoryScreen> {

  CollectionReference userss = FirebaseFirestore.instance.collection('category');

  delete(String id)async{

    final userss =await FirebaseFirestore.instance.collection('category').doc(id).delete();
  //  Navigator.pop(context);

  }
  final queryPost = FirebaseFirestore.instance.collection('category').withConverter<CategoryModel>(fromFirestore:(snapshot,_)=> CategoryModel.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category List"),
        actions: [
          IconButton(onPressed: (){
            nextScreenReplace(context,AdminCreateCategoryScreen(model:null,redId: null,checkCreateandUpdate: false));
          }, icon: Icon(Icons.add,color: Colors.blue),)
        ],
      ),
      body: FirestoreListView<CategoryModel>(
          query: queryPost,
          itemBuilder: (context,snapshot){
            final user = snapshot.data();
            String redid = snapshot.reference.id;
            return ListTile(
              onTap: (){
                nextScreen(context, AdminDressListScreen(category:user.cName,cId: user.cId,));
              },
              trailing: IconButton(onPressed: (){
                /*delete(snapshot.reference.id);*/
                nextScreenReplace(context,AdminCreateCategoryScreen(model:user,redId: redid,checkCreateandUpdate: true));
              },icon: Icon(Icons.edit,color: Colors.blue,),),
              leading: CircleAvatar(backgroundImage: NetworkImage(user.cImg!),),
              title: Text(user.cName!,style: Theme.of(context).textTheme.headline2,),
            );
          }
      ),
    );
  }
}
