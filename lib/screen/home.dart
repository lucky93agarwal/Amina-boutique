import 'dart:ui';

import 'package:amin/admin/admin_couponList.dart';
import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/model/home_banner.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/screen/bookmark_screen.dart';
import 'package:amin/screen/courses.dart';
import 'package:amin/screen/courses_details.dart';
import 'package:amin/screen/full_dress_screen.dart';
import 'package:amin/screen/product_big_screen.dart';
import 'package:amin/screen/splash.dart';
import 'package:amin/screen/video.dart';
import 'package:amin/screen/videoDetailsScreen.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class MasterCategory {
  final String name;
  final String img;
  final String id;

  MasterCategory(this.name, this.img, this.id);

  MasterCategory.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img = json['image'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': img,
    'id': id,
  };
}

class _HomeScreenState extends State<HomeScreen> {
  List<MasterCategory> masterCategory = [];
  List<MasterCategory> desiProductsResponse = [];
  List<MasterCategory> topSearchResponse =[];
  List<MasterCategory> topBestSellsResponse =[];


  String? Name = "Name";
  String? Address = "Address";
  List<String> bannerimgtwo_new=["https://i.pinimg.com/originals/91/a7/d4/91a7d4e5ff72168406b799977c717c0e.jpg",
    "https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg",
    "https://www.athenalifestyle.com/pub/media/catalog/category/banneer_1_.jpg"];

  List<String> dataimageOne = ["https://m.media-amazon.com/images/I/717NujCLerL._UL1500_.jpg",
    "https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg",
    "https://www.athenalifestyle.com/pub/media/catalog/category/banneer_1_.jpg"];
  List<String> dataimageTwo = ["https://i.pinimg.com/originals/91/a7/d4/91a7d4e5ff72168406b799977c717c0e.jpg",
    "https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg",
    "https://www.athenalifestyle.com/pub/media/catalog/category/banneer_1_.jpg"];
  List<String> dataimageBig = ["https://i.pinimg.com/originals/91/a7/d4/91a7d4e5ff72168406b799977c717c0e.jpg",
    "https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg",
    "https://www.athenalifestyle.com/pub/media/catalog/category/banneer_1_.jpg"];


  bool check_cart = false;
  bool banenrvisit = false;
  bool MasterSrim = false;
  bool topsearch = false;
  String countcartitems = "0";
  List<String> bannerimg_new = ["1",
    "2",
    "3"];


