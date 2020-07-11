import 'package:ColocApp/Models/offre.dart';
import 'package:ColocApp/Models/demande.dart';

class User {
  String uid;
  String nom;
  String email;
  String tel;
  List<Demande> listDemande;
  List<Offre> ListOffre;
  
  User(this.uid , this.nom, this.email,this.tel);

}