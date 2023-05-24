

class UtilisateurModel {

  String uid  = "";
  String nom  = "";
  String prenom  = "";
  String name  = "";

  String email  = "";
 // String password  = "";
  String imageURL  = "";
  List<String> search  = [];

  int timeStamp  = 0;
  DateTime date_inscription = DateTime.now();
  DateTime date_late_connexion = DateTime.now();


  UtilisateurModel({


    ///
    ///
    required this. uid ,
    required this. nom  ,
    required this. prenom ,
    required this. name  ,

    required this. email ,
   // required this. password  ,
    required this. imageURL  ,
    required this. search  ,

    required this. timeStamp  ,
    required this. date_inscription,
    required this. date_late_connexion ,


  });



  UtilisateurModel.fromMap (Map<String, dynamic> map,{ String? uid} )
 {

   this.uid = uid.toString();

    this.uid = map["uid" ];
    nom = map["nom" ] ;
    prenom = map["prenom" ] ;
    name  = map["name" ];

    email = map["email" ];
   // password  = map["password" ];
    imageURL  = map["imageURL" ];
    search = List.from(map["search" ]) ;

    timeStamp = map["timeStamp" ] ;
    date_inscription = map["date_inscription" ].toDate() ;
    date_late_connexion = map["date_late_connexion" ].toDate()  ;


 }



  ///
  ///
  Map <String, dynamic> toMap () {

    final Map<String, dynamic> json = <String, dynamic>{};

    ///
    ///
    ///
    ///
    ///


    json["uid" ] = uid ;
    json["nom" ] =  nom ;
    json["prenom" ] = prenom ;
    json["name" ] = name ;

    json["email" ] =  email  ;
    // json["password" ] = password ;
    json["imageURL" ] = imageURL  ;
    json["search" ] = search  ;

    json["timeStamp" ]= timeStamp ;
    json["date_inscription" ]  = date_inscription  ;
    json["date_late_connexion" ] = date_late_connexion   ;



    ///
    ///
    ///
    ///
    
    return json;


  }


}