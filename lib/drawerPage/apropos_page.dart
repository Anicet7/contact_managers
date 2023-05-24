import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../../values/colorValues.dart';


class AproposPage extends StatefulWidget {
  const AproposPage({Key? key}) : super(key: key);

  @override
  State<AproposPage> createState() => _AproposPageState();
}

class _AproposPageState extends State<AproposPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


       backgroundColor: Colors.white,

      body: Padding(
        padding:  EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.15),
        child:   Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AL - SOIR - GROUPE 23", style: GoogleFonts.acme(fontSize: 24)),
          Text("ESGIS-BENIN", style: GoogleFonts.actor()),
          Text("Copy right 2023", style: GoogleFonts.actor(fontWeight: FontWeight.bold)),
          Text("1.0.0"),

        ],
      ),
    ),
      ),

    );
  }
}

