



import 'package:flutter/material.dart';

import '../../constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const TextInputField({Key? key
  ,required this.controller,
  required this.icon,
  this.isObscure=false,required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon,color: iconColor,),
        labelStyle:  TextStyle(fontSize: 20,color: iconColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color:borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color:borderColor,
          ),
        ),
      
      ),
      obscureText: isObscure,
    );
  }
}