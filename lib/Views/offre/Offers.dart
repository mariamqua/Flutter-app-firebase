import 'package:ColocApp/Models/offre.dart';
import 'package:ColocApp/Service/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ColocApp/Views/Menu/Menu.dart';
import 'package:provider/provider.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Offre>>.value(
      value: DatabaseService().offers,
      child: Scaffold(
          drawer: Menu(),
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.black
            ),
            title: Text('Les Offres',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 17.0),
            ),
            backgroundColor: Colors.greenAccent,
            elevation: 0.0,
          ),
          body: ListOffre()),
    );
  }
}


class ListOffre extends StatefulWidget {
  @override
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<ListOffre> {
  @override
  Widget build(BuildContext context) {

    final offers = Provider.of<List<Offre>>(context);
    if(offers.length==null){
      offers.length=0;
    }
    return ListView.builder(

      itemCount: offers.length,
      itemBuilder: (context, index) {
        return list_offres(offre: offers[index]);
      },
    );
  }
}

class list_offres extends StatelessWidget {
  final Offre offre;

  list_offres({this.offre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Card(

          margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 4.0,
          child:new Padding(
          padding: new EdgeInsets.all(5.0),
            child:ListTile(
            leading: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.transparent,

                child: Image.network(offre.image,
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                )
            ),

            title: Text("Prix: " +offre.prix.toString()+" DH",
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
              ),),

            subtitle: Text(offre.description,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),),
            trailing: Text(offre.capacite.toString() + " personnnes",
              style: TextStyle(
                color: Colors.black38,
                fontFamily: 'Montserrat',
              ),),
            onTap: () {
              showDialog(
                context: context,
                child: new SimpleDialog(
                    title: new Text("Annonceur :" +offre.user_name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,)),
                    children: <Widget>[
                      SizedBox(height: 10.0),

                      ListTile(
                        leading: Icon(Icons.monetization_on),
                        title:
                        Text(" Prix : " + offre.prix.toString() + " DH"),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(" Addresse : " + offre.addresse),
                      ),

                      ListTile(
                        leading: Icon(Icons.people),
                        title: Text(" Capacité  : " +
                            offre.capacite.toString() +
                            " Personnes"),
                      ),
                      ListTile(
                        leading: Icon(Icons.crop_square),
                        title:
                        Text(" Superficié : " + offre.superficie.toString()),
                      ),
                      ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(" Tél : " + offre.user_tel)),
                      ListTile(
                          leading: Icon(Icons.mail),
                          title: Text(" Email : " + offre.user_email)),
                    ]

                ),);
            },
          ),
        ),
      ),
      ),
    );
  }
}