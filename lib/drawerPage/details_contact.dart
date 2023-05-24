

import 'package:contact_managers/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class DetailContactPage extends StatefulWidget {
  final ContactModel contact;

  const DetailContactPage({required this.contact});

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: // Text("data",style: TextStyle(color: Colors.red),),
        const Text("Détail", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        leading: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(180)),
          child: IconButton(
            color: Colors.black,
            highlightColor: Colors.grey,
            hoverColor: Colors.grey,
            icon: const Icon(Icons.chevron_left, size: 20, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),

      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Conatct info'),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom : ${widget.contact.nom}'),
                  Text('Prénom : ${widget.contact.prenom}'),
                  Text('Email : ${widget.contact.email}'),
                  Text('Profession : ${widget.contact.profession}'),
                  Text('Date d\'enregistrement: ${ DateFormat( "dd - MMM - yyyy à HH:mm", Localizations.localeOf(context).languageCode).format(widget.contact.date_ajout).toString()}'),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
