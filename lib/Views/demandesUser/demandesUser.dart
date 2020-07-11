import 'package:ColocApp/Models/demande.dart';
import 'package:ColocApp/Models/User.dart';
import 'package:ColocApp/Service/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:ColocApp/Views/Menu/Menu.dart';
import 'package:provider/provider.dart';
import '../demande/formDemande.dart';

class DemandesUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Demande>>.value(
      value: DatabaseService().requests,
      child: Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Mes Demandes',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Montserrat', fontSize: 17.0),
          ),
          backgroundColor: Colors.greenAccent,
          elevation: 0.0,
        ),
        body: UserDemandeList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddRequest()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}

class UserDemandeList extends StatefulWidget {
  @override
  _UserDemandeListState createState() => _UserDemandeListState();
}

class _UserDemandeListState extends State<UserDemandeList> {
  @override
  Widget build(BuildContext context) {
    final demandes = Provider.of<List<Demande>>(context);
    List<Demande> userOffer = new List<Demande>();

    final u = Provider.of<User>(context);

    for (var demande in demandes) {
      if (demande.uid == u.uid) userOffer.add(demande);
    }

    return ListView.builder(
      itemCount: userOffer.length ?? 0,
      itemBuilder: (context, index) {
        return list_demandes_user(demande: userOffer[index]);
      },
    );
  }
}

//list demandes

class list_demandes_user extends StatelessWidget {
  final Demande demande;

  list_demandes_user({this.demande});

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

                title: Text(" Budget: "+demande.budjetmax.toString() +" DH " ),
                subtitle: Text(" Description: "+demande.commentaire),
                trailing: Text(" Par " +demande.user_name ,
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                  ),),
              ),
            ),
      ),
    );
  }
}
