import 'dart:io';

import 'package:contact_managers/login/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'dart:math' as math;


import '../homePage.dart';
import '../values/colorValues.dart';
import '../values/constants.dart';
import '../values/stringValues.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  String? mtoken = " ";
  late bool? isLiked ;
  bool _rememberMe = false;
  bool isSignIn = false;

  bool _validateEmail = false;
  bool _validatePassword = false;

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();



  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (context) =>  Scaffold(

          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[




                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(
                              padding: EdgeInsets.only( bottom: 20.0),
                              child:
                              Align(alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset('assets/logo/logo.png',
                                   // height:  MediaQuery.of(context).size.height  /2,
                                    width:  MediaQuery.of(context).size.width  /2,
                                  ),
                                ),)),

                          const Text(
                            // 'Sign In',
                            Chaine.login_welcome_message,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            height:  MediaQuery.of(context).size.width * 0.05,
                            // height: 30.0
                          ),

                          _buildEmailTF(),
                          SizedBox(
                            height:  MediaQuery.of(context).size.width * 0.05,
                            //  height: 30.0,
                          ),
                          _buildPasswordTF(),
                          _buildForgotPasswordBtn(),
                          _buildRememberMeCheckbox(),

                          // Login Button s'identifier
                           Visibility(visible:  !isSignIn, child: _buildLoginBtn()),

                          // Social login Button
                       //   _buildSignInWithText(),
                       //   Visibility(visible:  !isSignIn ,child: _buildSocialBtnRow()),

                          Center(
                            child: Visibility(
                              visible: isSignIn,
                              // visible: true,
                              child: CupertinoActivityIndicator(
                                color: Colors.black,
                                animating: true,
                                radius: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                          ),

                          _buildSignupBtn(),
                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      },
      builder:  (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [

            /*
               //   ResponsiveBreakpoint.autoScale(450, name: MOBILE),
               //   ResponsiveBreakpoint.autoScale(480, name: MOBILE),
               //   ResponsiveBreakpoint.autoScale(600, name: MOBILE),
               //   ResponsiveBreakpoint.autoScale(700, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: MOBILE),

                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),

            */

            // By Defaut
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),


          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      title: 'Momo Finger',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', ''), // English, no country code
        //   Locale('es', ''), // Spanish, no country code
        //  Locale.fromSubtags(languageCode: 'fr_FR', scriptCode: 'fr_FR'),
        // Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ],
      theme: ThemeData(
        //  primarySwatch: Colors.blue,
        primarySwatch: Colors.blueGrey,
        // primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),

    );
  }


  // Password
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          Chaine.login_password_label,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const  EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Couleurs.corlor_app_black_grey_cm,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
        //  decoration: kBoxDecorationStyle,
          height:  MediaQuery.of(context).size.width * 0.18,
          // height: 60.0,
          child: TextField(
            controller: controllerPassword,
            obscureText: true,
            style: const TextStyle(
              color: Couleurs.corlor_app_blue_cm,
              fontFamily: 'OpenSans',
              fontSize: 18,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14.0),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Couleurs.corlor_app_blue_cm,
                ),
                hintText: Chaine.login_password_textfield,
                hintStyle: kHintTextStyle,
                errorText: _validatePassword ? "Au moins 8 Caractères pour votre mot de passe" : null,
                errorStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
            ),

            onSubmitted: (text) {
              controllerPassword.text = text;
            },
          ),
        ),
      ],
    );
  }

  // Pass oublié
  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {
          showActivationGeneredPopup();
        },
        //   onPressed: () => print('Forgot Password Button Pressed'),
        padding: const EdgeInsets.only(right: 0.0),
        child: const Text(
          Chaine.login_password_oublier,
          style: kLabelStyle,
        ),
      ),
    );
  }

  // Politique
  Widget _buildRememberMeCheckbox() {
    return SingleChildScrollView(
      child: Container(
        height: 20.0,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Couleurs.corlor_app_blue_cm),
              child: Checkbox(
                value: _rememberMe,
                checkColor: Couleurs.corlor_app_blue_cm,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              ),
            ),
            Text(
              Chaine.login_condition_utilisateur,
              //   style: kLabelStyle,
              style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04, color: Couleurs.corlor_app_blue_cm),
            ),
          ],
        ),
      ),
    );
  }

  // Login Button
  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      margin:  EdgeInsets.only(left: 40, right: 40),
      height:  110,
      child: MaterialButton(
        elevation: 5.0,
        onPressed: () {



          if(_rememberMe == true) {
            print("Sign up click d");

            setState(() {

              //  isSignIn = ! isSignIn ;

              controllerEmail.text.isEmpty ? _validateEmail = true : _validateEmail = false;
              controllerPassword.text.isEmpty ? _validatePassword = true : _validatePassword = false;

              // Password
              if (controllerPassword.text.length < 8)
                _validatePassword = true;

              // Email
              //bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(controllerEmail.text.toString());
              bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(controllerEmail.text.toString());
              if(emailValid == true)
                _validateEmail = false;
              else
                _validateEmail = true;


              // Confirmation all valide OK
              if(_validateEmail == false && _validatePassword == false   ) {

                isSignIn = !isSignIn;

                LoginUserEmail(
                  password: controllerPassword.text.toString(),
                  email: controllerEmail.text.toString(),
                );

              }


            });
          }
          else {
            print("Erreur politique");

            afficherToast();


          }


        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Couleurs.corlor_app_blue_cm,
        //color: Colors.white,
        child: const Text(
          Chaine.login_text_bt,
          style: TextStyle(
            //  color: Color(0xFF527DAA),
           // color: Color(0xFF527DAA),
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // Vous insscrit avec
  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        _divider(),
        SizedBox(
          //  height: 20.0
          height:  MediaQuery.of(context).size.width * 0.02,
        ),
        const Text(
          Chaine.login_seconnecter_avec,
          style: kLabelStyle,
        ),
      ],
    );
  }

  // Separateur
  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text( Chaine.login_or ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(int? onTap, AssetImage logo) {
    //Widget _buildSocialBtn(Function? onTap, AssetImage logo) {
    return GestureDetector(
      onTap: (){

        //


        setState(() {
          print("Clique teste ");

          if(_rememberMe) {

            // Apple
            if(onTap == 1) {
              print("1");

              String os = Platform.operatingSystem;
              print("Apple implementer ");
              if (Platform.isAndroid) {
                afficherToastApple();
              }

              else

              if(Platform.isIOS) {
                //





              }
            }
            // Google
            else {
              print("2");
              //
            }
          } else {
            print("Accepter la politique");
            setState(() {
              afficherToast();

            });
          }

        });

      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }


  // Bouton identifier
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign Up Button Pressed');

       // /*
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              //   child:  Login()
              //   child:  WelcomePage()
              child:   SignUp()
            // Lunch Walk
            // if user auth = false
            // Else lunch Hom
          ),
        );
         // */


      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              // text: 'Don\'t have an Account? ',
              text: Chaine.login_pas_de_compte,
              style: TextStyle(
                color: Couleurs.corlor_app_blue_cm,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              //  text: 'Sign Up',
              text: ' ${Chaine.login_text_souligner}',
              style: TextStyle(
                color: Couleurs.corlor_app_black_cm,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Email
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const  EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Couleurs.corlor_app_black_grey_cm,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
         // decoration: kBoxDecorationStyle,
          height: MediaQuery.of(context).size.width * 0.18,
          //   height: 60.0,
          child: TextField(
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Couleurs.corlor_app_blue_cm,
              fontFamily: 'OpenSans',
              fontSize: 18,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14.0),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Couleurs.corlor_app_blue_cm,
                ),
                hintText: Chaine.login_email_textfield,
                hintStyle: kHintTextStyle,
                errorText: _validateEmail ? "Votre adresse e-mail ne peut pas être vide ou adresse e-mail invalide" : null,
                errorMaxLines: 1,
                errorStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
            ),
            onSubmitted: (text) {
              controllerEmail.text = text;

            },
          ),
        ),
      ],
    );
  }



  void afficherToastApple() {
    // Fluttertoast.showToast(msg: 'msg');

    isSignIn = !isSignIn;
    setState(() {

    });

    Fluttertoast.showToast(
        msg: "Veuillez bien vouloir utiliser un autre moyen de connexion",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0
    );
  }

  Future<void> LoginUserEmail  ({required String email, required String password }) async {
    try {
      Null userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        //  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.replaceAll(" ", ""),
          password: password
      ).then((value) {


        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: HomePage()
          ),
        );

        // return userCredential;
      }).whenComplete(() => print("Terminer"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        AfficherToastErreur(message: "Aucun utilisateur trouvé pour cet e-mail.");
        isSignIn = !isSignIn;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        AfficherToastErreur(message: "Mot de passe incorrect.");
        isSignIn = !isSignIn;
      }
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

  Future showActivationGeneredPopup() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBoxEdit();
        });
  }






}


