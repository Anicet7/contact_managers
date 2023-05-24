

import 'package:flutter/material.dart';

import 'colorValues.dart';

const kHintTextStyle = TextStyle(
  color: Colors.black,
  //color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  fontSize: 15,
  color: Couleurs.corlor_app_blue_cm,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
 // color: Color(0xFF6CA8F1),
  color: Couleurs.corlor_app_black_grey_cm,
//  color: Couleurs.textfield_login_color,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);