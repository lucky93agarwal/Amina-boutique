import 'package:amin/admin/admin_order_dress_details.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/BuyDressOrder.dart';
import 'package:amin/screen/add_review_screen.dart';
import 'package:amin/screen/splash.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/color.dart';

class OrderScreen extends StatefulWidget {
  bool? checkAdmin;
  OrderScreen({Key? key,required this.checkAdmin}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDataKnow();
  }

  String? id = "";
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  late BuyDressOrder buyDressOrder;
  late List<BuyDressOrder> dressList = [];
  late bool? _progress = false;
  late bool? _progressNoData = false;

  void getDataKnow() async {
    final pref = getIt<SharedPreferenceHelper>();
    id = await pref.getUserId();


    if(widget.checkAdmin == true){
      var result = await FirebaseFirestore.instance
          .collection('BuyDress')
          .orderBy('date', descending: true)
          .get()
          .then((value) => {
        cprint(
            'login message =786 value.size = ' + value.size.toString()),
        if (value.size >= 1)
          {
            docss = value.docs,
            for (int i = 0; i < value.docs.length; i++)
              {
                buyDressOrder = BuyDressOrder.fromJson(docss[i].data()),
                dressList.add(buyDressOrder),
                refIdList.add(docss[i].reference.id),
                setState(() {
                  dressList;
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
            showToast("No Data")
          }
      });
    }else {
      var result = await FirebaseFirestore.instance
          .collection('BuyDress')
          .where('user_id', isEqualTo: id)
          .get()
          .then((value) => {
        cprint(
            'login message =786 value.size = ' + value.size.toString()),
        if (value.size >= 1)
          {
            docss = value.docs,
            for (int i = 0; i < value.docs.length; i++)
              {
                buyDressOrder = BuyDressOrder.fromJson(docss[i].data()),
                refIdList.add(docss[i].reference.id),
                dressList.add(buyDressOrder),

                setState(() {
                  dressList;
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
            showToast("No Data")
          }
      });
    }

  }
  List<String> refIdList = [];

  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  List<BuyDressOrder> orderList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.checkAdmin!,
        title: Text("Order"),
        actions: [
          IconButton(onPressed: (){
            dressList.clear();
            refIdList.clear();
            _progress = false;
            setState(() {

            });
            getDataKnow();

          }, icon: Icon(Icons.refresh,color: Colors.blue),)
        ],
      ),
      body:_progressNoData == false? _progress == true
          ? ListView.builder(itemCount: dressList.length,itemBuilder: (BuildContext, int index) {
              return InkWell(
                onTap: (){
                  if(widget.checkAdmin == true){
                    nextScreenReplace(context, AdminOrderDressDetailsScreen(buyDressOrder: dressList[index],refId: refIdList[index]));
                  }else {
                    if(dressList[index].deliveryStatus! == "Completed"){
                      if(dressList[index].rating == "false"){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(courseList:null,coursebut:null,dressModel:dressList[index],type:"Dress",refId: refIdList[index],))).then((value) => {
                        dressList.clear(),
                            refIdList.clear(),
                        _progress = false,
                        setState(() {

                        }),
                        getDataKnow(),
                        });
                      }else {
                        showToast("Your review already submitted");
                      }
                    }

                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 130,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),],
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(image: NetworkImage(dressList[index].dressImg!,),fit: BoxFit.fill)
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text("title : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                              Text(dressList[index].dressTitle!,style: TextStyle(color: Colors.white,fontSize: 9),),
                            ],),
                          Row(children: [
                            Text("Quantity : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                            Text(dressList[index].dressQuantity!,style: TextStyle(color: Colors.white,fontSize: 9),),
                          ],),

                          Row(children: [
                            Text("Size : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                            Text(dressList[index].dressSize!,style: TextStyle(color: Colors.white,fontSize: 9),),
                          ],),


                            Row(children: [
                              Text("Date & Time : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                              Text(dressList[index].date! +", "+dressList[index].time!,style: TextStyle(color: Colors.white,fontSize: 9),),
                            ],),
                            Row(children: [
                              Text("Unit Price : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                              Text("₹ "+dressList[index].dressUnitPrice!,style: TextStyle(color: Colors.white,fontSize: 9),),
                            ],),
                            Row(children: [
                              Text("Net Price : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                              Text("₹ "+dressList[index].netPrice!,style: TextStyle(color: Colors.white,fontSize: 15),),
                            ],),




                            Row(children: [
                              Text("Delivery Status : ",style: TextStyle(color: Colors.grey,fontSize: 11),),
                              InkWell(
                                onTap: (){
                                  if(widget.checkAdmin == true){
                                  nextScreenReplace(context, AdminOrderDressDetailsScreen(buyDressOrder: dressList[index],refId: refIdList[index]));
                                  }else {
                                    if(dressList[index].deliveryStatus! == "Completed"){
                                      if(widget.checkAdmin == "false"){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviewScreen(courseList:null,coursebut:null,dressModel:dressList[index],type:"Dress",refId: refIdList[index],))).then((value) => {
                                          dressList.clear(),
                                          refIdList.clear(),
                                          _progress = false,
                                          setState(() {

                                          }),
                                          getDataKnow(),
                                        });
                                      }else {
                                        showToast("Your review already submitted");
                                      }
                                    }
                                  }

                                },
                                child: Container(child: Shimmer.fromColors(
                                    baseColor: Colors.pink,
                                    highlightColor: Colors.yellow,
                                    child:  Text(dressList[index].deliveryStatus!, style: TextStyle(color: Colors.blue,fontSize: 15))
                                ),),
                              ),
                            ],),

                          ],),)
                      ],
                    ),
                  ),
              );
            })
          : Center(
              child: CircularProgressIndicator(),
            ):Center(child: Text("No Data"),),
    );
  }
}