  setData()async{
    final pref = getIt<SharedPreferenceHelper>();
    Name = await pref.getUserName();
    Address = await pref.getUserAdd();

    masterCategory.add(MasterCategory("Master1","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","0"));
    masterCategory.add(MasterCategory("Master2","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","1"));
    masterCategory.add(MasterCategory("Master3","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","2"));
    masterCategory.add(MasterCategory("Master4","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","3"));
    masterCategory.add(MasterCategory("Master5","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","4"));

    topBestSellsResponse.add(MasterCategory("top1","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","0"));
    topBestSellsResponse.add(MasterCategory("top2","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","1"));
    topBestSellsResponse.add(MasterCategory("top3","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","2"));
    topBestSellsResponse.add(MasterCategory("top4","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","3"));
    topBestSellsResponse.add(MasterCategory("top5","https://i.pinimg.com/originals/1f/68/2f/1f682f863cf8581baec51c2fb2238df7.jpg","4"));


    topSearchResponse.add(MasterCategory("topSearch1","https://assets.ajio.com/medias/sys_master/root/20210602/x5k4/60b67d86f997ddb312b28ac3/-473Wx593H-441049003-ltpink-MODEL.jpg","0"));
    topSearchResponse.add(MasterCategory("topSearch2","https://cdn.shopify.com/s/files/1/1232/6200/products/13449_7_2000x.jpg?v=1642410435","1"));
    topSearchResponse.add(MasterCategory("topSearch3","https://rukminim2.flixcart.com/image/714/857/k572gsw0/dress/e/u/y/s-maxy-dress-196-black-daevish-original-imafnxw5wwtgjp3q.jpeg?q=50","2"));
    topSearchResponse.add(MasterCategory("topSearch4","https://assets.ajio.com/medias/sys_master/root/20210811/8SyL/61136ce1f997ddce899b4149/-473Wx593H-462764871-blue-MODEL.jpg","3"));
    topSearchResponse.add(MasterCategory("topSearch5","https://assets.ajio.com/medias/sys_master/root/20210327/6I7x/605e5b83f997dd7b6456dded/-1117Wx1400H-462196183-grey-MODEL.jpg","4"));




    desiProductsResponse.add(MasterCategory("desiProducts1","https://cdn.shopify.com/s/files/1/0402/1515/0743/products/2_8_800x.jpg?v=1636644988","0"));
    desiProductsResponse.add(MasterCategory("desiProducts2","https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/productimage/2020/9/16/25f5b6a7-ce25-4e66-8a61-3aa2037b6c741600207614629-1.jpg","1"));
    desiProductsResponse.add(MasterCategory("desiProducts3","https://assets.myntassets.com/h_1440,q_100,w_1080/v1/assets/images/5559085/2018/5/9/11525849854374-Athena-Women-Burgundy-Solid-Maxi-Dress-4291525849853320-1.jpg","2"));
    desiProductsResponse.add(MasterCategory("desiProducts4","https://images.unsplash.com/photo-1566174053879-31528523f8ae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8d29tYW4lMjBkcmVzc3xlbnwwfHwwfHw%3D&w=1000&q=80","3"));
    desiProductsResponse.add(MasterCategory("desiProducts5","https://m.media-amazon.com/images/I/41sqP4NGumL.jpg","4"));
    desiProductsResponse.add(MasterCategory("desiProducts6","https://rukminim1.flixcart.com/image/332/398/knrsjgw0/kurta/o/e/6/s-women-fit-and-flare-multicolor-dress-peach-nd-white-clothomax-original-imag2dz5vwh6hent.jpeg?q=50","5"));
    desiProductsResponse.add(MasterCategory("desiProducts7","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq5LGTJNp0CUrUGyz5ZtvYCk4i9v5UsuBgtA&usqp=CAU","6"));
    desiProductsResponse.add(MasterCategory("desiProducts8","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyM5ahXqYgRbCcFH1fr10JBuLH2yFReTV7zw&usqp=CAU","7"));
    desiProductsResponse.add(MasterCategory("desiProducts9","https://images.bewakoof.com/t320/women-s-all-over-printed-kurti-dress-318487-1638212592-1.jpg","8"));


    check_cart = true;

    MasterSrim = true;
    topsearch = true;
    setState(() {

    });

  }


  @override
  void initState() {
    super.initState();
    setData();
    getData();
    getCourseData();
    getDataVideoList();
    // _accountBloc = BlocProvider.of<AccountBloc>(context);
  }

