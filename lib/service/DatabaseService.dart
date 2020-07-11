import 'package:ColocApp/Models/offre.dart';
import 'package:ColocApp/Models/demande.dart';
import 'package:ColocApp/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference offersCollection = Firestore.instance.collection('offres');
  final CollectionReference requestsCollection = Firestore.instance.collection('demandes');

  //////////////////////// Demandes ////////////////////////

  Future updateUserRequest(Demande demande) async {
    FirebaseUser user = await _auth.currentUser();
    User u =await  getUserInfo(user.uid);
    
    return await requestsCollection.document().setData({
      'user_id' : user.uid,
      'budjetmax': demande.budjetmax,
      'commentaire': demande.commentaire,
      'user_tel' : u.tel,
      'user_email' : u.email,
      'user_name' : u.nom,
      
    });
  }

  List<Demande> _requestListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Demande(
          doc.documentID,
          doc.data['user_id'],
         doc.data['budjetmax'] ,
         doc.data['commentaire'],
         doc.data["user_name"],
         doc.data["user_tel"],
         doc.data["user_email"] 
      );
    }).toList();
  }

  //////////////////////// Offres ////////////////////////
  List<Offre> _offersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Offre(
          doc.documentID,
          doc.data['user_id'],
          doc.data['addresse'],
          doc.data['superficie'],
          doc.data['capacite'],
          doc.data['prix'],
          doc.data['image'],
          doc.data['description'],
          doc.data["user_name"],
          doc.data["user_tel"],
          doc.data["user_email"]
      );
    }).toList();
  }

  // get Request stream
  Stream<List<Offre>> get offers {
    return offersCollection.snapshots()
        .map(_offersListFromSnapshot);
  }


  Future updateUserOffer(Offre offre ) async {
    FirebaseUser user = await _auth.currentUser();
    User u =await  getUserInfo(user.uid);
    return offersCollection.document().setData({
      'user_id' : user.uid,
      'image' : offre.image,
      'addresse' :offre.addresse,
      'superficie' : offre.superficie,
      'prix' : offre.prix,
      'capacite' : offre.capacite,
      'description' : offre.description,
      'user_email' : u.email,
      'user_name' : u.nom,
      'user_tel' : u.tel

    });
  }

  //////////////////////// User ////////////////////////
  Stream<List<Demande>> get requests {
    return requestsCollection.snapshots()
      .map(_requestListFromSnapshot);
  }

  User _getUser(DocumentSnapshot snapshot) {
      return new User(
            snapshot.data["uid"],
            snapshot.data['nom'],
            snapshot.data['email'],
            snapshot.data['tel']);
    }
  
  Stream<User> get users {
    return offersCollection.document(uid).snapshots()
      .map(_getUser);
  }

  Future<void> updateUserData(User user) async {
    return await userCollection.document(user.uid).setData({
      'nom': user.nom,
      'tel': user.tel,
      'email' : user.email,
    });
  }
  Future<User> getUserInfo(String userId) async {
    var document =
    Firestore.instance.collection("users").document(userId).get();
    return await document.then((doc) {
      return new User(doc.data['uid'], doc.data['nom'], doc.data['email'], doc.data['tel']);
    });
  }


}