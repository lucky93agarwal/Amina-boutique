import 'package:amin/utils/color.dart';
import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? image;
  final bool readOnly;
  final TextInputType keyboardType;
  final int? maxLength;
  final String hint;

  EntryField(
      {required this.controller,
        required this.label,
        this.image,
        required this.readOnly,
        required this.keyboardType,
        this.maxLength,
        required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
      child: TextFormField(
        cursorColor: kMainColor,
        autofocus: false,
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.newline,
        style: TextStyle(color: Colors.white,fontSize: 15),
        obscureText: false,
        maxLength: (maxLength  != null)?maxLength : null,
        minLines: 1,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.caption,
          hintText: hint,

          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: kMainColor, width: 0.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
            const BorderSide(color: Colors.grey, width: 0.0),
          ),

          prefixIcon: image == null ? null :Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(

              image!,
              color: kMainColor,
              width: 20.0,
              height: 20.0,
            ),
          ),
          /*icon: (image != null)
              ? ImageIcon(
            AssetImage(image),
            color: kMainColor,
            size: 20.0,
          )
              : null,*/
        ),
      ),
    );
  }
}
