import 'package:amin/admin/admin_create_coupon.dart';
import 'package:amin/admin/admin_review_reply_screen.dart';
import 'package:amin/model/RatingModel.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AdminRatingListScreen extends StatefulWidget {
  const AdminRatingListScreen({Key? key}) : super(key: key);

  @override
  State<AdminRatingListScreen> createState() => _AdminRatingListScreenState();
}

class _AdminRatingListScreenState extends State<AdminRatingListScreen> {

  void updateVisible(String refId,String visi, RatingModel model){

    print("Lucky check visible  =  "+visi);
    model.setvisible = visi;

    FirebaseFirestore.instance.collection('Ratings').doc(refId).update(model.toJson());
  }
  final queryPost = FirebaseFirestore.instance.collection('Ratings').withConverter<RatingModel>(fromFirestore:(snapshot,_)=> RatingModel.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating List"),
      ),
      body: FirestoreListView<RatingModel>(
          query: queryPost,
          itemBuilder: (context,snapshot){
            final user = snapshot.data();
            return ListTile(
              onTap: (){
                nextScreen(context, AdmiReviewReplyScreen(ratingModel: user,refId: snapshot.reference.id,));
              },
              /*      trailing: IconButton(onPressed: (){
                delete(user.cId!);
              },icon: Icon(Icons.delete,color: Colors.blue,),),*/
              trailing: IconButton(onPressed: (){
                updateVisible( snapshot.reference.id, user.visible!  == "1"? "0":"1",user);
              }, icon: Icon(user.visible! == "1"? Icons.visibility:Icons.visibility_off,color: Colors.blue,)),
              leading: CircleAvatar(backgroundImage: NetworkImage(user.userImg!),),
              title: Text(user.userName!,style: Theme.of(context).textTheme.headline2,),
              /*subtitle: Text(user.userMessage!),*/
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(user.userMessage!,style: TextStyle(color: Colors.grey,fontSize: 11),),
           /*     Text(user.rating!),*/

                  RatingBarIndicator(
                    rating: user.rating! == ""?0.0: double.parse(user.rating!),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 15.0,
                    unratedColor: Colors.amber.withAlpha(50),
                    direction: Axis.horizontal,
                  ),
                  Text(user.time!,style: TextStyle(color: Colors.grey,fontSize: 11),),
              ],),

            );
          }
      ),
    );
  }
}
