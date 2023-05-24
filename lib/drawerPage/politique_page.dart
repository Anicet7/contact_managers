import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../../values/colorValues.dart';


class PolitiquePage extends StatefulWidget {
  const PolitiquePage({Key? key}) : super(key: key);

  @override
  State<PolitiquePage> createState() => _PolitiquePageState();
}

class _PolitiquePageState extends State<PolitiquePage> {
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
          Text("Politique de confidentialité", style: GoogleFonts.acme(fontSize: 24)),
          Text("ESGIS-BENIN", style: GoogleFonts.actor()),

        ],
      ),
    ),
      ),

    );
  }
}

