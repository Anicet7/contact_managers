import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_managers/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';



void main() {

  // Init Firebase
  init_firebase ();
  // init_windowsManager ();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );


  runApp(const MyApp());
}

Future<void> init_firebase () async {

  // Firebase initailisation
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Crash analytique
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(true);

  // Firestor
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseApp secondaryApp = Firebase.app();
  firestore = FirebaseFirestore.instanceFor(app: secondaryApp);

  // All other platforms.
  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: true);

}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // /*
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        //  Locale('fr'), // English
        Locale('fr', 'FR'), // English
        // Locale('en'),
        // English
        // const Locale('de', 'DE'), // German
        // ... other locales the app supports
      ],

      //  */
      title: "Contact Manager",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home:  const Splash(),
    );
  }
}
