import 'package:amin/admin/admin_create_category.dart';
import 'package:amin/admin/admin_create_coupon.dart';
import 'package:amin/admin/admin_dress_list.dart';
import 'package:amin/model/CategoryModel.dart';
import 'package:amin/model/Coupon.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';


class AdminCouponListScreen extends StatefulWidget {
  bool? check;
  AdminCouponListScreen({Key? key,required this.check}) : super(key: key);

  @override
  State<AdminCouponListScreen> createState() => _AdminCouponListScreenState();
}

class _AdminCouponListScreenState extends State<AdminCouponListScreen> {
  deleteDress(String refId){
    FirebaseFirestore.instance.collection('Coupon').doc(refId).delete();
    Navigator.pop(context);
  }
  final queryPost = FirebaseFirestore.instance.collection('Coupon').withConverter<Coupon>(fromFirestore:(snapshot,_)=> Coupon.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon List"),
        actions: [
          IconButton(onPressed: (){
            nextScreenReplace(context,AdminCreateCouponScreen(check: true,coupon: null,refId: null,));
          }, icon: Icon(Icons.add,color: Colors.blue),)
        ],
      ),

      body: FirestoreListView<Coupon>(
          query: queryPost,
          itemBuilder: (context,snapshot){
            final user = snapshot.data();
            return ListTile(
              onTap: (){
                if(widget.check == true){
                  Navigator.pop(context,user.id);
                }else {
                  nextScreen(context, AdminCreateCouponScreen(check: false,coupon: user,refId: snapshot.reference.id,));
                }

              },
              /*      trailing: IconButton(onPressed: (){
                delete(user.cId!);
              },icon: Icon(Icons.delete,color: Colors.blue,),),*/
              trailing: IconButton(onPressed: (){

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Selected Coupon').tr(),
                        content: Text('are you sure').tr(),
                        actions: <Widget>[
                          new GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                          ),
                          SizedBox(height: 16),
                          new GestureDetector(
                            onTap: () =>   deleteDress( snapshot.reference.id),
                            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                          ),

                        ],
                      );
                    });

              }, icon: Icon(Icons.delete,color: Colors.blue,)),
              leading: CircleAvatar(backgroundImage: NetworkImage("https://img.freepik.com/free-vector/gift-coupon-with-ribbon-offer_24877-55663.jpg?size=626&ext=jpg&ga=GA1.1.1578454833.1643587200"),),
              title: Text(user.titleName!,style: Theme.of(context).textTheme.headline2,),
            );
          }
      ),
    );
  }
}
