import 'package:ColocApp/Models/offre.dart';
import 'package:ColocApp/Service/DatabaseService.dart';
import 'package:flutter/material.dart';

import '../offresUser/offresUser.dart';

class AddOffre extends StatefulWidget {
  @override
  _AddOffreState createState() => _AddOffreState();
}

class _AddOffreState extends State<AddOffre> {
  final DatabaseService _databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String addresse="";
  double superficie;
  double prix;
  int capacite;
  String description = '';
  String image = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Ajouter une offre',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Montserrat', fontSize: 17.0),
            ),
            backgroundColor: Colors.greenAccent,
            elevation: 0.0,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description ',
                    ),
                    validator: (val) => val.isEmpty ? 'Entrez la Description ' : null,
                    onChanged: (val) {
                      setState(() => description = val);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Adresse ',
                    ),
                    validator: (val) => val.isEmpty ? "Entrez l'adresse" : null,
                    onChanged: (val) {
                      setState(() => addresse = val);
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Prix ',
                    ),
                    validator: (val) => val.isEmpty ? 'Entrez le prix' : null,
                    onChanged: (val) {
                      setState(() => prix = double.parse(val));
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Capacité',
                    ),
                    validator: (val) => val.isEmpty ? 'Entrez la Capacité ' : null,
                    onChanged: (val) {
                      setState(() => capacite = int.parse(val));
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Superficié',
                    ),
                    validator: (val) => val.isEmpty ? 'Entrez Superficié' : null,
                    onChanged: (val) {
                      setState(() => superficie = double.parse(val));
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Lien Image',
                    ),
                    validator: (val) => val.isEmpty ? "Entrez lien d'image" : null,
                    onChanged: (val) {
                      setState(() => image = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Ajouter une offre',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          await _databaseService.updateUserOffer(new Offre(
                              '',
                              '',
                              addresse,
                              superficie,
                              capacite,
                              prix,
                              image,
                              description,
                              null,
                              null,
                              null));

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => offresUser()));
                        }
                      }),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
