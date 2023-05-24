

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_managers/model/contact_model.dart';
import 'package:flutter/material.dart';
///import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../../model/utilisateur_model.dart';
import '../../values/stringValues.dart';


///
///
///  Create Contact OK
///  Delete Contact OK
///  Update Contact OK
///


class FirebaseCRUD {


  /// Create Contact
  static void Create_contact ({

    required UtilisateurModel utilisateur,
    required ContactModel contact,
    required BuildContext context,
    required String errorMessage,
    required String succesMessage,


    }){
    var DATA_ref = FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_contact).doc(utilisateur.uid).collection(Repertoire_Firestore.collection_specifique_contact);
    DATA_ref.add(
        contact!.toMap()
    ).catchError((error){
      ShowErroMessageToast(context: context,errorMessage: error.toString() );
      ShowErroMessageToast(context: context,errorMessage: errorMessage );
    }).then((value) {

      // Update Doc ID
      Update_contact_UID(
        utilisateur : utilisateur,
          succesMessage: succesMessage,
          errorMessage: errorMessage,
          context: context,
          keyUpdate: "uid",
          valueUpdate: value.id,
          );

      // ShowSuccesMessageToast(context: context, succesMessage: succesMessage);
    });
  }


  /// Update Contact
  static void Update_contact ({

    required UtilisateurModel utilisateur,
    required ContactModel contact,
    required BuildContext context,
    required String errorMessage,
    required String succesMessage,


    }){
    var DATA_ref = FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_contact).doc(utilisateur.uid).collection(Repertoire_Firestore.collection_specifique_contact).doc(contact.uid);
    DATA_ref.update(
        contact!.toMap()
    ).catchError((error){
      ShowErroMessageToast(context: context,errorMessage: error.toString() );
      ShowErroMessageToast(context: context,errorMessage: errorMessage );
    }).then((value) {

      ShowSuccesMessageToast(context: context, succesMessage: succesMessage);
    });
  }
/// Delete Contact
  static void Delect_contact ({

    required UtilisateurModel utilisateur,
    required ContactModel contact,
    required BuildContext context,
    required String errorMessage,
    required String succesMessage,


    }){
    var DATA_ref = FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_contact).doc(utilisateur.uid).collection(Repertoire_Firestore.collection_specifique_contact).doc(contact.uid);
    DATA_ref.delete(

    ).catchError((error){
      ShowErroMessageToast(context: context,errorMessage: error.toString() );
      ShowErroMessageToast(context: context,errorMessage: errorMessage );
    }).then((value) {

      ShowSuccesMessageToast(context: context, succesMessage: succesMessage);
    });
  }



  ///
  ///  Update Contact UID
  ///
  // Update Specifique Data
  static void Update_contact_UID ({
    required UtilisateurModel utilisateur,
    required String succesMessage,
    required String errorMessage,
    required BuildContext context,
    required String keyUpdate,
    required String valueUpdate,
  }){

    // Instantiate a reference to a document - this happens offline
    var DATA_ref = FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_contact).doc(utilisateur.uid).collection(Repertoire_Firestore.collection_specifique_contact).doc(valueUpdate);
    DATA_ref.update({
      keyUpdate : valueUpdate
    }).catchError((error){
      ShowErroMessageToast(context: context,errorMessage: error.toString() );
      ShowErroMessageToast(context: context,errorMessage: errorMessage );
    }).then((value) {
      ShowSuccesMessageToast(context: context, succesMessage: succesMessage);
      Navigator.pop(context);
     // Navigator.pop(context);
    });

  }



  // Succes Message Toast
  static void ShowSuccesMessageToast ({required String succesMessage, required BuildContext context})
  {
    showToastWidget(Container(
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
          ),

        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),

        child: Text(succesMessage, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),context:context);
  }


   // Error Message Toast
  static void ShowErroMessageToast ({required String errorMessage, required BuildContext context})
  {

    // Fluttertoast.showToast(
    //     msg: errorMessage,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );

    FlutterToastr.show(errorMessage,
        context, duration: FlutterToastr.lengthShort,
        position:  FlutterToastr.bottom,
        backgroundColor: Colors.red,
        backgroundRadius: 20,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,)
    );

    }

    // Information Message Toast
  static void ShowInfoMessageToast ({required String infoMessage, required BuildContext context})
  {

    // Fluttertoast.showToast(
    //     msg: infoMessage,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.TOP,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.blue,
    //     textColor: Colors.white,
    //     fontSize: 15.0
    // );

    FlutterToastr.show(infoMessage,
        context, duration: FlutterToastr.lengthShort,
        position:  FlutterToastr.bottom,
        backgroundColor: Colors.red,
        backgroundRadius: 20,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,)
    );

    }


}