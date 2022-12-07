import 'package:amin/model/ChatQuestionList.dart';
import 'package:flutter/material.dart';


class MyChatItem extends StatefulWidget {
  ChatQuestionList listItem;
  ValueChanged<ChatQuestionList> user;
  MyChatItem({Key? key,required this.listItem,required this.user}) : super(key: key);

  @override
  State<MyChatItem> createState() => _MyChatItemState();
}

class _MyChatItemState extends State<MyChatItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color(0xffe5e5f1),
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                ),]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(widget.listItem.userDate!,style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal,color: Colors.blue),),
                  SizedBox(width: 5,),
                  Text(widget.listItem.userTime!,style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal,color: Colors.blue),),
                ],),
                SizedBox(height: 10,),
                Text(widget.listItem.userMsg!,style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal,color: Colors.black)),
              ],
            ),
          )
        ],),
    );
  }
}
