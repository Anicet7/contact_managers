import 'dart:async';
import 'dart:io';

import 'package:contact_managers/homePage.dart';
import 'package:contact_managers/walkthrought.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    _portraitModeOnly();
    super.initState();

  }


  // Screen orientation
  // blocks rotation; sets orientation to: portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/logo/logo.png',
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width < 800  ?  MediaQuery.of(context).size.width * 0.6 :  MediaQuery.of(context).size.width * 0.3,
                        ),
                      )),
                  const SizedBox(height: 10,),


                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.all(35.0),
                        child: CupertinoActivityIndicator(
                          color: Colors.black,
                          animating: true,
                          radius: MediaQuery.of(context).size.width < 800  ?  MediaQuery.of(context).size.width * 0.05 :  MediaQuery.of(context).size.width * 0.03,
                        )),
                  ],
                ),
              ),
            ])),


      ],
    );
  }

  // Gestion du temps
  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    setState(() {

      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: ((FirebaseAuth.instance.currentUser) != null)
                ? HomePage()
                : const WalkthrougPage()),
      );
    });
  }
}
