import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_managers/model/contact_model.dart';
import 'package:contact_managers/model/utilisateur_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../utility/crud/firebaseCRUD.dart';
import '../values/stringValues.dart';
import 'details_contact.dart';


class AccueilPage extends StatefulWidget {
  AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {

  UtilisateurModel? auteur ;
  ///
  /// Contact Stream
  ///
  final Stream<QuerySnapshot> _ContactstreamListe = FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_contact).doc(FirebaseAuth.instance.currentUser!.uid).collection(Repertoire_Firestore.collection_specifique_contact).orderBy('timeStamp', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: // Text("data",style: TextStyle(color: Colors.red),),
        Text("Mes contactes", style: GoogleFonts.actor(fontSize: 25, color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                StreamBuilder<QuerySnapshot>(
                    stream: _ContactstreamListe,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.hasData) {

                        return ListView(
                          shrinkWrap: true,
                          //  physics: const NeverScrollableScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                            ContactModel contactModel = ContactModel.fromMap(data, uid: document.id);

                            // if (contactModel.auteur_uid == FirebaseAuth.instance.currentUser!.uid ){
                            //   return item_contact(contact: contactModel);
                            // }else
                            //   {
                            //     return SizedBox();
                            //   }

                            return item_contact(contact: contactModel);

                          }).toList(),
                        );

                      }

                      return Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CupertinoActivityIndicator(
                            animating: true,
                            // radius: MediaQuery.of(context).size.width * 0.08,
                            radius: MediaQuery.of(context).size.width < 800  ?  MediaQuery.of(context).size.width * 0.05 :  MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      );
                    }),


              ],
            )
          ],
        ),
      ),
    );
  }


  @override
  void initState() {

    // Get User Data
    getUserModelData();


    super.initState();
  }

  Widget item_contact ({required ContactModel contact}){
    return  ListTile(
      //return new ListTile(
      onTap: (){

        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: DetailContactPage(contact: contact,)
          ),
        );
      },

      ///
      ///
     // /*
      trailing: PopupMenuButton(
        // tooltip: 'Menu',
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              enabled:  true,
              onTap: () {

                FirebaseCRUD.Delect_contact(
                    errorMessage: 'Erreur',
                    context: context,
                    succesMessage: "Effectuer avec succès", utilisateur: auteur as UtilisateurModel,
                  contact:  contact
                );
              },
              value: 'comptable',
              child:  Text("Supprimer"),
            ),
            PopupMenuItem(
              enabled:  true,

              onTap: () {

                // FirebaseCRUD.Update_contact(
                //     errorMessage: 'Erreur',
                //     context: context,
                //     succesMessage: "Effectuer avec succès",
                //     contact:  contact,
                //   utilisateur: auteur as UtilisateurModel,
                //
                // );

              },
              value: 'editer',
              child:  Text("Éditer"),
            )
          ];
        },
        onSelected: (String value) {
          print('You Click on po up menu item');
        },
      ),
     // */

      ///
      ///
      leading: const Icon(Icons.account_circle_rounded, color: Colors.black,),
      title:  Text(contact.name),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contact.email, style: TextStyle(fontSize: 12),),
          Text( 'Tel: ${contact.telephone}' , style: TextStyle(fontSize: 12, color:  Colors.black),),
          Text('Email : ${contact.telephone}' , style: TextStyle(fontSize: 12 ,color:  Colors.black),),
        ],
      ),
      tileColor: Colors.grey.shade50,
    );
  }

  // Verify if user doc is lock or no
  getUserModelData() async{
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_utilisateur).doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(mounted) {

      Map<String, dynamic> data =
      ds.data()! as Map<String, dynamic>;

      auteur = UtilisateurModel.fromMap( data, uid: ds.id);

      setState(() {
        // Locker user Page
      });

      print(auteur!.email);
      print(auteur!.date_inscription);

    }

  }
}
