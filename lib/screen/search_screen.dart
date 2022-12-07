import 'package:amin/Components/entry_fields.dart';
import 'package:amin/admin/admin_create_course.dart';
import 'package:amin/admin/admin_profile.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/course_list.dart';
import 'package:amin/model/video_list.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';



class SearchScreen extends StatefulWidget {
  String? title;
  bool? checkAdmin;
  SearchScreen({Key? key,required this.checkAdmin,required this.title}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String? titleName;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleName = widget.title;

  }

  late Query<VideoList> queryPost;
  late Query<CourseList> queryPostCourses;

  searchCorses(String word)async {
    cprint("check total crater in title   "+word);
    queryPostCourses = FirebaseFirestore.instance.collection("courses").where('cName', isGreaterThanOrEqualTo:word).where('cName', isLessThanOrEqualTo:word+"\uf7ff").withConverter<CourseList>(fromFirestore:(snapshot,_)=> CourseList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());

    setState(() {
      checkdata = true;
    });

  }


  searchVideo(String word)async {
    cprint("check total crater in title   "+word);
    queryPost = FirebaseFirestore.instance.collection("video").where('title', isGreaterThanOrEqualTo:word).where('title', isLessThanOrEqualTo:word+"\uf7ff").withConverter<VideoList>(fromFirestore:(snapshot,_)=> VideoList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());

    setState(() {
      checkdata = true;
    });

  }
 // final queryPost = FirebaseFirestore.instance.collection("video").where('categories', isEqualTo:" _searchController.text").withConverter<VideoList>(fromFirestore:(snapshot,_)=> VideoList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());

 // final queryPostCourses = FirebaseFirestore.instance.collection("courses").where('categories', isEqualTo:" _searchController.text").withConverter<VideoList>(fromFirestore:(snapshot,_)=> VideoList.fromJson(snapshot.data()!), toFirestore: (user,_)=>user.toJson());
  final TextEditingController _searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  bool checkdata = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Search Screen").tr(),
        actions: [
          widget.checkAdmin == true? IconButton(onPressed: (){
            nextScreen(context, AdminCreateCourseScreen(admin: false,courseList: null,refId:null));
          }, icon: Icon(Icons.add,color: Colors.white,)):Container()
        ],
      ),
      body: ListView(
        controller: _scrollController,
        children: [
        SizedBox(height: 20,),
        Stack(
          children: [
            EntryField(
              controller: _searchController,
              label: 'Find something..',
              image: 'assets/images/icons/ic_search.png',
              keyboardType: TextInputType.emailAddress,
              maxLength: null,
              readOnly: false,
              hint: 'Find something..',
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  onTap: (){
                    if(widget.title == "courses"){
                      searchCorses(_searchController.text);
                    }else {
                      searchVideo(_searchController.text);
                    }

                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
          ],
        ),

        checkdata == true? widget.title == "courses"? FirestoreListView<CourseList>(
            controller: _scrollController,
            query: queryPostCourses,
            shrinkWrap: true,
            itemBuilder: (context,snapshot){
              final user = snapshot.data();
              return ListTile(
                onTap: (){
                  // nextScreen(context, AdminProfileScreen(userlist:user));
                },
                leading: Container(width: 100,height: 250,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(user.cThum!),fit: BoxFit.fill)),),
                /*leading: CircleAvatar(backgroundImage: NetworkImage(user.cThum!),),*/
                title: Text(user.cName!,style: Theme.of(context).textTheme.headline2,),
                subtitle: Text(user.cDetails!.substring(0,100)),
              );
            }
        ) : FirestoreListView<VideoList>(
            controller: _scrollController,
            query: queryPost,
            shrinkWrap: true,
            itemBuilder: (context,snapshot){
              final user = snapshot.data();
              return ListTile(
                onTap: (){
                  // nextScreen(context, AdminProfileScreen(userlist:user));
                },
                leading: Container(width: 100,height: 250,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(user.url!),fit: BoxFit.fill)),),
                /*leading: CircleAvatar(backgroundImage: NetworkImage(user.cThum!),),*/
                title: Text(user.title!,style: Theme.of(context).textTheme.headline2,),
                subtitle: Text(user.discription!,overflow: TextOverflow.ellipsis,),
              );
            }
        ):Container()
      ],),
    );
  }
}
