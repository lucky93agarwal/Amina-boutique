import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/model/BookMark.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/model/RatingModel.dart';
import 'package:amin/screen/add_review_list_screen.dart';
import 'package:amin/screen/cartview_screen.dart';
import 'package:amin/screen/order_screen.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';


class ProductBigScreen extends StatefulWidget {
  DressModel? dressModel;
  String? ref;
  ProductBigScreen({Key? key,required this.dressModel,required this.ref}) : super(key: key);

  @override
  State<ProductBigScreen> createState() => _ProductBigScreenState();
}

class _ProductBigScreenState extends State<ProductBigScreen> {
  DressModel? dressModel;
  List<String> image = [];
  bool banenrvisit = false;
  String? totalPrice = "0";
  String? unitPrice = "0";
  String? mSize = "0";
  String? lSize = "0";
  String? sizeName = "";
  String? sizeStockKey = "";
  int? sizeStockValue = 0;
  int stock = 1;
  int sizeVisibility = 0;

  String? productId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dressModel =widget.dressModel;
    productId = widget.dressModel!.id;
    image.add(dressModel!.imgWhite1!);
    image.add(dressModel!.imgWhite2!);
    totalPrice = dressModel!.sPrice!;
    sizeName = dressModel!.sname;
    sizeStockKey = "SStock";
    sizeStockValue = int.parse(dressModel!.smrp!);
    unitPrice = totalPrice;
    stock = int.parse(dressModel!.smrp!);
    banenrvisit = true;
    sizeVisibility = checkVisibility();
    print("sizeVisibility  =  "+sizeVisibility.toString());

    getData();
  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  bool? _progress = false;
  late RatingModel model;
  late BookMark bookModel;
  List<RatingModel> productList = [];
  late List<String>? bookmark = [];
  clickBookMark(String id)async{
   /* final pref = getIt<SharedPreferenceHelper>();*/
/*    bookmark = await pref.getDress();*/
    setState(() {
      if(bookmark!.contains(id)){
        int posifriends = bookmark!.indexOf(id);
        bookmark!.removeAt(posifriends);

      }else {
        bookmark!.add(id);
      }
   //   pref.saveDress(bookmark!);
    });


    var resultOrder = await FirebaseFirestore.instance
        .collection('Bookmark')
        .where('userId', isEqualTo: UserId).get()
        .then((value) => {
      print("get book mark data   =     =  "+value.size.toString()+", bookmark id  =  "+bookmark.toString()+", user_id   =  "+UserId.toString()),
      if (value.size >= 1)
        {
          insertData(value.docs[0].reference.id,true)
        }else{
        insertData("",false)
      }

    });
  }
  insertData(String refId,bool checkt)async {
    if(checkt == true){

      // update
      bookModel = BookMark(userId:UserId,
          dressId:bookmark);
      FirebaseFirestore.instance.collection('Bookmark').doc(refId).update(bookModel.toJson());

    }else{
      // insert
      bookModel = BookMark(userId:UserId,
          dressId:bookmark);
      FirebaseFirestore.instance.collection('Bookmark').add(bookModel.toJson());
    }

  }
  String? UserId = "";
  bool? checkBuy_or_not = false;
  getData()async {
    final pref = getIt<SharedPreferenceHelper>();
   /* bookmark = await pref.getDress();*/
    UserId = await pref.getUserId();

    var resultBook = await FirebaseFirestore.instance
        .collection('Bookmark')
        .where('userId', isEqualTo: UserId).get()
        .then((value) => {
      print("get book mark data   =  "+value.size.toString()+", product id  =  "+productId.toString()+", user_id   =  "+UserId.toString()),
      if (value.size >= 1)
        {
          bookModel = BookMark.fromJson(value.docs[0].data()),
          bookmark!.addAll(bookModel.dressId!)
        }

    });
    var resultOrder = await FirebaseFirestore.instance
        .collection('BuyDress')
        .where('dress_id', isEqualTo: productId)
        .where('user_id', isEqualTo: UserId)
        .get()
        .then((value) => {
      print("check data but ornot    =  "+value.size.toString()+", product id  =  "+productId.toString()+", user_id   =  "+UserId.toString()),
    if (value.size >= 1)
    {
      setState((){
        checkBuy_or_not = true;
      })
    }

    });
    var result = await FirebaseFirestore.instance
        .collection('Ratings')
        .where('productId', isEqualTo: productId)
        .where('type', isEqualTo: "Dress")
        .get()
        .then((value) => {

      print("check data type length    =  "+value.size.toString()+", product id  =  "+productId.toString()),
      if (value.size >= 1)
        {
          setState(() {
            _progress = true;
          }),
          docss = value.docs,
          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              model = RatingModel.fromJson(docss[i].data()),
              productList.add(model),

              setState(() {
                productList;
                _progress = true;
              }),
            }
        }
      else
        {
          setState(() {
            _progress = false;
          }),
        }
    });
  }
  int clickbuttonSizeCheck = 1;

  int totalquantity= 1;
  final ScrollController _scrollController = ScrollController();