  bool _progress = false;
  CourseList courselistModel = CourseList();
  List<CourseList> courseVideoList = [];
  List<bool> courseCheckBuy = [];
  List<String> courseCheckCourseId = [];
  List<String> courseRefId = [];
  void getCourseData() async {
    var result = await FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((value) => {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),
          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              courselistModel = CourseList.fromJson(docss[i].data()),
              courseVideoList.add(courselistModel),
              courseRefId.add(docss[i].reference.id),
              courseCheckBuy.add(false),
              courseCheckCourseId.add(courselistModel.cId!),
              setState(() {
                courseVideoList;
              }),
              if (i == value.docs.length - 1)
                {

                  setState(() {
                    _progress = true;
                  }),

                },
              cprint(
                  'login message =786 url = ' + courselistModel.cThum!),
              cprint(
                  'login message =786 url zero = ' + courseVideoList[0].cName!),
            }

          /*showToast("User already exist...")*/
        }
      else
        {
          setState(() {
            _progress = false;
          }),
          cprint('login message = mobile = false'),
          showToast("wrong credentials")
        }
    });
  }



  Widget _buildItemsForListView(BuildContext context, int index) {
    int type = dressList.length > 4 ?4 :dressList.length;
    print("check list data size = "+type.toString());
    if(type == index){
      return InkWell(onTap: (){

        nextScreen(context,FullDressScreen(check: false));
      },child: Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 20),child: Text("All View",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 11),)),));
    }else {

      return InkWell(
        onTap: () {
          nextScreen(context, ProductBigScreen(dressModel: dressList[index],ref:dressRefList[index]));
        },
        child: Container(
            height: 170,
            width: 140,
            margin: const EdgeInsets.fromLTRB(7, 0, 7, 7),
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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

                Container(width: 140,height:120,decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(8.0)),
                    image: DecorationImage(image: NetworkImage(
                      dressList[index]
                          .imgWhite1!,
                    ),fit: BoxFit.fill)
                ),),
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
                          Text(dressList[index].title!.length>= 15?
                          dressList[index].title!.substring(0,15).toUpperCase()+"...": dressList[index].title!.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 10, color: Colors.white,fontWeight: FontWeight.bold),
                          ),

                          Text(dressList[index].details!.length>= 15?
                          dressList[index].details!.substring(0,15).toUpperCase()+"...": dressList[index].details!.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 8, color: Colors.grey,fontWeight: FontWeight.bold),
                          ),
                          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                            Text(
                              "₹ "+dressList[index].sPrice!+"                         "  ,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(fontSize: 10, color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),
                            ),

                            Visibility(
                              visible: true,
                              child: RatingBarIndicator(
                                rating: dressList[index].rating! == ""?0.0: double.parse(dressList[index].rating!),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 9.0,
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
    }

  }

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  DressModel authgetfriendship = DressModel();
  HomeBanner homeBannerList = HomeBanner();
  List<DressModel> dressList = [];
  List<String> dressRefList = [];
  bool _progressProduct = false;
  bool _progressBanner = false;
  void getData()async{

    var results = await FirebaseFirestore.instance
        .collection('home_banner')
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
              homeBannerList = HomeBanner.fromJson(docss[i].data()),

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


    var result = await FirebaseFirestore.instance
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
  }
  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: kMainColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }







  VideoList videomodel = VideoList();
  List<VideoList> videoList = [];
  List<String> refId = [];
  late String videoTitle;
  String thumbnailUrl ="";
  List<String> thumbnailUrlList =[];

  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return "null";
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
  void getDataVideoList() async {
    cprint(
        'login message =786 categories name = ' /*+ widget.categories.toString()*/);
    var result = await FirebaseFirestore.instance
        .collection('video')
    /*.where('categories', isEqualTo: widget.categories)*/
    /*.where('subCategory', isEqualTo: widget.subCategory)*/
        .get()
        .then((value) => {
      cprint(
          'login message =786 value.size = ' + value.size.toString()),
      if (value.size >= 1)
        {
          setState(() {

          }),
          docss = value.docs,
          for (int i = 0; i < value.docs.length; i++)
            {
              videomodel = VideoList.fromJson(docss[i].data()),
              videoList.add(videomodel),
              refId.add(docss[i].reference.id),
              thumbnailUrl = getYoutubeThumbnail(videomodel.url!),
              thumbnailUrlList.add(thumbnailUrl),
              setState(() {
                videoList;
              }),
              cprint(
                  'login message =786 url = ' + videomodel.url!),
              cprint(
                  'login message =786 url zero = ' + videoList[0].url!),
            }

          /*showToast("User already exist...")*/
        }
      else
        {
          setState(() {

          }),
          cprint('login message = mobile = false'),

        }
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = 270;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(child: Image.asset(
          "assets/images/icons/iconappbar.png", //delivoo logo
          height: 50.0,
          width: 50,
        ),),
        actions: [



          IconButton(onPressed: (){
            nextScreen(context,BookMarkScreen());

          }, icon: Icon(Icons.favorite
              ,color: Colors.deepPurpleAccent),),

        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          dressList.clear();
          dressRefList.clear();
          _progressProduct = false;
          setState(() {

          });
          // getData();
          videoList.clear();
          thumbnailUrlList.clear();
          getDataVideoList();
          await Future.delayed(Duration(seconds: 2));

          //Do whatever you want on refrsh.Usually update the date of the listview
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [

                  SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: banenrvisit ? new CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        height: 200,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                      ),
                      items: bannerimg_new.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0),
                                decoration: BoxDecoration(color: Colors.grey),
                                child: GestureDetector(child: Image.network(i=="1"?homeBannerList.firstImgUrl!:
                                i=="2"?homeBannerList.secImgUrl!:
                                /*i=="3"?*/homeBannerList.thirdImgUrl!/*:
                                homeBannerList.fourImgUrl!*/,
                                    fit: BoxFit.cover),
                                    onTap: () {
                                      if (i == "1") {
                                        nextScreen(context,FullDressScreen(check: false));
                                      }else if (i== "2") {
                                        nextScreen(context,CourseScreen(adminCheck: false,check: false,));
                                      }else if (i == "3") {
                                        nextScreen(context,VideoScreen());
                                      }/*else if (i == "4") {
                                        nextScreen(context,VideoScreen());
                                      }*/
                                    }));
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

                  Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              "You order,",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "We deliver",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                              const EdgeInsets.fromLTRB(0, 15, 0, 10),
                              child: Text(
                                "Product",
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.headline4,
                                // style: TextStyle(
                                //     color: Color(0xff000000),
                                //     fontSize: 15,
                                //     fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 1, 10),
                    height: 190,
                    alignment: Alignment.topLeft,
                    child: MasterSrim ? new Stack(
                      children: <Widget>[
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(top: 1),
                            itemCount: dressList.length > 4 ?5:dressList.length+1 ,
                            itemBuilder: _buildItemsForListView),
                      ],
                    ) : new Row(children: [

                      Card(child: Container(
                          height: 140,
                          width: 100,
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).focusColor.withOpacity(0.05),
                                    offset: Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 82,
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 0),
                                    ),
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white),
                              ),
                              Expanded(
                                  flex: 18,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: 20,
                                          width: 80,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  )),
                            ],
                          )),),

                      Card(child: Container(
                          height: 140,
                          width: 100,
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).focusColor.withOpacity(0.05),
                                    offset: Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 82,
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 0),
                                    ),
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white),
                              ),
                              Expanded(
                                  flex: 18,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: 20,
                                          width: 80,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  )),
                            ],
                          )),),

                      Card(child: Container(
                          height: 140,
                          width: 100,
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).focusColor.withOpacity(0.05),
                                    offset: Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 82,
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 0),
                                    ),
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white),
                              ),
                              Expanded(
                                  flex: 18,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: 20,
                                          width: 80,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  )),
                            ],
                          )),),


                    ],),
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(20.0, 15, 0, 5),
                    child: Text(
                      "Course",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 5, 10, 15),
                    child: _progress
                        ? ListView.builder(
                      itemCount: courseVideoList.length,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) { return InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Theme.of(context)
                              .accentColor
                              .withOpacity(0.08),
                          onTap: () {

                            nextScreen(context, CourseDetailsScreen(courseList: courseVideoList[index],adminCheck: false));
                          },

                          child: Container(
                              padding: const EdgeInsets.all(7.0),
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff525252),  //                   <--- border color
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child:Container(height: 125,decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white
                                                  .withOpacity(0.05),
                                              offset: Offset(0, 5),
                                              blurRadius: 5)
                                        ],
                                        image: DecorationImage(image: NetworkImage(
                                          courseVideoList[index].cThum!,
                                        ),fit: BoxFit.cover)
                                    ),),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                        Text(
                                          courseVideoList[index].cName!.length > 30?courseVideoList[index].cName!.substring(0,10):courseVideoList[index].cName!,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,fontWeight: FontWeight.w900),
                                        ),


                                      ],),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Text("₹"+
                                                courseVideoList[index].cPrice!.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.deepPurpleAccent,fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(width: 10,),
                                            Text("₹"+courseVideoList[index].cMRP!.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,

                                              maxLines: 2,
                                              style: TextStyle(
                                                  decoration:
                                                  TextDecoration
                                                      .lineThrough,
                                                  fontSize: 13,
                                                  color: Colors.grey,fontWeight: FontWeight.normal),
                                            ),

                                          ],),
                                          Visibility(
                                            visible: true,
                                            child: RatingBarIndicator(
                                              rating: courseVideoList[index].cRating! == ""?0.0: double.parse(courseVideoList[index].cRating!),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 13.0,
                                              unratedColor: Colors.grey,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ],),

                                    ],
                                  ),
                                ],
                              )));
                      },
                    ) :
                    new Column(children: [
                      Row(children: [
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 200,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),

                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),





                      ],),
                      Row(children: [
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),

                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),





                      ],),
                    ],),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(20.0, 15, 0, 5),
                    child: Text(
                      "Video",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                    child: _progress ? new GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: new List<Widget>.generate(
                          videoList.length >=10?  10:videoList.length, (index) {
                        return new InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.of(context)
                                .accentColor
                                .withOpacity(0.08),
                            onTap: () {
                              nextScreen(context, VideoDetailsScreen(authgetfriendship: videoList[index]));
                            },
                            child:
                            AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    height: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        border: Border.all(
                                          color: Color(0xff525252), //                   <--- border color
                                          width: 1.0,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.05),
                                              offset: Offset(0, 5),
                                              blurRadius: 5)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                    Visibility(
                                    visible: thumbnailUrlList.length ==0 ? false: true,
                                      child:Expanded(
                                          flex: 80,
                                          child: Container(decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(8.0)),
                                              image: DecorationImage(image: NetworkImage(
                                                thumbnailUrlList.length  >0 ? thumbnailUrlList[index]:"",
                                              ),fit: BoxFit.fill)
                                          ),)),),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                            flex: 20,
                                            child: Container(
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  videoList[index].title!.length >20?
                                                  Text(
                                                    videoList[index].title!.substring(0, 20).toUpperCase()+" ...",
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ): Text(
                                                    videoList[index].title!.toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),

                                                  videoList[index].discription!.length >20?
                                                  Text(
                                                    videoList[index].discription!.substring(0, 20).toUpperCase()+" ...",
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.grey),
                                                  ): Text(
                                                    videoList[index].discription!.toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ))
                            )
                        )

                        ;
                      }),
                    ) :
                    new Column(children: [
                      Row(children: [
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),

                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),





                      ],),
                      Row(children: [
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),

                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),





                      ],),
                    ],
                    ),
                  ),
                  InkWell(
                    splashColor:Colors.transparent ,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      nextScreen(context,VideoScreen());
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.fromLTRB(20.0, 0, 15, 5),
                      child: Text("See More",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 11)),
                    ),
                  ),

                  /* Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 5),
                    child: Text(
                      "Top Searched",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),*/

                  /*       Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: topsearch
                        ? new GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: (itemWidth / itemHeight),
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: new List<Widget>.generate(
                          topSearchResponse.length, (index) {
                        return new InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.of(context)
                                .accentColor
                                .withOpacity(0.08),
                            onTap: () {
                         */
                  /*     Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsPage(
                                            P_Id: topSearchResponse[index]
                                                .product_id,
                                            P_name:
                                            topSearchResponse[index].name,
                                            P_description:
                                            topSearchResponse[index]
                                                .description,
                                            P_image1:
                                            "https://desiflea.com/admin/prod_pics/" +
                                                topSearchResponse[index]
                                                    .image1,
                                            P_verShortDesc:
                                            topSearchResponse[index]
                                                .ver_short_desc,
                                            P_verCapacity:
                                            topSearchResponse[index]
                                                .ver_capacity,
                                            P_verUnit:
                                            topSearchResponse[index]
                                                .ver_unit,
                                            P_verPrice:
                                            topSearchResponse[index]
                                                .ver_price,
                                            P_offerPrice:
                                            topSearchResponse[index]
                                                .offer_price,
                                            walletprice: TotalWallet,
                                          )));*/
                  /*
                            },
                            child: Card(
                              child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.05),
                                            offset: Offset(0, 5),
                                            blurRadius: 5)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 80,
                                          child: Container(decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(8.0)),
                                            image: DecorationImage(image: NetworkImage(
                                              topSearchResponse[index]
                                                  .img,
                                            ),fit: BoxFit.fill)
                                          ),)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          flex: 20,
                                          child: Text(
                                            topSearchResponse[index]
                                                .name
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.black),
                                          )),
                                    ],
                                  )),
                            ));
                      }),
                    ) :
                    new Column(children: [
                      Row(children: [
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),

                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),





                      ],),
                      Row(children: [
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),
                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),

                        Expanded(
                          flex: 33,
                          child: Card(child: Container(
                              height: 140,
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.05),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 82,
                                    child: Shimmer.fromColors(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.grey,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.white),
                                  ),
                                  Expanded(
                                      flex: 18,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 20,
                                              width: 80,
                                              color: Colors.grey,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white),
                                      )),
                                ],
                              )),),
                        ),





                      ],),
                    ],),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: SizedBox(
                      height: 100.0,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          height: 100,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                        ),
                        items: bannerimgtwo_new.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                  EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:
                                  BoxDecoration(color: Colors.amber),
                                  child: GestureDetector(
                                      child:
                                      Image.network(i, fit: BoxFit.fill),
                                      onTap: () {
                                        for (int z = 0;
                                        z < bannerimgtwo_new.length;
                                        z++) {
                                          if (bannerimgtwo_new[z] ==
                                              i.toString()) {
                                            if (bannerimgtwo_new.length > z) {

                                             */
                  /* Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailsPage(
                                                            P_Id:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .productId,
                                                            P_name:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .name,
                                                            P_description:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .description,
                                                            P_image1:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .image1,
                                                            P_verShortDesc:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .items[0]
                                                                .verShortDesc,
                                                            P_verCapacity:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .items[0]
                                                                .verCapacity,
                                                            P_verUnit:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .items[0]
                                                                .verUnit,
                                                            P_verPrice:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .items[0]
                                                                .verPrice,
                                                            P_offerPrice:
                                                            productModelBannerImagetwo[
                                                            z]
                                                                .items[0]
                                                                .offerPrice,
                                                            walletprice:
                                                            TotalWallet,
                                                          )));*/
                  /*
                                            }
                                          }
                                        }
                                      }));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),*/

                  // SizedBox(
                  //     height: 150.0,
                  //     width: double.infinity,
                  //     child: Carousel(
                  //       // onImageTap: ,
                  //       images: bannerimgtwo_new,
                  //       dotSize: 4.0,
                  //       dotSpacing: 15.0,
                  //       dotColor: Colors.lightGreenAccent,
                  //       indicatorBgPadding: 5.0,
                  //       dotBgColor: Colors.purple.withOpacity(0.5),
                  //       borderRadius: false,
                  //     )
                  // ),
                  /*Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(24.0, 15, 0, 10),
                    child: Text(
                      "Best Seller",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                      childAspectRatio: (itemWidth / itemHeight),
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: new List<Widget>.generate(
                          topBestSellsResponse.length, (index) {
                        return new InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.of(context)
                                .accentColor
                                .withOpacity(0.08),
                            onTap: () {

                            },
                            child: Card(
                              child: Container(
                                  height: 140,
                                  margin:
                                  const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.05),
                                            offset: Offset(0, 5),
                                            blurRadius: 5)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 80,
                                          child: Image.network(
                                            topBestSellsResponse[index]
                                                .img,
                                            width: 100,
                                            height: double.infinity,
                                          )),
                                      Expanded(
                                          flex: 20,
                                          child: Text(
                                            topBestSellsResponse[index].name,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.black),
                                          )),
                                    ],
                                  )),
                            ));
                      }),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(24.0, 8, 0, 10),
                    child: Text(
                      "",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              */
                  /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsPage(
                                            P_Id: productModelImageOne[0]
                                                .productId,
                                            P_name:
                                            productModelImageOne[0].name,
                                            P_description:
                                            productModelImageOne[0]
                                                .description,
                                            P_image1: productModelImageOne[0]
                                                .image1,
                                            P_verShortDesc:
                                            productModelImageOne[0]
                                                .items[0]
                                                .verShortDesc,
                                            P_verCapacity:
                                            productModelImageOne[0]
                                                .items[0]
                                                .verCapacity,
                                            P_verUnit: productModelImageOne[0]
                                                .items[0]
                                                .verUnit,
                                            P_verPrice:
                                            productModelImageOne[0]
                                                .items[0]
                                                .verPrice,
                                            P_offerPrice:
                                            productModelImageOne[0]
                                                .items[0]
                                                .offerPrice,
                                            walletprice: TotalWallet,
                                          )));*/
                  /*
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: double.infinity,
                              height: 180.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: dataimageOne.length == 0
                                        ? NetworkImage(
                                        'https://picsum.photos/250?image=9')
                                        : NetworkImage(dataimageOne[0])),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                            */
                  /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsPage(
                                            P_Id: productModelImageTwo[0]
                                                .productId,
                                            P_name:
                                            productModelImageTwo[0].name,
                                            P_description:
                                            productModelImageTwo[0]
                                                .description,
                                            P_image1: productModelImageTwo[0]
                                                .image1,
                                            P_verShortDesc:
                                            productModelImageTwo[0]
                                                .items[0]
                                                .verShortDesc,
                                            P_verCapacity:
                                            productModelImageTwo[0]
                                                .items[0]
                                                .verCapacity,
                                            P_verUnit: productModelImageTwo[0]
                                                .items[0]
                                                .verUnit,
                                            P_verPrice:
                                            productModelImageTwo[0]
                                                .items[0]
                                                .verPrice,
                                            P_offerPrice:
                                            productModelImageTwo[0]
                                                .items[0]
                                                .offerPrice,
                                            walletprice: TotalWallet,
                                          )));*/
                  /*
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              width: double.infinity,
                              height: 180.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: dataimageTwo.length == 0
                                        ? NetworkImage(
                                        'https://picsum.photos/250?image=9')
                                        : NetworkImage(dataimageTwo[1])),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: InkWell(
                      onTap: () {
                    */
                  /*    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  P_Id: productModelImageBig[0].productId,
                                  P_name: productModelImageBig[0].name,
                                  P_description:
                                  productModelImageBig[0].description,
                                  P_image1:
                                  productModelImageBig[0].image1,
                                  P_verShortDesc: productModelImageBig[0]
                                      .items[0]
                                      .verShortDesc,
                                  P_verCapacity: productModelImageBig[0]
                                      .items[0]
                                      .verCapacity,
                                  P_verUnit: productModelImageBig[0]
                                      .items[0]
                                      .verUnit,
                                  P_verPrice: productModelImageBig[0]
                                      .items[0]
                                      .verPrice,
                                  P_offerPrice: productModelImageBig[0]
                                      .items[0]
                                      .offerPrice,
                                  walletprice: TotalWallet,
                                )));*/
                  /*
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: double.infinity,
                        height: 180.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: dataimageBig.length == 0
                                  ? NetworkImage(
                                  'https://picsum.photos/250?image=9')
                                  : NetworkImage(dataimageBig[2])),
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/logos/applogo.png"),
              ),
              accountName: Text(Name!),
              accountEmail: Container(
                  child: Text(
                    Address!,
                    maxLines: 2,
                    style: TextStyle(fontSize: 11),
                  )),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text("Order"),
              onTap: () {
               *//* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage()),
                );*//*
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Wallet"),
              onTap: () {
                *//*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WalletHistoryActivity()),
                );*//*
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("Issue with order"),
              onTap: () {
               *//* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RaiseRequestActivity()),
                );*//*
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Referrals"),
              onTap: () {
                *//*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReferPageActivity()),
                );*//*
              },
            ),
            ListTile(
              leading: Icon(Icons.delivery_dining),
              title: Text("Delivery slot"),
              onTap: () {
               *//* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeliverySlot()),
                );*//*
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
              onTap: () {
                *//*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactUsActivity()),
                );*//*
              },
            ),
          ],
        ),
      ),*/
    );
  }
}
