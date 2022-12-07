import 'package:amin/model/UserList.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class AdminProfileScreen extends StatefulWidget {
  UserList? userlist;
  AdminProfileScreen({Key? key,required this.userlist}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  UserList? userlistNew;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userlistNew = widget.userlist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(shrinkWrap:true,children: [
          SizedBox(height: 20,),
          Row(children: [
            SizedBox(width: 5,),
            Container(width: 70,height: 70,

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.grey,
                      spreadRadius: 3,
                      offset: Offset(
                        1,
                        1,
                      ),
                    ),
                  ],
                  image: DecorationImage(image: NetworkImage(userlistNew!.image!),fit: BoxFit.cover)
              ),),
            Container(margin:const EdgeInsets.symmetric(horizontal: 10),child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
              Text(userlistNew!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text(userlistNew!.mobile!),
            ],),)
          ],),
          SizedBox(height: 10,),

          ListTile(
            onTap: (){
            },
            title: Text('Q10',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.name!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),
          ListTile(
            onTap: (){
              // Mobile No
            },
            title: Text('Q11',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text('+91 '+userlistNew!.mobile!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),
          ListTile(
            onTap: (){
              // Email
            },
            title: Text('Q12',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.email!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),

          ListTile(
            onTap: (){
              // Address
            },
            title: Text('Q14',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.address!.length>15?userlistNew!.address!.substring(0, 14)+"...":userlistNew!.address!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),

          ListTile(
            onTap: (){
              // City
            },
            title: Text('A14',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.city!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),

          ListTile(
            onTap: (){
              // State
            },
            title: Text('Q15',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.state!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),

          ListTile(
            onTap: (){
              // Country Selection
            },
            title: Text('A15',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.country!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),

          ListTile(
            onTap: (){
              // Pin Code
            },
            title: Text('Q16',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.pincode!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),
          ListTile(
            onTap: (){
              // DOB
            },
            title: Text('A10',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.dob!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),

          Divider(height: 1,color: Colors.grey,),
          ListTile(
            onTap: (){
              // Gender
            },
            title: Text('A11',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.gender!,style:
            Theme.of(context).textTheme.headline2).tr(),
          ),
          Divider(height: 1,color: Colors.grey,),
          ListTile(
            onTap: (){
              // Password
            },
            title: Text('A12',style:
            Theme.of(context).textTheme.subtitle1).tr(),
            trailing: Text(userlistNew!.pass!,style:
            Theme.of(context).textTheme.headline3).tr(),
          ),
        ],),

      ),
    );
  }
}
