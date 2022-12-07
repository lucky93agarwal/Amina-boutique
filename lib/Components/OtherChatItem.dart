import 'package:amin/model/ChatQuestionList.dart';
import 'package:flutter/material.dart';


class OtherChatItem extends StatefulWidget {
  ChatQuestionList listItem;
  OtherChatItem({Key? key,required this.listItem}) : super(key: key);

  @override
  State<OtherChatItem> createState() => _OtherChatItemState();
}

class _OtherChatItemState extends State<OtherChatItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         /* Container(
            height: 40,
            width: 40,

            child: Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black)],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.listItem.adminImg!),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          border:
                          Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                )),
          ),*/
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                ),]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                 /* Text(
                    widget.listItem.adminName!,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color:Colors.blue),
                  ),*/
                  SizedBox(width: 5,),
                  Text(widget.listItem.adminDate!,style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal,color: Colors.blue),),
                  SizedBox(width: 5,),
                  Text(widget.listItem.adminTime!,style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal,color: Colors.blue),),
                ],),
                SizedBox(height: 10,),
                Text(widget.listItem.adminMsg!,style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal,color: Colors.blue)),
              ],
            ),
          )
        ],),
    );
  }
}
