import 'package:flutter/material.dart';
import 'colors.dart';

const bold = 'Bold';
const regular = 'Regular';
const boldItalic = 'BoldItalic';
const medium = 'Medium';

ourStyle({family = regular, double? size = 14, color = whiteColor}){

  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: family
  );
}