

class ContactModel {

  String uid  = "";
 // String auteur_uid  = "";
  String nom  = "";
  String prenom  = "";
  String name  = "";

  String email  = "";
  String telephone  = "";
  String profession  = "";
  String imageURL  = "";

  List<String> search  = [];
  int timeStamp  = 0;
  DateTime date_ajout = DateTime.now();


  ContactModel({



    ///
    ///
    required this. uid ,
  //  required this. auteur_uid ,
    required this. nom  ,
    required this. prenom ,
    required this. name  ,

    required this. email ,
    required this. imageURL  ,
    required this. search  ,
    required this. telephone  ,
    required this. profession  ,

    required this. timeStamp  ,
    required this. date_ajout,

  });


  
  ContactModel.fromMap (Map<String, dynamic> map,{ String? uid} )
 {

   this.uid = uid.toString();

    this.uid = map["uid" ];
   // auteur_uid = map["auteur_uid" ] ;
    nom = map["nom" ] ;
    prenom = map["prenom" ] ;
    name  = map["name" ];

    email = map["email" ];
    imageURL  = map["imageURL" ];
    search = List.from(map["search" ]) ;

    timeStamp = map["timeStamp" ] ;
    date_ajout = map["date_ajout" ].toDate() ;

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
   // json["auteur_uid" ] = auteur_uid ;
    json["nom" ] =  nom ;
    json["prenom" ] = prenom ;
    json["name" ] = name ;

    json["email" ] =  email  ;
    json["imageURL" ] = imageURL  ;
    json["search" ] = search  ;

    json["timeStamp" ]= timeStamp ;
    json["date_ajout" ]  = date_ajout  ;

    ///
    ///
    ///
    ///
    
    return json;


  }


}