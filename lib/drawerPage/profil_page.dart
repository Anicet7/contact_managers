import 'dart:ui';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../values/colorValues.dart';



class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? userName = FirebaseAuth.instance.currentUser!.displayName;
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  String? userImageURL = FirebaseAuth.instance.currentUser!.photoURL;



  @override
  Widget build(BuildContext context) {


    final double height = ((MediaQuery.of(context).size.height / 2) +
        (MediaQuery.of(context).size.width / 4));


    return Scaffold(

        body: Container(
          // margin: EdgeInsets.only(bottom:  MediaQuery.of(context).size.height * 0.10),
          child: Column(
            children: [

              // Photo profil
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  // color: Colors.white,
                  // margin: EdgeInsets.all(5.0),
                //  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),


                  child: Container(
                   // color: Colors.amber,
                  //  height: MediaQuery.of(context).size.height * 0.80,
                  //  width: MediaQuery.of(context).size.width * 0.50,
                    child: Stack(
                      children: <Widget>[

                        Align(

                          alignment: Alignment.topCenter,
                          child: CircleAvatar(

                            backgroundColor: Couleurs.corlor_app_black_grey_cm,
                            radius: MediaQuery.of(context).size.width * 0.25,
                            // backgroundImage: AssetImage('assets/logo.png'),
                            child:
                                BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                      color: Colors.blueGrey.withOpacity(0.1),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50.0),
                                        child:
                                        (userImageURL == null) ? Image.asset ('assets/logo/logo.png'):
                                        Image.network(userImageURL!, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                          return Icon(Icons.error_outline, size:  25);
                                        }, ),
                                      )),
                                ),




                          ),
                        ),

                      ],
                    ),
                  ),


                ),

              ),

              //  information
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration (
                    // color: Colors.red,
                //    color:  Color(0xfffdb681) ,
                    color:  Couleurs.corlor_app_blue_cm,
                   // color:  Color(0xfff4d1b6) ,
                    borderRadius: BorderRadius.only (
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),


                  ) ,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        // User name Full
                        // User Email

                        // Date creation
                        // Date laste connexion

                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                            child: Column(
                              children: [

                               // (userName == null ||  userName == "" ) ?

                                  //  :
                                 Text(FirebaseAuth.instance.currentUser!.displayName.toString(),
                              //  Text(
                                 // (userName == null ) ? "Nom":
                                //  userName  as String,
                                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold,fontFamily: "Segoe_UI"),),

                              //    Text("nicoleahiyou@icloud.com",
                                Text(
                                  (userEmail == null ) ? "":
                                  userEmail as String,
                                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.normal,fontFamily: "Segoe_UI"),),


                                SizedBox(height:   MediaQuery.of(context).size.height *0.02,),
                                SizedBox(height:   MediaQuery.of(context).size.height *0.02,),


                                // Date creation du compte
                                Text("Date de création du compte",
                                  // Text(userName,
                                  style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold,fontFamily: "Segoe_UI"),),

                                // Date creation du compte

                                Text(
                                    DateFormat( "dd - MMM - yyyy à HH:mm", Localizations.localeOf(context).languageCode).format(FirebaseAuth.instance.currentUser?.metadata.creationTime as DateTime).toString(),
                                  //FirebaseAuth.instance.currentUser?.metadata.creationTime.toString() as String,
                                  // Text("Jeudi 07 Octobre 2021 12:14:05",
                                  //  Text(userEmail,
                                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.normal,fontFamily: "Segoe_UI"),),


                                SizedBox(height:   MediaQuery.of(context).size.height *0.02,),
                                SizedBox(height:   MediaQuery.of(context).size.height *0.02,),


                                // Planning céer


                              ],
                            ),
                          ),
                        ),

                        SizedBox(height:   MediaQuery.of(context).size.height *0.02,),

                      ],
                    ),
                  ),
                ),
              ),

              // Social
            ],
          ),
        )



    );
  }

   int nombre_de_event_creer = 0;



  @override
  void initState() {

    // getEventCretByCurrentUser ();
    super.initState();

    // getEventCretByCurrentUser ();

  }


}

