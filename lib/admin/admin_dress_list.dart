import 'package:amin/admin/admin_create_course.dart';
import 'package:amin/admin/admin_create_dress.dart';
import 'package:amin/helper/uitils.dart';
import 'package:amin/model/DressModel.dart';
import 'package:amin/utils/color.dart';
import 'package:amin/utils/next_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminDressListScreen extends StatefulWidget {
  String? category;
  String? cId;

  AdminDressListScreen({Key? key, required this.category,required this.cId}) : super(key: key);

  @override
  State<AdminDressListScreen> createState() => _AdminDressListScreenState();
}

class _AdminDressListScreenState extends State<AdminDressListScreen> {
  String? dressCategory = "";
  String data = 'dgdg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dressCategory = widget.category;
    getData();
  }

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;

  DressModel authgetfriendship = DressModel();
  List<DressModel> dressList = [];
  List<String> refIdList  =[];

  void getData() async {
    cprint(
        'login message =786 categories name = ' + widget.cId.toString());
    var result = await FirebaseFirestore.instance
        .collection('dress')
        .where('category', isEqualTo: widget.cId)
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
                      cprint(
                          'login message =786 value = ' + docss[i].data().toString()),
                      refIdList.add(docss[i].reference.id),
                      dressList.add(authgetfriendship),
                      setState(() {
                        dressList;
                        _progress = true;
                      }),
                    }
                }
              else
                {
                  setState(() {
                    _progressNoData = 2;
                    _progress = false;
                  }),
                  cprint('login message = mobile = false'),
                  showToast("No Data")
                }
            });
  }

  bool _progress = false;
  int _progressNoData = 0;

  showToast(String test) {
    Fluttertoast.showToast(
      msg: test,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: kMainColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  deleteDress(String refId){
    FirebaseFirestore.instance.collection('dress').doc(refId).delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dressCategory!),
        actions: [
          IconButton(onPressed: (){
            nextScreenReplace(context, AdminCreateDressScreen(categoryId:widget.cId,update: false,dressModelUpdateData: null,refId: null,));
          }, icon: Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body: _progress == true ? ListView.builder(
          shrinkWrap: true,
          itemCount: dressList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: (){
                nextScreenReplace(context, AdminCreateDressScreen(categoryId:widget.cId,update: true,dressModelUpdateData: dressList[index],refId: refIdList[index],));
              },
              leading: Container(width: 100,height:125,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(dressList[index].imgWhite1!),fit: BoxFit.fill)),),
              title: Text(dressList[index].title!),
              subtitle: Text(dressList[index].details!),
              trailing: IconButton(onPressed: (){


                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Product').tr(),
                        content: Text('are you sure').tr(),
                        actions: <Widget>[
                          new GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("No",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                          ),
                          SizedBox(height: 16),
                          new GestureDetector(
                            onTap: (){
                              deleteDress(refIdList[index]);
                            },
                            child: Container(padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.blue),child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 12  )).tr()),
                          ),
                          /*FlatButton(
                            child: Text('no').tr(),
                            textColor: kMainColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: kTransparentColor)),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                              child: Text('yes').tr(),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: kTransparentColor)),
                              textColor: kMainColor,
                              onPressed: () {

                                deleteDress(refIdList[index]);

                              })*/
                        ],
                      );
                    });

              }, icon: Icon(Icons.delete,color: Colors.blue,)),
            );
          }): Center(child:_progressNoData ==0? CircularProgressIndicator(): Text("No Data",style: TextStyle(color: Colors.white),),),
    );
  }
}
