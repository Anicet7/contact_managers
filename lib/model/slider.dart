import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../values/colorValues.dart';
//import 'package:flutter_svg/svg.dart';

class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const SliderPage({super.key,  required this.title, required  this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            image,
           // width: width * 0.6,
            width: width * 0.55,
          ),
          SizedBox(
           // height: 60,
            height:  MediaQuery.of(context).size.width * 0.08,
          ),
          Text(
            title,
            // style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Couleurs.corlor_app_blue_cm),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              description,
              style: const TextStyle(
                height: 1.5,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.7, color: Couleurs.corlor_app_blue_cm
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