int checkVisibility(){
  int count = 0;
  if(dressModel?.sSize != "0")
    count++;
  if(dressModel?.mSize != "0")
    count++;
  if(dressModel?.lSize != "0")
    count++;
  if(dressModel?.xLSize != "0")
    count++;
  if(dressModel?.xxLxSize != "0")
    count++;
  if(dressModel?.xxxLxSize != "0")
    count++;
  if(dressModel?.sxSize != "0")
    count++;
  if(dressModel?.mxSize != "0")
    count++;
  return count;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        ListView(   controller: _scrollController,children: [

          SizedBox(
            height: 250.0,
            width: double.infinity,
            child: banenrvisit
                ? new CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                height: 250,
                autoPlay: false,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: image.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),

                        decoration: BoxDecoration(color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(image: NetworkImage(i),fit: BoxFit.fill)),
                        );
                  },
                );
              }).toList(),
            )
                : new Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Shimmer.fromColors(
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        color: Colors.grey,
                        margin: const EdgeInsets.fromLTRB(
                            0, 0, 0, 0),
                      ),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white),

                ),
                Expanded(
                  flex: 70,
                  child: Shimmer.fromColors(
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        color: Colors.grey,
                        margin: const EdgeInsets.fromLTRB(
                            10, 0, 10, 0),
                      ),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white),

                ),
                Expanded(
                  flex: 15,
                  child: Shimmer.fromColors(
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        color: Colors.grey,
                        margin: const EdgeInsets.fromLTRB(
                            0, 0, 0, 0),
                      ),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white),

                ),
              ],
            ),
          ),
          Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dressModel!.title!.length > 25?dressModel!.title!.substring(0,25)+"...":dressModel!.title!,
                  style: TextStyle(color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),

                Visibility(
                  visible: true,
                  child: InkWell(onTap: (){
                    clickBookMark(dressModel!.id!);




                  },child: Container(width: 23,height: 30,child: bookmark!.contains(dressModel!.id!) ? Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite_border,color: Color(0xff777777),))),
                )
              ],
            ),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: stock > 0 ?Colors.green:Colors.red
                ),
                child: Text(stock > 0 ?"Available in stock":"Out of stock",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),),),


              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: RatingBarIndicator(
                  rating: dressModel!.rating! == ""?0.0: double.parse(dressModel!.rating!),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  unratedColor: Colors.amber.withAlpha(50),
                  direction: Axis.horizontal,
                ),
              ),
              

            ],
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Unit Price",
                      style: TextStyle(color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                    Text("₹ "+unitPrice!+".00",
                      style: TextStyle(color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),),
                  ],),
                ),

                Visibility(
                  visible: stock > 0?true:false,
                  child: Container(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quantity",
                        style: TextStyle(color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(children: [
                        InkWell(
                          onTap:(){
                            setState(() {
                              if(totalquantity > 1){
                                totalquantity = totalquantity -1;
                                int total = totalquantity * int.parse(unitPrice!);
                                totalPrice = total.toString();
                              }
                            });
                          },
                          child: Container(width: 35,height: 35,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(width: 1.0,color: Color(0xff525252))),
                            child: Center(child: Text("-",style: TextStyle(color: Colors.white,fontSize: 20),),),),
                        ),


                        Container(width: 35,height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(width: 1.0,color: Colors.transparent)),
                          child: Center(child: Text(totalquantity.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),),),

                        InkWell(
                          onTap:(){
                            setState(() {

                              if(stock != totalquantity){
                                totalquantity = totalquantity +1;
                                int total = totalquantity * int.parse(unitPrice!);
                                totalPrice = total.toString();
                              }

                            });
                          },
                          child: Container(width: 35,height: 35,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(width: 1.0,color: Color(0xff525252))),
                            child: Center(child: Text("+",style: TextStyle(color: Colors.white,fontSize: 20),),),),
                        ),

                      ],),
                    ],
                  ),),
                )
              ],
            ),
          ),
          Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text("Product Info",
              style: TextStyle(color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),),),
          Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(dressModel!.details!,
              style: TextStyle(color: Colors.grey,
                  fontSize: 13),),),

          Visibility(
            visible:  sizeVisibility == 1?false:true,
            child: Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text("Product Size",
                style: TextStyle(color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),),),
          ),

          Visibility(
            visible:  sizeVisibility == 1?false:true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(children: [
                Visibility(
                  visible: dressModel!.sSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =1;
                        totalPrice = dressModel!.sPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.sname!;
                        sizeStockKey = "SStock";
                        sizeStockValue = int.parse(dressModel!.smrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.smrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.sSize == "0"? Colors.transparent:clickbuttonSizeCheck ==1?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.sSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.sname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.mSize == "0" /*&& sizeVisibility < 1*/?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =2;
                        totalPrice = dressModel!.mPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.mname!;
                        sizeStockKey = "MStock";
                        sizeStockValue = int.parse(dressModel!.mmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.mmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.mSize == "0"? Colors.transparent:clickbuttonSizeCheck ==2?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.mSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.mname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.lSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =3;
                        totalPrice = dressModel!.lPrice!;
                        sizeName = dressModel!.lname!;
                        sizeStockKey = "LStock";
                        sizeStockValue = int.parse(dressModel!.lmrp!);
                        unitPrice = totalPrice;
                        totalquantity=1;
                        stock = int.parse(dressModel!.lmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.lSize == "0"? Colors.transparent:clickbuttonSizeCheck ==3?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.lSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.lname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.xLSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =4;
                        totalPrice = dressModel!.xLPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.xlname!;
                        sizeStockKey = "XLStock";
                        sizeStockValue = int.parse(dressModel!.xlmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.xlmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.xLSize == "0"? Colors.transparent:clickbuttonSizeCheck ==4?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.xLSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.xlname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
              ],),
            ),
          ),

          Visibility(
            visible:  sizeVisibility == 1?false:true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(children: [
                Visibility(visible: dressModel!.sxSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =5;
                        totalPrice = dressModel!.sxPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.sxname!;
                        sizeStockKey = "SxStock";
                        sizeStockValue = int.parse(dressModel!.sxmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.sxmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.sxSize == "0"? Colors.transparent:clickbuttonSizeCheck ==5?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.sxSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.sxname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.mxSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =6;
                        totalPrice = dressModel!.mxPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.mxname!;
                        sizeStockKey = "MxStock";
                        sizeStockValue = int.parse(dressModel!.mxmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.mxmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.mxSize == "0"? Colors.transparent:clickbuttonSizeCheck ==6?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.mxSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.mxname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.lxSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =7;
                        totalPrice = dressModel!.lxPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.lxname!;
                        sizeStockKey = "LxStock";
                        sizeStockValue = int.parse(dressModel!.lxmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.lxmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.lxSize == "0"? Colors.transparent:clickbuttonSizeCheck ==7?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.lxSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.lxname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.xLxSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =8;
                        totalPrice = dressModel!.xLxPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.xlxname!;
                        sizeStockKey = "XLxStock";
                        sizeStockValue = int.parse(dressModel!.xlxmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.xlxmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.xLxSize == "0"? Colors.transparent:clickbuttonSizeCheck ==8?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.xLxSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.xlxname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
              ],),
            ),
          ),

          Visibility(
            visible:  sizeVisibility == 1?false:true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(children: [
                Visibility(visible: dressModel!.xxLxSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =9;
                        totalPrice = dressModel!.xxLxPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.xxlxname!;
                        sizeStockKey = "xXLxStock";
                        sizeStockValue = int.parse(dressModel!.xxlxmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.xxlxmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.xxLxSize == "0"? Colors.transparent:clickbuttonSizeCheck ==9?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.xxLxSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.xxlxname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
                Visibility(visible: dressModel!.xxxLxSize == "0"?false:true,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        clickbuttonSizeCheck =10;
                        totalPrice = dressModel!.xxxLxPrice!;
                        unitPrice = totalPrice;
                        sizeName = dressModel!.xxxlxname!;
                        sizeStockKey = "xxXLxStock";
                        sizeStockValue = int.parse(dressModel!.xxxlxmrp!);
                        totalquantity=1;
                        stock = int.parse(dressModel!.xxxlxmrp!);
                      });
                    },
                    child: Container(width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      decoration: BoxDecoration(
                        color: dressModel!.xxxLxSize == "0"? Colors.transparent:clickbuttonSizeCheck ==10?Colors.blue: Colors.green,
                        border: Border.all(
                          width: 1,
                          color: dressModel!.xxxLxSize == "0"? Colors.green: Colors.green,
                        ),
                      ),
                      child: Center(child: Text(dressModel!.xxxlxname!,style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 09,
                      ),),),),
                  ),
                ),
              ],),
            ),
          ),

          Visibility(
            visible: _progress!,
            child: Container( margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Text("Add Review",style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),),),
          ),

          Visibility(
            visible: _progress!,
            child: Container( margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("User reviews",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 11,
                ),),

                Visibility(
                  visible: /*productList.length >5 ?*/ true/* : false*/,
                  child: InkWell(
                    onTap: (){

                      nextScreen(context, AddReviewListScreen(productList: productList));
                    },
                    child: Text("All view",
                      style: TextStyle(color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),),
                  ),
                ),
              ],),),
          ),

          Visibility(
            visible: _progress!,
            child: Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: ListView.builder(shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: productList.length >5 ?5:productList.length,
                  itemBuilder: (BuildContext context,int index){
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0xff222328),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(
                  blurRadius: 3.0,
                  color: Color(0xFF616161),
                  spreadRadius: 1,
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
            }),),
          ),

          Visibility(
            visible: checkBuy_or_not!,
            child: Container( margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" ",style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 11,
                  ),),

                  Visibility(
                    visible: /*productList.length >5 ?*/ true/* : false*/,
                    child: InkWell(
                      onTap: (){

                        nextScreen(context, OrderScreen(checkAdmin: false,));
                      },
                      child: Text("Add Review",
                        style: TextStyle(color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),),
                    ),
                  ),
                ],),),
          ),
          SizedBox(height: 100,),
        ],),
        Visibility(
          visible: stock > 0? true:false,
          child: Align(alignment: Alignment.bottomCenter,
          child: Container(width: MediaQuery.of(context).size.width,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),


          decoration: BoxDecoration(
            color: Color(0xff7b61ff),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Row(children: [
            Expanded(flex: 6,child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("₹ "+totalPrice!+".00",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                  Text("Total price ",style: TextStyle(color: Color(0xffc2b6ff),fontSize: 12),),
              ],),
            )),
            Expanded(flex: 4,child: InkWell(
              onTap: (){
                nextScreen(context, CartViewScreen(
                    dressModel:dressModel,
                    totalPrice: totalPrice.toString(),
                    unitPrice:unitPrice.toString(),
                    totalquantity:totalquantity,
                    sizeName:sizeName,
                stockKey:sizeStockKey,
                stockValue:sizeStockValue,
                ref: widget.ref)
                );

              },
              child: Container(


                decoration: BoxDecoration(
                  color: Color(0xff6953d9),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
                ),
                child: Center(child:     Text("Add To Cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
              ),
            ))
          ],),),),
        )
      ],),
    );
  }
}
