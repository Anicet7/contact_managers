
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:page_transition/page_transition.dart';


import 'drawerPage/accueil.dart';
import 'drawerPage/addNewContact.dart';
import 'drawerPage/aide_support_page.dart';
import 'drawerPage/apropos_page.dart';
import 'drawerPage/politique_page.dart';
import 'drawerPage/profil_page.dart';
import 'login/loginPage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key,/* required this.title*/});

 // final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 1;

  final AllPage =  [
      ProfilePage (),  // 0 // Mon compte
      AccueilPage (),  // 1 // Accueil
      AproposPage (), // 2 // A propos
      AideSupportPage (), // 3 // Aide et support
      PolitiquePage (), // 4 // Politique
      Container (color: Colors.brown), // 5 // Deconnexion

  ];

  final HeaderTitle = [
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,

        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.all(06),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(180)),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () { Scaffold.of(context).openDrawer(); },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),

        // actions: [
        //   IconButton(onPressed: (){
        //
        //    }, icon: const Icon(Icons.search, color: Colors.black,))
        // ],
      ),


      body:  AllPage[selectedPage],

      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            // User Name
            // User Email
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/logo/logo.png',
                        width: MediaQuery.of(context).size.width /6,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Nom
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName.toString(),
                        //'DOSSOU Jean',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                       // 'dossou@yahoo.fr',
                        style:  const TextStyle(
                            fontSize: 15, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  )),
            ),

            // 0
            // Mon compte
            ListTile(
              selected: (selectedPage == 0) ? true : false,
              selectedColor: Colors.green,
              selectedTileColor: Colors.grey.shade200,
              leading:  Icon(
                Icons.account_circle_rounded,
                color: (selectedPage == 0 ) ? Colors.green :  Colors.black,
              ),

              title: const Text('Mon compte'),
              onTap: () {
                selectedPage = 0 ;
                setState((){});
                Navigator.pop(context);
              },
            ),

            // 1
            // Accueil
            ListTile(
              selected: (selectedPage == 1) ? true : false,
              selectedColor: Colors.blueAccent,
              selectedTileColor: Colors.grey.shade200,
              leading:  Icon(
                Icons.home,
                color: (selectedPage == 1 ) ? Colors.blueAccent :  Colors.black,
              ),
              title: const Text('Accueil'),
              onTap: () {

                selectedPage = 1 ;
                setState((){});
                Navigator.pop(context);
              },
            ),

            // 2
            // About
            ListTile(
              selected: (selectedPage == 2) ? true : false,
              selectedColor: Colors.blueAccent,
              selectedTileColor: Colors.grey.shade200,
              leading:  Icon(
                Icons.info,
                color: (selectedPage == 2 ) ? Colors.blueAccent :  Colors.black,
              ),
              title: const Text('À propos'),
              onTap: () {

                selectedPage = 2 ;
                setState((){});
                Navigator.pop(context);
              },
            ),

            // 3
            // Aide
            ListTile(
              selected: (selectedPage == 3) ? true : false,
              selectedColor: Colors.green,
              selectedTileColor: Colors.grey.shade200,
              leading:  Icon(
                Icons.help_center,
                color: (selectedPage == 3 ) ? Colors.green :  Colors.black,
              ),
              title: const Text('Aide & Support'),
              onTap: () {

                selectedPage = 3 ;
                setState((){});
                Navigator.pop(context);

                /*
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const AideSupportPage()),
                );
                */
              },
            ),

            // 4
            // Politique
            ListTile(
              selected: (selectedPage == 4) ? true : false,
              selectedColor: Colors.redAccent,
              selectedTileColor: Colors.grey.shade200,
              leading:  Icon(
                Icons.security_sharp,
                color: (selectedPage == 4 ) ? Colors.redAccent :  Colors.black,
              ),
              title: const Text("Politique de confidentialité & Conditions d\'utilisation"),
              //title: const Text('Politique & Condition d\'utilisation'),
              onTap: () {

                selectedPage =  4 ;
                setState((){});
                Navigator.pop(context);
                /*
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const PolitiqueConditionPage()),
                );
                */
              },
            ),

            // Deconnexion
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text('Déconnexion'),
              onTap: () {
              //  Navigator.pop(context);

                FirebaseAuth.instance.signOut().then((value)
                {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: LoginPage(),
                      )
                  );
                });

              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
               // child: AddContact()
                child: AddNewContact()
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
