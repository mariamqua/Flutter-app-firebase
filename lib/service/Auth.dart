import 'package:ColocApp/Models/offre.dart';
import 'package:ColocApp/Models/demande.dart';
import 'package:ColocApp/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ColocApp/Service/DatabaseService.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user ,String name,String email, String phone , 
) {
    return user != null ? User(user.uid,name,email,phone) : null;

  }
  
   Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => 
    _userFromFirebaseUser(user,'','',''));
  }

  // sign in with email and password
Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password , String name, String phone) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService().updateUserData(new User(user.uid, name, email, phone));
      return _userFromFirebaseUser(user,name,email,phone );
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}