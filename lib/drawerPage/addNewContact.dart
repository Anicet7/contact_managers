
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_managers/model/contact_model.dart';
import 'package:contact_managers/model/utilisateur_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:page_transition/page_transition.dart';


import '../../homePage.dart';
import '../../values/colorValues.dart';
import '../../values/stringValues.dart';
import '../utility/crud/firebaseCRUD.dart';



class AddNewContact extends StatefulWidget {
  AddNewContact({Key? key}) : super(key: key);

  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {



  bool isRegistreIn = false;
  bool _validateNom = false;
  bool _validatePrenom = false;
  bool _validateEmail = false;
  bool _validateTelephone = false;
  bool _validateProfession = false;


  final controllerNom = TextEditingController();
  final controllerPrenom = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerTelephone = TextEditingController();
  final controllerProfession = TextEditingController();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight ,
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                // Color(0xFF73AEF5),
                // Color(0xFF61A4F1),
                // Color(0xFF478DE0),
                // Color(0xFF398AE5),

              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Nouveau contact", style: TextStyle( color: Colors.black, fontSize: 18, fontWeight: FontWeight.w200),),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(
              color: Colors.black
          ),

        ),
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [



              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                 // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Nom
                    InputFieldNom(headerText: "Votre nom", hintTexti: "ABC",context: context),
                    const SizedBox(
                      height: 10,
                    ),

                    // Prenom
                    InputFieldPrenom(headerText: "Votre prénom", hintTexti: "EFG",context: context),
                    const SizedBox(
                      height: 10,
                    ),

                    // Email
                    InputFieldEmail(headerText: "E-mail", hintTexti: "abc@exemple.org",context: context),
                    const SizedBox(
                      height: 10,
                    ),


                    // Profession
                    InputFieldProfession(headerText: "Profession", hintTexti: "Juriste",context: context),
                    const SizedBox(
                      height: 10,
                    ),

                    // Telephone
                    InputFieldTelephone(headerText: "Telephone", hintTexti: "67889900",context: context),
                    const SizedBox(
                      height: 10,
                    ),


                    Center(
                      child: Visibility(
                        visible: isRegistreIn,
                        child: CupertinoActivityIndicator(
                          animating: true,
                          radius: MediaQuery.of(context).size.width *0.08,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isRegistreIn,
                      child: const SizedBox(
                        height: 05,
                      ),
                    ),

                    // Button login
                    Visibility(
                      visible:  !isRegistreIn,
                      child: MaterialButton(
                        onPressed: () {

                            setState(() {



                              // Verification vide ou empty
                              controllerPrenom.text.isEmpty ? _validatePrenom = true : _validatePrenom = false;
                              controllerNom.text.isEmpty ? _validateNom = true : _validateNom = false;
                              controllerEmail.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                              controllerTelephone.text.isEmpty ? _validateTelephone = true : _validateTelephone = false;
                              controllerProfession.text.isEmpty ? _validateProfession = true : _validateProfession = false;

                              // Verification particulier

                              // Email
                              bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(controllerEmail.text.toString());
                              // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controllerEmail.text.toString());
                              if(emailValid == true) {
                                _validateEmail = false;
                              } else {
                                _validateEmail = true;
                              }

                              // Telephone
                              bool phoneValid = RegExp(r"\b\d{8}\b").hasMatch(controllerTelephone.text.toString());
                              // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controllerEmail.text.toString());
                              if(phoneValid == true) {
                                _validateTelephone = false;
                              } else {
                                _validateTelephone = true;
                              }


                              // Confirmation all valide OK
                              if(_validateEmail == false && _validateTelephone == false && _validateNom == false && _validatePrenom == false && _validateTelephone == false && _validateProfession == false  )
                              {
                                isRegistreIn = ! isRegistreIn ;


                                ContactModel contact = ContactModel(
                                    uid: "uid",
                                   // auteur_uid  : FirebaseAuth.instance.currentUser!.uid,
                                    nom: controllerNom.text.toString(),
                                    prenom: controllerPrenom.text.toString(),
                                    name: controllerPrenom.text.toString() + " " + controllerNom.text.toString(),
                                    email: controllerEmail.text.toString().replaceAll(" ", ""),
                                    imageURL: "",
                                    search: [],

                                    timeStamp: 0,
                                    date_ajout: DateTime.now(),
                                    telephone: controllerTelephone.text.toString(),
                                    profession: controllerProfession.text.toString());


                                RegistreContact(
                                    contact : contact
                                );

                              }


                            });


                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.07,
                          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          decoration: const BoxDecoration(
                              color: Couleurs.corlor_app_blue_cm,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                            child:  Text(
                              "Enregistrer",
                              style:  TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  //color: Couleurs.corlor_app_black_cm
                                  color: Colors.white,

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  void afficherToast() {
    // Fluttertoast.showToast(msg: 'msg');
    Fluttertoast.showToast(
        msg: "Veuillez accepter nos conditions et politiques d\'utilisation",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0
    );
  }

  bool? isCheck = false;
  bool? startRegister = false;

  bool? _acceptPolitique;

  // Email
  Widget InputFieldEmail({ required BuildContext context,  required String headerText, required String hintTexti,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              // color: whiteshade.withOpacity(0.5),
              color : Couleurs.corlor_app_black_grey_cm,
              // color: grayshade.withOpacity(0.5),
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: hintTexti,
                    border: InputBorder.none,
                    errorText: _validateEmail ? "$headerText ne peut pas être vide ou adresse e-mail invalide" : null,
                    errorMaxLines: 3
                ),
                controller: controllerEmail,
                // focusNode: focusNode,
                // onEditingComplete: onEditingComplete,
                onSubmitted: (text) {
                  controllerEmail.text = text;

                },

              ),
            )
          //IntrinsicHeight

        ),
      ],
    );
  }

  // Nom
  Widget InputFieldNom({ required BuildContext context,  required String headerText, required String hintTexti,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              //color: whiteshade.withOpacity(0.5),
              //color: grayshade.withOpacity(0.5),
              color : Couleurs.corlor_app_black_grey_cm,
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                // style: TextStyle(
                //   color: Colors.white,
                //   fontFamily: 'OpenSans',
                //   fontSize: 18,
                // ),
                decoration: InputDecoration(
                    hintText: hintTexti,
                    border: InputBorder.none,
                    errorText: _validateNom ? "$headerText ne peut pas être vide" : null
                ),
                controller: controllerNom,
                // focusNode: focusNode,
                // onEditingComplete: onEditingComplete,
                onSubmitted: (text) {
                  controllerNom.text = text;

                },

              ),
            )
          //IntrinsicHeight

        ),
      ],
    );
  }

  // Prenom
  Widget InputFieldPrenom({ required BuildContext context,  required String headerText, required String hintTexti,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              // color: whiteshade.withOpacity(0.5),
              color : Couleurs.corlor_app_black_grey_cm,
              // color: grayshade.withOpacity(0.5),
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: hintTexti,
                    border: InputBorder.none,
                    errorText: _validatePrenom ? "$headerText ne peut pas être vide" : null
                ),
                controller: controllerPrenom,
                // focusNode: focusNode,
                // onEditingComplete: onEditingComplete,
                onSubmitted: (text) {
                  controllerPrenom.text = text;

                },

              ),
            )
          //IntrinsicHeight

        ),
      ],
    );
  }

  // Telphone
  Widget InputFieldTelephone({ required BuildContext context,  required String headerText, required String hintTexti,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              // color: whiteshade.withOpacity(0.5),
              color : Couleurs.corlor_app_black_grey_cm,
              // color: grayshade.withOpacity(0.5),
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: hintTexti,
                    border: InputBorder.none,
                    errorText: _validateTelephone ? "$headerText ne peut pas être vide" : null
                ),
                controller: controllerTelephone,
                // focusNode: focusNode,
                // onEditingComplete: onEditingComplete,
                onSubmitted: (text) {
                  controllerTelephone.text = text;

                },

              ),
            )
          //IntrinsicHeight

        ),
      ],
    );
  }

  // Profession
  Widget InputFieldProfession({ required BuildContext context,  required String headerText, required String hintTexti,}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              // color: whiteshade.withOpacity(0.5),
              color : Couleurs.corlor_app_black_grey_cm,
              // color: grayshade.withOpacity(0.5),
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: hintTexti,
                    border: InputBorder.none,
                    errorText: _validateProfession ? "$headerText ne peut pas être vide" : null
                ),
                controller: controllerProfession,
                // focusNode: focusNode,
                // onEditingComplete: onEditingComplete,
                onSubmitted: (text) {
                  controllerProfession.text = text;

                },

              ),
            )
          //IntrinsicHeight

        ),
      ],
    );
  }

  bool _visible = true;




  void changerProgreIdicatrCup() {
    setState(() {
      isRegistreIn != isRegistreIn ;
    });
  }

  AfficherToastErreur ({required String message})
  {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  Future<void> addUser_FireStore( { required String nom, required String prenom, required String email, required String password,} ) async {

    // User Liste seach name
    List <String> splitList = "$nom $prenom".split(" ");
    List <String> indexList = [];

    for (int i = 0; i < splitList.length; i++)
    {
      for (int y = 1; y < splitList[i].length + 1; y++)
      {
        indexList.add(splitList[i].substring(0,y).toLowerCase());
      }
    }


    DateTime now = DateTime.now();

    String convertedDateTime = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString()}-${now.minute.toString()}";


    CollectionReference users = FirebaseFirestore.instance.collection(Repertoire_Firestore.collection_general_utilisateur);

    UtilisateurModel utilisateur = UtilisateurModel(

        uid: FirebaseAuth.instance.currentUser!.uid,
        prenom: prenom,
        date_inscription: now,

        email: email,
        nom: nom,
        name: prenom + " " + nom,

        search: indexList,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        date_late_connexion: now,

        imageURL: "",
        ) ;


    // Call the user's CollectionReference to add a new user
    return users.doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
        utilisateur.toMap()
    )
        .then((value) {

      // setState(() async {
      setState(()  {

        //  /*
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: HomePage()
          ),
        );
        //  */


      });

    }

    )
    //   .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"))
        .onError((error, stackTrace) {
      print("Failed to add user: $error");
    });
  }


  void RegistreContact  ({required   ContactModel contact }) async {
    try {

      // User Liste seach name
      List <String> splitList = "${contact.nom} ${contact.prenom}".split(" ");
      List <String> indexList = [];

      for (int i = 0; i < splitList.length; i++)
      {
        for (int y = 1; y < splitList[i].length + 1; y++)
        {
          indexList.add(splitList[i].substring(0,y).toLowerCase());
        }
      }


      contact.timeStamp = DateTime.now().millisecondsSinceEpoch;

      FirebaseCRUD.Create_contact(
          utilisateur: UtilisateurModel(
              uid: FirebaseAuth.instance.currentUser!.uid.toString(),
              nom: "",
              prenom: "",
              name: FirebaseAuth.instance.currentUser!.displayName.toString(),
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              imageURL: "",
              search: [],
              timeStamp: 0,
              date_inscription: DateTime.now(),
              date_late_connexion: DateTime.now()),
          contact: contact,
          context: context,
          errorMessage: "Une erreur est survenue lors de l'enregistrement du contact. Veuillez réessayer plus tard ou vérifier votre connexion Internet.",
          succesMessage: "Contact enregistré avec succès.", );


    } on FirebaseAuthException catch (e) {

        AfficherToastErreur(message: "Le mot de passe fourni est trop faible." );

    }
    catch (e) {
      print(e);
      print("Failed to add contact : $e");
      AfficherToastErreur(message: e.toString());



    }
  }


}
