import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  //final String hintText;
  final bool obscureText;
  final int maxLines;
  final String labelText;
  final FormFieldValidator<String>? validator;

  const MyTextField({
    super.key,
    required this.controller,
    //required this.hintText,
    required this.obscureText, 
    required this.maxLines,
    required this.labelText,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(5)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!, style: BorderStyle.solid),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            fillColor: Colors.white,
            filled: true,
            //hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
            
      ),
    );
  }
}