import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  String label;
  IconData prefix;
  Widget? suffix;
  bool? ispassword;
  Function valdiate;
  Function? suffixpressed;
  Function? onsubmit ;

  DefaultFormField({
    required this.controller,
    required this.type,
    required this.label,
    required this.prefix,
    this.suffix,
    required this.valdiate,
    this.ispassword,
    this.suffixpressed,
    this.onsubmit  ,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        return onsubmit!(value);
      }, 
      controller: controller,
      obscureText: ispassword!,
      keyboardType: type,
      validator: (value) {
        return valdiate(value);
      },
      decoration: InputDecoration(
        labelText: label,

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.redAccent, width: 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(),
        // hintText: label,
        prefixIcon: Icon(
          prefix,
        ),

        suffixIcon: suffix 
        // != null
        //     ? IconButton(
        //         onPressed: suffixpressed!(),
        //         icon: Icon(suffix),
        //       )
        //     : null,
      ),
    );
  }
}
