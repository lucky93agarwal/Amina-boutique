
import 'package:amin/utils/color.dart';
import 'package:amin/utils/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool check;
  BottomBar(
      {required this.onTap, required this.text,required this.check});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: check == true ?null: kMainColor,border: check == true ? Border.all(color: Colors.grey):null,borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Nexa'),
          ).tr(),
        ),

        height: 60.0,
      ),
    );
  }
}
