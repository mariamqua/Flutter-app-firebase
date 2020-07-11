import 'package:ColocApp/Models/demande.dart';
import 'package:ColocApp/Service/DatabaseService.dart';
import 'package:flutter/material.dart';

import 'listDemande.dart';

class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final DatabaseService _databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String commentaire = '';
  double budjet;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Ajouter une demande',
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
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Budjet maximum *',
                  ),
                  validator: (val) => val.isEmpty ? 'Saisir votre budjet' : null,
                  onChanged: (val) {
                    setState(() => budjet = double.parse(val));
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Décrivez le logement recherché *',
                  ),
                  validator: (val) => val.isEmpty ?
                       'Saisir la discription sur le logement'
                      : null,
                  onChanged: (val) {
                    setState(() => commentaire = val);
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Ajouter la demande',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        await _databaseService.updateUserRequest(new Demande(
                            '', '', budjet, commentaire, null, null, null));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => list_demandes()));
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
      ),
    );
  }
}
