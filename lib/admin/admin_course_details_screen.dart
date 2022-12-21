import 'package:amin/helper/uitils.dart';
import 'package:amin/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AdminCourseDetailsScreen extends StatefulWidget {
  String? cName;
  String? cId;
  String? cPaidPrice;
  String? DateTime;
  String? userId;
  AdminCourseDetailsScreen({Key? key, required this.cName,required this.cId,required this.cPaidPrice,required this.DateTime,required this.userId}) : super(key: key);

  @override
  State<AdminCourseDetailsScreen> createState() => _AdminCourseDetailsScreenState();
}

class _AdminCourseDetailsScreenState extends State<AdminCourseDetailsScreen> {


  String cThum = "",cPrice = "",cMRP = "",cPaidPrice="",uName = "",uMobile = "",uEmail = "",uCountry="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docss;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> docssf;
  getData() async{
    var results = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: widget.userId)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {

          docssf = value.docs,
          cprint('login message = reference id = ' +
              docssf[0].reference.id),
          uName = docssf[0].data()["name"],
          uMobile = docssf[0].data()["mobile"],
          uEmail = docssf[0].data()["email"],
          uCountry = docssf[0].data()["country"],
          setState(() {
            _progress = false;
            uName;
            uMobile;
            uEmail;
            uCountry;
          }),

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
    var result = await FirebaseFirestore.instance
        .collection('courses')
        .where('cId', isEqualTo: widget.cId)
        .limit(1)
        .get()
        .then((value) => {
      if (value.size >= 1)
        {
          setState(() {
            _progress = false;
          }),
          docss = value.docs,
          cprint('login message = reference id = ' +
              docss[0].reference.id),
          cThum = docss[0].data()["cThum"],
          cPrice = docss[0].data()["cPrice"],
          cMRP = docss[0].data()["cMRP"],

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
  bool _progress = false;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cName!),

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Container(width: MediaQuery
              .of(context)
              .size
              .width,
            height: 220,
            color: kMainColor,
            child: InkWell(
              onTap: () {
              },
              child: Stack(children: [
                Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  decoration: BoxDecoration(image: DecorationImage(
                      image: NetworkImage(cThum),
                      fit: BoxFit.fill)),),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 220,
                  color: Colors.black.withOpacity(0.35),
                ),
                Center(child: Icon(
                  Icons.play_circle_fill, color: Colors.white, size: 50,))
              ],),
            ),),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10), child: SizedBox(width: MediaQuery
              .of(context)
              .size
              .width * 0.5,
              child: Text(widget.cName!, style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900),)),),
          Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text("Prices", style: TextStyle(color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900),),),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text("₹",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 15,
                        color: _progress == true ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(cPrice.toUpperCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 25,
                        color: _progress == true ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.w900),
                  ),

                  SizedBox(width: 10,),
                  Text("M.R.P.: ",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,

                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                  Text("₹" + cMRP!.toUpperCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,

                    maxLines: 2,
                    style: TextStyle(
                        decoration:
                        TextDecoration
                            .lineThrough,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.solid,
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),



                ],),
                // Visibility(
                //   visible: true,
                //   child: RatingBarIndicator(
                //     rating: _courseList.cRating! == "" ? 0.0 : double.parse(
                //         _courseList.cRating!),
                //     itemBuilder: (context, index) =>
                //         Icon(
                //           Icons.star,
                //           color: Colors.amber,
                //         ),
                //     itemCount: 5,
                //     itemSize: 18.0,
                //     unratedColor: Colors.amber.withAlpha(50),
                //     direction: Axis.horizontal,
                //   ),
                // ),
              ],
            ),),

          Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text("Paid Amount", style: TextStyle(color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900),),),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text("₹",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 15,
                        color: _progress == true ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(widget.cPaidPrice!.toUpperCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 25,
                        color: _progress == true ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.w900),
                  ),





                ],),

              ],
            ),),


          Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text("Date & Time", style: TextStyle(color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900),),),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(widget.DateTime!.toUpperCase(),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),),

          Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text("User Info", style: TextStyle(color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900),),),


          Container(margin: const EdgeInsets.fromLTRB(30, 0, 20, 10),
            child: Row(
              children: [
                Text("Name : ", style: TextStyle(color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),),

                Text(uName,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),),
          Container(margin: const EdgeInsets.fromLTRB(30, 0, 20, 10),
            child: Row(
              children: [
                Text("Mobile : ", style: TextStyle(color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),),

                Text(uMobile,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),),
          Container(margin: const EdgeInsets.fromLTRB(30, 0, 20, 10),
            child: Row(
              children: [
                Text("Email : ", style: TextStyle(color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),),

                Text(uEmail,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),),
          Container(margin: const EdgeInsets.fromLTRB(30, 0, 20, 10),
            child: Row(
              children: [
                Text("Country : ", style: TextStyle(color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),),

                Text(uCountry.length >0?uCountry:"India",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),),


        ],),
      ),
    );
  }
}
