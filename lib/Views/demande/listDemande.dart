import 'package:ColocApp/Models/demande.dart';
import 'package:ColocApp/Service/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:ColocApp/Views/Menu/Menu.dart';
import 'package:provider/provider.dart';

class list_demandes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Demande>>.value(
      value: DatabaseService().requests,
      child: Scaffold(
          drawer: Menu(),
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            title: Text('Les demandes',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 17.0),
            ),
            backgroundColor: Colors.greenAccent,
            elevation: 0.0,
          ),
          body: ListDemandes()),
    );
  }
}
class ListDemandes extends StatefulWidget {
  @override
  _ListDemandesState createState() => _ListDemandesState();
}

class _ListDemandesState extends State<ListDemandes> {
  @override
  Widget build(BuildContext context) {

    final requests = Provider.of<List<Demande>>(context);

    return ListView.builder(
      itemCount: requests.length ?? 0,
      itemBuilder: (context, index) {
        return DetailDemande(demande: requests[index]);
      },
    );
  }
}

class DetailDemande extends StatelessWidget {

  final Demande demande;
  DetailDemande({ this.demande });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child:new Padding(
        padding: new EdgeInsets.all(5.0),
            child: ListTile(
              leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,

                  child: Image.network("https://static.thenounproject.com/png/540038-200.png",
                  )
              ),

              title: Text("Budget max: "+demande.budjetmax.toString() +" DH"),
              subtitle: Text(demande.commentaire),
              onTap: () {
                showDialog(
                    context: context,
                    child: new SimpleDialog(
                        title: new Text("Annonceur :" +demande.user_name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w800,

                            )),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(" Budget maximum: "+demande.budjetmax.toString()+" DH") ,
                          ),
                          ListTile(
                            leading: Icon(Icons.info),
                            title: Text(" Description: "+demande.commentaire) ,
                          ),
                          ListTile(
                              leading: Icon(Icons.phone),
                              title :Text(" Tél : "+demande.user_tel)
                          ),
                          ListTile(
                              leading: Icon(Icons.mail),
                              title :Text(" Email : "+demande.user_email)
                          ),
                        ])
                );
              },
            ),
          ),
      ),
    );
  }
}