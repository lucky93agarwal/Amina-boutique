import 'package:amin/model/RatingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class AddReviewListScreen extends StatefulWidget {
  List<RatingModel> productList;
  AddReviewListScreen({Key? key,required this.productList}) : super(key: key);

  @override
  State<AddReviewListScreen> createState() => _AddReviewListScreenState();
}

class _AddReviewListScreenState extends State<AddReviewListScreen> {
  late List<RatingModel> productList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productList = widget.productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review List"),),

      body: ListView.builder(shrinkWrap: true,itemCount: productList.length,itemBuilder: (BuildContext context, int index){
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          decoration: BoxDecoration(
              color: Color(0xff222328),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [BoxShadow(
                blurRadius: 5.0,
                color: Color(0xFF616161),
                spreadRadius: 3,
                offset: Offset(
                  1,
                  1,
                ),
              ),]),child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Row(children: [
                  Container(width: 30,height: 30,decoration: BoxDecoration( shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(productList[index].userImg!,),fit: BoxFit.cover)),),
                  SizedBox(width: 5,),
                  Text(productList[index].userName!.toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
                  SizedBox(width: 5,),
                  Text(productList[index].time!,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 8),),
                ],),),
                RatingBarIndicator(
                  rating: productList[index].rating! == ""?0.0: double.parse(productList[index].rating!),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                  unratedColor: Colors.amber.withAlpha(50),
                  direction: Axis.horizontal,
                ),
              ],),
            SizedBox(height: 10,),
            Text('"'+productList[index].userMessage!+'"',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),),
            SizedBox(height: 10,),
            Visibility(
                visible: productList[index].reply!.length >5? true:false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(alignment: Alignment.topRight,child:   Text("Admin Reply",style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 12),),),
                    SizedBox(height: 10,),
                    Align(alignment: Alignment.topRight,child:   Text('"'+productList[index].reply!+'"',textAlign: TextAlign.end,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),),)
                  ],)),

          ],
        ),);
      }),
    );
  }
}
