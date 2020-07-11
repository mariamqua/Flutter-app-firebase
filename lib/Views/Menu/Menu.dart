import 'package:ColocApp/Service/Auth.dart';
import 'package:ColocApp/Views/Authentication/login.dart';
import 'package:ColocApp/Views/Home/home.dart';
import 'package:ColocApp/Views/demande/listDemande.dart';
import 'package:ColocApp/Views/demandesUser/demandesUser.dart';
import 'package:ColocApp/Views/offre/Offers.dart';
import 'package:ColocApp/Views/offresUser/offresUser.dart';

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(

        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(6),
              color: Colors.grey,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 10),
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/colocation.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      "Colocation",
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Accueil'),
                focusColor: Colors.grey,
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('Les Offres'),
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Offers()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('Les Demandes'),
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => list_demandes()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('Mes demandes'),
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DemandesUser()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('Mes offres'),
                dense: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => offresUser()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Se déconnecter'),
                dense: true,
                onTap: () async {
                  await _auth.signOut();

                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
                },
              ),
          ],
        ));
      }
    }
