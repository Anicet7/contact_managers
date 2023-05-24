
import 'package:contact_managers/values/colorValues.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'login/loginPage.dart';
import 'model/slider.dart';

class WalkthrougPage extends StatefulWidget {
  const WalkthrougPage({Key? key}) : super(key: key);

  @override
  State<WalkthrougPage> createState() => _WalkthrougPageState();
}

class _WalkthrougPageState extends State<WalkthrougPage> {

  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<Widget> _pages = [


    const SliderPage(
        title: "Bienvenue",
        description:
        "Avec votre compte Contact Manager, tous vos contacts sont à portée de main",
        image: "assets/walk/walk_a.svg"),


    const SliderPage(
        title: "Suivi",
        description:
        "Enregistrez et acceptez vos contacts de n'importe où avec votre application",
        image: "assets/walk/walk_b.svg"),


    const SliderPage(
        title: "Let's go",
        description:
        "Démarrez dès maintenant en cliquant sur le bouton ci-dessous.",
        image: "assets/walk/walk_c.svg"),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[


              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Couleurs.corlor_app_black_cm
                                : Couleurs.corlor_app_blue_cm.withOpacity(0.5)));
                  })),
              InkWell(
                onTap: () {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint);
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  height:  MediaQuery.of(context).size.width * 0.15,
                //  height: 70,
                  width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                  decoration: BoxDecoration(
                      color: Couleurs.corlor_app_black_cm,
                     // color: Couleurs.corlor_app_blue_momo,
                      borderRadius: BorderRadius.circular(35)),
                  child: (_currentPage == (_pages.length - 1))
                      ? GestureDetector(

                        child:  TextButton(

                          onPressed: (){

                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child:  LoginPage()
                                //   child:   Home()
                                // Lunch Walk
                                // if user auth = false
                                // Else lunch Hom
                              ),
                            );

                          }, child: const Text(
                          "Connectez-vous",
                          style: TextStyle(
                             color: Colors.white,
                           // color: Couleurs.corlor_app_blue_cm,
                            fontSize: 18,
                            //fontWeight:  FontWeight.bold
                          ),
                        ),
                  ),
                      )
                      : const Icon(
                    Icons.navigate_next,
                    size: 50,
                 //   color: Couleurs.corlor_app_blue_cm,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}
