import 'package:flutter/material.dart';

class TextFormFieldModel {
  final String? heading;
  final String hintText;
  final bool isIcon;
  final IconData? suffixIcon;

  TextFormFieldModel(
      {this.heading, required this.isIcon,this.suffixIcon, required this.hintText});
}