
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_managers/model/utilisateur_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';


import '../../homePage.dart';
import '../../values/colorValues.dart';
import '../../values/stringValues.dart';
import '../constant.dart';



class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  String? mtoken = " ";

  bool isSignIn = false;
  bool _validateNom = false;
  bool _validatePrenom = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateConfirmePassword = false;

  final controllerNom = TextEditingController();
  final controllerPrenom = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmerPassword = TextEditingController();



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
          title: const Text("S'identifier", style: TextStyle( color: Colors.black, fontSize: 18, fontWeight: FontWeight.w200),),
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


                    // Logo SCPA
                    Visibility(
                      visible: false,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.35,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09),
                        child: Image.asset("assets/logo/logo.jpg"),
                      ),
                    ),

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


                    // Password
                    InputFieldPassword(
                        headerText: "Mot de passe",
                        hintTexti: "Au moins 8 Caractères", context: context),

                    const SizedBox(
                      height: 10,
                    ),

                    // Password Confirmer
                    InputFieldPasswordCnfirme(
                        headerText: "Confirmer le mot de passe",
                        hintTexti: "Au moins 8 Caractères", context: context),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckerBoxC(context: context),
                      ],
                    ),

                    Center(
                      child: Visibility(
                        visible: isSignIn,
                        child: CupertinoActivityIndicator(
                          animating: true,
                          radius: MediaQuery.of(context).size.width *0.08,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSignIn,
                      child: const SizedBox(
                        height: 05,
                      ),
                    ),

                    // Button login
                    Visibility(
                      visible:  !isSignIn,
                      child: MaterialButton(
                        onPressed: () {

                          print("ddd d ${_acceptPolitique}");
                          if(_acceptPolitique == true) {
                            print("Sign up click d");

                            setState(() {



                              // Verification vide ou empty
                              controllerPrenom.text.isEmpty ? _validatePrenom = true : _validatePrenom = false;
                              controllerNom.text.isEmpty ? _validateNom = true : _validateNom = false;
                              controllerEmail.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                              controllerPassword.text.isEmpty ? _validatePassword = true : _validatePassword = false;
                              controllerConfirmerPassword.text.isEmpty ? _validateConfirmePassword = true : _validateConfirmePassword = false;

                              // Verification particulier

                              // Password
                              if (controllerPassword.text.length < 8) {
                                _validatePassword = true;
                              }

                              // Confirmation correte
                              if ( (controllerPassword.text.toString() != controllerConfirmerPassword.text.toString()) ) {
                                _validateConfirmePassword = true;
                              }


                              // var email = "tony123_90874.coder@yahoo.co.in";
                              // bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
                              // print (emailValid);
                              //
                              // Email
                              bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(controllerEmail.text.toString());
                              // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controllerEmail.text.toString());
                              if(emailValid == true) {
                                _validateEmail = false;
                              } else {
                                _validateEmail = true;
                              }


                              // Confirmation all valide OK
                              if(_validateEmail == false && _validateNom == false && _validatePrenom == false && _validatePassword == false && _validateConfirmePassword == false  )
                              {
                                isSignIn = ! isSignIn ;

                                // Regitre User                            ok
                                // When succes                             ok
                                // - add User FireStore
                                // when succes                             ok
                                // - show Email confirmation Popup     ok
                                // When user clique ok                     ok
                                // Show Login Page                         ok

                                RegistreUserEmail(
                                    password: controllerPassword.text.toString(),
                                    prenom: controllerPrenom.text.toString(),
                                    email: controllerEmail.text.toString().replaceAll(" ", ""),
                                    nom: controllerNom.text.toString()
                                );

                              }


                            });
                          }
                          else {
                            print("Erreur politique");

                            afficherToast();


                          }

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
                              "S'inscrire",
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

  Widget CheckerBoxC({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Checkbox(
          //     value: isCheck,
          //     checkColor: Colors.white, // color of tick Mark
          //     activeColor: Colors.black,
          //     onChanged: (val) {
          //       setState(() {
          //         isCheck = val!;
          //         print(isCheck);
          //
          //         if(val == true)
          //           _acceptPolitique = true ;
          //         else
          //           _acceptPolitique = false ;
          //
          //         print("Etat Current $_acceptPolitique");
          //
          //       });
          //     }),

          Theme(
            data: ThemeData(unselectedWidgetColor: Couleurs.corlor_app_blue_cm),
            child: Checkbox(
             // value: _rememberMe,
              value: isCheck,
              checkColor: Couleurs.corlor_app_black_cm,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  //_rememberMe = value!;
                  isCheck = value!;
                  print(isCheck);

                  if(value == true) {
                    _acceptPolitique = true ;
                  } else {
                    _acceptPolitique = false ;
                  }

                  print("Etat Current $_acceptPolitique");

                });
              },
            ),
          ),
          Container(

            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: GestureDetector(
              onTap: (){

                /*   Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ConditionUtilisationPage(),
                      inheritTheme: true,
                      ctx: context),
                );*/
              },
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'J\'ai lu et j\'accepte\n',
                      style: TextStyle(color: Colors.black,fontSize: 13,),
                    ),
                    TextSpan(
                      text: 'les termes et \nconditions d\'utilisation',
                      style: TextStyle(color: Couleurs.corlor_app_blue_cm,fontWeight: FontWeight.bold,fontSize: 13,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  bool _visible = true;

  // Password
  Widget InputFieldPassword({required BuildContext context,  required String headerText, required String hintTexti,}) {
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
            color : Couleurs.corlor_app_black_grey_cm,
            // color: whiteshade.withOpacity(0.5),
            // color: grayshade.withOpacity(0.5),
            // border: Border.all(
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              obscureText: _visible,
              decoration: InputDecoration(
                  hintText: hintTexti,
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      icon: Icon(
                          _visible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      }),
                  errorText: _validatePassword ? "Au moins 8 Caractères pour votre $headerText" : null),
              controller: controllerPassword,
              // focusNode: focusNode,
              // onEditingComplete: onEditingComplete,
              onSubmitted: (text) {
                controllerPassword.text = text;

              },
            ),
          ),
        ),
      ],
    );
  }

  // Password Confirme
  Widget InputFieldPasswordCnfirme({required BuildContext context,  required String headerText, required String hintTexti,}) {
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
            color : Couleurs.corlor_app_black_grey_cm,
            // color: grayshade.withOpacity(0.5),
            //color: whiteshade.withOpacity(0.5),
            // border: Border.all(
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              obscureText: _visible,
              decoration: InputDecoration(
                hintText: hintTexti,
                border: InputBorder.none,
                suffixIcon: IconButton(
                    icon: Icon(
                        _visible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    }),
                errorText: _validateConfirmePassword ? "Erreur de confirmation" : null,),
              controller: controllerConfirmerPassword,
              // focusNode: focusNode,
              // onEditingComplete: onEditingComplete,
              onSubmitted: (text) {
                controllerConfirmerPassword.text = text;

              },
            ),
          ),
        ),
      ],
    );
  }



  void changerProgreIdicatrCup() {
    setState(() {
      isSignIn != isSignIn ;
    });
  }

  Future<void> RegistreUserEmail  ({required String email, required String password, required String nom, required String prenom, }) async {
    try {
      Null userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        // UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {


        value.user?.updateDisplayName("$nom $prenom").then((valueA) {
          addUser_FireStore (password: password, prenom: prenom, email: email, nom: nom,);
        });

        // addUser_FireStore (password: password, prenom: prenom, email: email, nom: nom);

        // return userCredential;
      }).whenComplete(() => print("Terminer"));/*as UserCredential*/ ;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        AfficherToastErreur(message: "Le mot de passe fourni est trop faible." );

        isSignIn = ! isSignIn ;
        setState(() {

        });
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');

        AfficherToastErreur(message: "Un compte existe déjà pour cet e-mail.");
        isSignIn = ! isSignIn ;
        setState(() {

        });
      }
    }
    catch (e) {
      print(e);
      print("Failed to add user: $e");
      AfficherToastErreur(message: e.toString());



    }
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


        // User? user = FirebaseAuth.instance.currentUser;
        //
        // if (user!= null && !user.emailVerified) {
        //   await user.sendEmailVerification().then((value) =>  showActivationPopup());
        // }

        // Popup
        // showActivationPopup();


      });

    }

    )
    //   .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"))
        .onError((error, stackTrace) {
      print("Failed to add user: $error");
    });
  }

  Future showActivationPopup() async {


    showDialog(
        context: context,
        builder: (BuildContext context){
          return CustomDialogBoxConfirmationEmail( );
        });


  }




}