// Date values
class CustomDialogBoxEdit extends StatefulWidget {
  CustomDialogBoxEdit({Key? key}) : super(key: key);

  @override
  _CustomDialogBoxEditState createState() => _CustomDialogBoxEditState();
}

class _CustomDialogBoxEditState extends State<CustomDialogBoxEdit> {
  bool stat = false;

  String message = "E-mail";

  // bool _validateChange = false;

  bool _validateEmail = false;
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    controllerEmail.dispose();
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

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, /* top: 8.0,*/ bottom: 05.0),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Text(
                          "Votre adresse e-mail",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Segoe_UI",
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10,),

                        //Editeur de texte
                        // Container(
                        //   margin: const EdgeInsets.all(07),
                        //   child: TextField(
                        //     controller: _controller,
                        //     maxLines: 1,
                        //     obscureText: false,
                        //
                        //     decoration: InputDecoration(
                        //       border: const OutlineInputBorder(),
                        //       labelText: message,
                        //       errorText: _validateEmail
                        //           ? "L'$message ne peut pas être vide ou adresse e-mail invalide"
                        //           : null,
                        //       errorMaxLines: 3,
                        //       //errorText: _validateChange ? "L'$message ne peut pas être vide" : null
                        //     ),
                        //   ),
                        // ),


                        // Email
                        InputFieldEmail(
                            headerText: "E-mail",
                            hintTexti: "exemple : abc@yahoo.fr",
                            context: context),

                        // Soumettre Button
                        Visibility(
                          visible: !stat,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: OutlinedButton(
                              onPressed: () async {
                                // //     setState(() async {
                                //
                                // //  _controller.text.isEmpty ? _validateChange = true : _validateChange = false;
                                // controllerEmail.text.isEmpty
                                //     ? _validateEmail = true
                                //     : _validateEmail = false;
                                //
                                // // Email
                                // bool emailValid = RegExp(
                                //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                //     .hasMatch(controllerEmail.text.toString());
                                // if (emailValid == true) {
                                //   _validateEmail = false;
                                // } else {
                                //   _validateEmail = true;
                                // }
                                //
                                // if (_validateEmail == false)
                                //   //   if(_controller.text.isNotEmpty)
                                //     {
                                //   // Soumettre la modification
                                //   print(controllerEmail.text);
                                //   stat = !stat;
                                //   setState(() {
                                //
                                //   });
                                //
                                //   try {
                                //     await FirebaseAuth.instance
                                //         .sendPasswordResetEmail(
                                //         email: controllerEmail.text
                                //             .toString()
                                //             .replaceAll(" ", ""))
                                //         .then((value) // =>
                                //     {
                                //       print("Sucessss");
                                //       Navigator.pop(context);
                                //
                                //       Fluttertoast.showToast(
                                //           msg: "Email de réinitialisation envoyé",
                                //           toastLength: Toast.LENGTH_SHORT,
                                //           gravity: ToastGravity.TOP,
                                //           timeInSecForIosWeb: 1,
                                //           backgroundColor: Colors.green,
                                //           textColor: Colors.white,
                                //           fontSize: 16.0);
                                //     });
                                //   } on FirebaseAuthException catch (e) {
                                //     print(e.code);
                                //     print(e.message);
                                //     // show the snackbar here
                                //     Fluttertoast.showToast(
                                //         msg: "${e.message}",
                                //         toastLength: Toast.LENGTH_SHORT,
                                //         gravity: ToastGravity.CENTER,
                                //         timeInSecForIosWeb: 1,
                                //         backgroundColor: Colors.redAccent,
                                //         textColor: Colors.white,
                                //         fontSize: 16.0);
                                //   }
                                // } else {
                                //   Fluttertoast.showToast(
                                //       msg: "Veuillez bien vouloir fournir votre adresse email",
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.TOP,
                                //       timeInSecForIosWeb: 1,
                                //       backgroundColor: Colors.red,
                                //       textColor: Colors.white,
                                //       fontSize: 14.0);
                                // }
                                // //   });
                              },
                              style: ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.padded,
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Couleurs.corlor_app_blue_cm),
                              ),
                              child: const Text(
                                'Soumettre',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          // visible: this.widget.etat_init,
                          visible: stat,
                          child: CupertinoActivityIndicator(
                            color: Couleurs.corlor_app_blue_cm,
                            animating: true,
                            radius: MediaQuery.of(context).size.width * 0.08,
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
                borderRadius: const BorderRadius.all(
                    Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/logo/logo.png")
            ),
          ),
        ),
      ],
    );
  }

  final controllerEmail = TextEditingController();
  // Email
  Widget InputFieldEmail({
    required BuildContext context,
    required String headerText,
    required String hintTexti,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
            margin: const EdgeInsets.only(
              // left: 40, right: 40,
                bottom: 10),
            decoration: BoxDecoration(
              color: Couleurs.corlor_app_blue_grey_cm,
              //  color: Couleurs.corlor_app_white_nsia.withOpacity(0.3),
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
                    prefixIcon: Icon(Icons.mail,color:  Couleurs.corlor_app_blue_cm, ),
                    hintText: hintTexti,
                    border: InputBorder.none,
                    errorText: _validateEmail
                        ? "$headerText ne peut pas être vide ou adresse e-mail invalide"
                        : null,
                    errorMaxLines: 3),
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
}

class Constants {
  static const double padding = 20;
  static const double avatarRadius = 45;
}
