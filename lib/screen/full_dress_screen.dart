import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/model/prduct_banner.dart';
import 'package:amin/screen/product_big_screen.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:shimmer/shimmer.dart';


class FullDressScreen extends StatefulWidget {
  bool? check;
  FullDressScreen({Key? key,required this.check}) : super(key: key);

  @override
  State<FullDressScreen> createState() => _FullDressScreenState();
}

class _FullDressScreenState extends State<FullDressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getData();
  }
  late List<String>? bookmark = [];
  bool banenrvisit = false;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  ProductBanner homeBannerList = ProductBanner();
  clickBookMark(String id)async{
    final pref = getIt<SharedPreferenceHelper>();
    bookmark = await pref.getDress();
    setState(() {
      if(bookmark!.contains(id)){
        int posifriends = bookmark!.indexOf(id);
        bookmark!.removeAt(posifriends);

      }else {
        bookmark!.add(id);
      }
      pref.saveDress(bookmark!);
    });
  }
  DressModel authgetfriendship = DressModel();
  List<DressModel> dressList = [];
  bool _progressProduct = false;
  List<String> dressRefList = [];
  void getData()async {
    print("Check data full dress screen 45679------");
    final pref = getIt<SharedPreferenceHelper>();
    bookmark = await pref.getDress();


    var resultNew = await FirebaseFirestore.instance
        .collection('dress')
    /*.where('subCategory', isEqualTo: widget.subCategory)*/
        .get()
        .then((value) => {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {

          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              authgetfriendship = DressModel.fromJson(docss[i].data()),
              dressList.add(authgetfriendship),
              dressRefList.add(docss[i].reference.id),
              setState(() {
                dressList;
                _progressProduct = true;
              }),
            }
        }
      else
        {
          setState(() {
            _progressProduct = false;
          }),
          cprint('login message = mobile = false'),
          // showToast("No Data")
        }
    });
    var results = await FirebaseFirestore.instance
        .collection('product_banner')
    /*.where('subCategory', isEqualTo: widget.subCategory)*/
        .get()
        .then((value) =>
    {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {

          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              homeBannerList = ProductBanner.fromJson(docss[i].data()),

              setState(() {
                homeBannerList;
                banenrvisit = true;
              }),
            }
        }
      else
        {
          setState(() {
            banenrvisit = false;
          }),
          cprint('login message = mobile = false'),
          // showToast("No Data")
        }
    });
  }
  ScrollController scrollController = ScrollController();
  List<String> bannerimg_new = ["1",
    "2"];
  final queryPost = FirebaseFirestore.instance.collection('dress').withConverter<DressModel>(fromFirestore:(snapshot,_)=> DressModel.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Container(child: Image.asset(
        "assets/images/icons/iconappbar.png", //delivoo logo
        height: 50,
        width: 50,
      ),),),
      body: RefreshIndicator(
        onRefresh: () async {
          dressList.clear();
          print("Check data full dress screen 45679");
          getData();
          await Future.delayed(Duration(seconds: 2));

          //Do whatever you want on refrsh.Usually update the date of the listview
        },
        child: ListView(children: [

          // Container(width: MediaQuery.of(context).size.width,
          // height: 200,
          // child: SizedBox(
          //   height: 200.0,
          //   width: double.infinity,
          //   child: banenrvisit
          //       ? new CarouselSlider(
          //     options: CarouselOptions(
          //       aspectRatio: 16 / 9,
          //       viewportFraction: 1,
          //       initialPage: 0,
          //       enableInfiniteScroll: true,
          //       reverse: false,
          //       height: 200,
          //       autoPlay: true,
          //       autoPlayInterval: Duration(seconds: 3),
          //     ),
          //     items: bannerimg_new.map((i) {
          //       return Builder(
          //         builder: (BuildContext context) {
          //           return Container(
          //               width:
          //               MediaQuery.of(context).size.width,
          //               margin: EdgeInsets.symmetric(
          //                   horizontal: 5.0),
          //               decoration: BoxDecoration(color: Colors.grey),
          //               child: GestureDetector(child: Image.network(i=="1"?homeBannerList.firstImgUrl!:homeBannerList.secImgUrl!,
          //                   fit: BoxFit.cover),
          //                   onTap: () {
          //                     /*if (i == "1") {
          //                       nextScreen(context,FullDressScreen(check: false));
          //                     }else if (i== "2") {
          //                       nextScreen(context,CourseScreen(adminCheck: false,check: false,));
          //                     }*/
          //                   }));
          //         },
          //       );
          //     }).toList(),
          //   )
          //       : new Row(
          //     children: [
          //       Expanded(
          //         flex: 15,
          //         child: Shimmer.fromColors(
          //             child: Container(
          //               height: 90,
          //               width: double.infinity,
          //               color: Colors.grey,
          //               margin: const EdgeInsets.fromLTRB(
          //                   0, 0, 0, 0),
          //             ),
          //             baseColor: Colors.grey,
          //             highlightColor: Colors.white),
          //
          //       ),
          //       Expanded(
          //         flex: 70,
          //         child: Shimmer.fromColors(
          //             child: Container(
          //               height: 90,
          //               width: double.infinity,
          //               color: Colors.grey,
          //               margin: const EdgeInsets.fromLTRB(
          //                   10, 0, 10, 0),
          //             ),
          //             baseColor: Colors.grey,
          //             highlightColor: Colors.white),
          //
          //       ),
          //       Expanded(
          //         flex: 15,
          //         child: Shimmer.fromColors(
          //             child: Container(
          //               height: 90,
          //               width: double.infinity,
          //               color: Colors.grey,
          //               margin: const EdgeInsets.fromLTRB(
          //                   0, 0, 0, 0),
          //             ),
          //             baseColor: Colors.grey,
          //             highlightColor: Colors.white),
          //
          //       ),
          //     ],
          //   ),
          // ),),
          Align(alignment: Alignment.topLeft,
              child: Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Text("All Products",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))),
          GridView.builder(controller: scrollController,
              shrinkWrap: true,
              itemCount: dressList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3/4,
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),

              itemBuilder: (context,index){
                final user = dressList[index];
                final refId = dressRefList[index];
                return InkWell(
                  onTap: () {
                    if(widget.check == false){

                      nextScreen(context, ProductBigScreen(dressModel: user,ref:refId));
                    }else {
                      Navigator.pop(context,user.id);
                    }
                  },
                  child: Container(
                      height: 200,
                      width: 140,
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 7),
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Color(0xff525252), //                   <--- border color
                          width: 1.0,
                        ),),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          AspectRatio(aspectRatio: 1/1,
                              child:
                              Container(width: 170,height:170,decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                  image: DecorationImage(image: NetworkImage(
                                    user
                                        .imgWhite1!,
                                  ),fit: BoxFit.fill)
                              ),)),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(user.title!.length>= 17?
                                      user.title!.substring(0,17).toUpperCase()+"...":user.title!.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 11, color: Colors.white,fontWeight: FontWeight.bold),
                                    ),

                                    Text(user.details!.length>= 25?
                                    user.details!.substring(0,25).toUpperCase()+"...":user.details!.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 9, color: Colors.grey,fontWeight: FontWeight.bold),
                                    ),
                                    Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                      Text(
                                        "₹ "+user.sPrice!+"                         "  ,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 11, color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),
                                      ),



                                      Visibility(
                                        visible: true,
                                        child: RatingBarIndicator(
                                          rating: user.rating! == ""?0.0: double.parse(user.rating!),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 12.0,
                                          unratedColor: Colors.amber.withAlpha(50),
                                          direction: Axis.horizontal,
                                        ),
                                      ),

                                    ],),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      )),
                );
              }),
          /*FirestoreQueryBuilder<DressModel>(
            query: queryPost,
            builder: (context,snapshot, _){
              print("product size data = "+snapshot.docs.length.toString());
              return GridView.builder(controller: scrollController,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3/4,
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                  itemCount: snapshot.docs.length,
                  itemBuilder: (context,index){
                    final user = snapshot.docs[index].data();
                    final refId = snapshot.docs[index].reference.id;
                    return InkWell(
                      onTap: () {
                        if(widget.check == false){

                          nextScreen(context, ProductBigScreen(dressModel: user,ref:refId));
                        }else {
                          Navigator.pop(context,user.id);
                        }
                      },
                      child: Container(
                          height: 200,
                          width: 140,
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 7),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Color(0xff525252), //                   <--- border color
                              width: 1.0,
                            ),),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              AspectRatio(aspectRatio: 1/1,
                              child:
                              Container(width: 170,height:170,decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                                  image: DecorationImage(image: NetworkImage(
                                    user
                                        .imgWhite1!,
                                  ),fit: BoxFit.fill)
                              ),)),
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Text(
                                          user.title!.toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 11, color: Colors.white,fontWeight: FontWeight.bold),
                                        ),

                                        Text(
                                          user.details!.toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 9, color: Colors.grey,fontWeight: FontWeight.bold),
                                        ),
                                        Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children: [
                                          Text(
                                            "₹ "+user.sPrice!+"                         "  ,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 11, color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),
                                          ),



                                          Visibility(
                                            visible: true,
                                            child: RatingBarIndicator(
                                              rating: user.rating! == ""?0.0: double.parse(user.rating!),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 12.0,
                                              unratedColor: Colors.amber.withAlpha(50),
                                              direction: Axis.horizontal,
                                            ),
                                          ),

                                        ],),

                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  });
            },
          )*/
        ],),
      )
    );
  }
}