// Date values
class CustomDialogBoxConfirmationEmail extends StatefulWidget {



  CustomDialogBoxConfirmationEmail({Key? key}) : super(key: key);

  @override
  _CustomDialogBoxConfirmationEmailState createState() => _CustomDialogBoxConfirmationEmailState();
}

class _CustomDialogBoxConfirmationEmailState extends State<CustomDialogBoxConfirmationEmail> {

  bool stat = false ;
  String message = "E-mail";
  final bool _validateChange = false;
  final TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){


    return Stack(
      children: <Widget>[

        Container(
          padding: const EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,5),
                    blurRadius: 10
                ),
              ]
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(left:10.0, right: 10.0,/* top: 8.0,*/ bottom: 05.0),
                    width: double.infinity,
                    child: Column(
                      children: [
                      /*  Container(
                            child: Text( "Votre adresse e-mail",
                              maxLines: 2,overflow: TextOverflow.ellipsis,
                              style: TextStyle(color:Colors.blueAccent ,
                                  fontSize: 18,
                                  fontFamily: "Segoe_UI",
                                  fontWeight: FontWeight.bold ),
                              textAlign: TextAlign.center,)),*/

                        //Editeur de texte
                        Container(
                          margin: const EdgeInsets.all(07),
                          child: const Text( "Veuillez consulter votre compte e-mail pour confirmer votre adresse.",
                            maxLines: 5,overflow: TextOverflow.ellipsis,
                            style: TextStyle(color:Colors.blueAccent ,
                                fontSize: 18,
                                fontFamily: "Segoe_UI",
                                fontWeight: FontWeight.bold ),
                            textAlign: TextAlign.center,)
                        ),

                        // Soumettre Button
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: OutlinedButton(
                            onPressed: ()  {

                            //  setState(() async {

                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                SystemNavigator.pop();
                              }

                              /*  Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft, child: Signin()
                                  ),
                                );*/

                           //   });
                            },
                            child: const Text('Confirmer', style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.padded,
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),

                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            //backgroundColor: Colors.transparent,
            backgroundColor: Colors.white,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/icons/anime.gif")
              //  child: Image.asset("assets/logo/logo.png")
            ),
          ),
        ),

      ],
    );
  }


}


class Constants{
  static const double padding =20;
  static const double avatarRadius =45;

}
