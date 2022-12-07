import 'package:amin/utils/theme_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class BuildListTile extends StatelessWidget {
  final String? image;
  final String? text;
  final bool check;
  final Function() onTap;
  final BuildContext? context;
  BuildListTile({Key? key,this.image, this.text,required this.check,required this.onTap,required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
      leading: Image.asset(
        image!,
        height: 22.3,
      ),
      title: Text(
        text!,
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      ).tr(),
      onTap: onTap,
        trailing: check == true? Switch(
        activeColor: Colors.black,
        activeTrackColor: Colors.grey,
        onChanged: (bool){
          context.read<ThemeBloc>().toggleTheme();

          /* context.read<ThemeBloc>().toggleTheme();*/
        },
        value:  context.read<ThemeBloc>().darkTheme!,
      ):null,
    );
  }
}
