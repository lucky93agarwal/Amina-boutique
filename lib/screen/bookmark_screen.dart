import 'package:amin/common/locator.dart';
import 'package:amin/helper/shared_preference_helper.dart';
import 'package:amin/model/BookMark.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/screen/product_big_screen.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';


class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  List<String>? bookmark = [];
  DressModel authgetfriendship = DressModel();
  List<DressModel> dressList = [];
  List<String> refIdList  =[];
  var queryPosts;
  late bool _progress = false;
  late bool checknodata = false;
  String? UserId = "";
  late BookMark bookModel;
  getData() async{
    final pref = getIt<SharedPreferenceHelper>();
    UserId = await pref.getUserId();
    var resultBook = await FirebaseFirestore.instance
        .collection('Bookmark')
        .where('userId', isEqualTo: UserId).get()
        .then((value) => {
      print("check data but ornot    =  "+value.size.toString()+", user_id   =  "+UserId.toString()),
      if (value.size >= 1)
        {
          bookModel = BookMark.fromJson(value.docs[0].data()),
          bookmark!.addAll(bookModel.dressId!)
        }

    });
    print("Bookmark   check book lsit size  = "+bookmark.toString());
    if(bookmark!.length >0){
      var result = await FirebaseFirestore.instance
          .collection('dress')
          .get()       .then((value) => {

        print("Bookmark   check lsit size  = "+value.size.toString()),
        if (value.size >= 1)
          {

            docss = value.docs,
            for (int i = 0; i < value.docs.length; i++)
              {

                authgetfriendship = DressModel.fromJson(docss[i].data()),
                if(bookmark!.contains(authgetfriendship.id)){
                  refIdList.add(docss[i].reference.id),
                  dressList.add(authgetfriendship),
                  setState(() {
                    dressList;
                    _progress = true;
                  }),
                }
              }


            /*showToast("User already exist...")*/
          }
        else
          {
            setState(() {

              _progress = true;
            }),
          }
      });
    }else{

      setState(() {
        checknodata = true;
        _progress = true;
      });
    }

    setState(() {

    });

  }

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
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(title: Text("Wishlist"),),
      body: _progress == false? Center(child: CircularProgressIndicator(),): checknodata == true?  Center(child: Text("No data"),):Container(width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 350,
        margin: const EdgeInsets.fromLTRB(15, 5, 10, 15),
        child:new GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: new List<Widget>.generate(
              dressList.length, (index) {
            return new InkWell(
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context)
                    .accentColor
                    .withOpacity(0.08),
                onTap: () {

                  nextScreen(context, ProductBigScreen(dressModel: dressList[index],ref:refIdList[index]));
                },
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
                        Expanded(
                            flex: 80,
                            child: Container(decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                image: DecorationImage(image: NetworkImage(
                                  dressList[index].imgWhite1!,
                                ),fit: BoxFit.fill)
                            ),)),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            flex: 20,
                            child: Text(
                              dressList[index].title!.toUpperCase(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white),
                            )),
                      ],
                    )));
          }),
        ) ,),
    );
  }
}
