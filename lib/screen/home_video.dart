import 'package:amin/helper/uitils.dart';
import 'package:amin/model/videoCategory.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/screen/video_play.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';


class HomeVideoScreen extends StatefulWidget {
  const HomeVideoScreen({Key? key}) : super(key: key);

  @override
  State<HomeVideoScreen> createState() => _HomeVideoScreenState();
}

class _HomeVideoScreenState extends State<HomeVideoScreen> {
  final queryPost = FirebaseFirestore.instance
      .collection('videoCategory')
      .withConverter<VideoCategory>(
      fromFirestore: (snapshot, _) =>
          VideoCategory.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  String videoId="";
  String thumbnailUrl ="";
  List<String> thumbnailUrlList =[];
  void getData() async {
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
          cprint(
              'video  login message =786 video length = ' +  value.docs.length.toString()),
          for (int i = 0; i < value.docs.length; i++)
            {
              authgetfriendship = VideoList.fromJson(docss[i].data()),
              videoList.add(authgetfriendship),
              refId.add(docss[i].reference.id),
              thumbnailUrl = getYoutubeThumbnail(authgetfriendship.url!),
              thumbnailUrlList.add(thumbnailUrl),
              setState(() {
                videoList;
              }),

              cprint(
                  'login message =786 url = ' + authgetfriendship.url!),
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
  List<String> refId = [];
  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return "null";
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
  VideoList authgetfriendship = VideoList();
  List<VideoList> videoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Categories",
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30, margin: const EdgeInsets.only(bottom: 0,left: 20),
                      child: FirestoreListView<VideoCategory>(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          query: queryPost,
                          itemBuilder: (context, snapshot) {
                            final user = snapshot.data();


                            return InkWell(
                              onTap: () {
                                nextScreen(
                                    context,
                                    VideoPlayScreen(
                                      subCategory: "user.title!",
                                      categories: user.title!,
                                      check: false,
                                      cId: user.id,
                                    ));
                              },
                              child: Container(height: 10,margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Color(0xff7b7b7b),width: 1)
                                ),
                                child: Center(child: Text(user.title!,style: TextStyle(color: Colors.white,fontSize: 10),),),),
                            );
                          }),
                    ),
                  ],),
                ), //Text
                background: Image.network(
                  "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
                  fit: BoxFit.cover,
                ) //Images.network
            ),
            expandedHeight: 230,
            backgroundColor: Colors.transparent,
            leading:  Center(child: Image.asset("assets/images/icons/iconappbar.png",width: 170,height: 50,)), //IconButton

          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
                title: Center(
                  child: Text('$index',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 50,
                          color: Colors.greenAccent[400]) //TextStyle
                  ), //Text
                ), //Center
              ), //ListTile
              childCount: 51,
            ), //SliverChildBuildDelegate
          )
        ],
      ),
    );
  }
}
