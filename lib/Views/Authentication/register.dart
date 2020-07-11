import 'package:ColocApp/Service/Auth.dart';
import 'package:ColocApp/Views/Home/home.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String nom = '';
  String tel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('CoLoCo'),
        backgroundColor: Colors.greenAccent,

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),

        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Créer un compte',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              Divider(
                color: Colors.black,
                height: 15,
                thickness: 4,
                indent: 60,
                endIndent: 60,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email ',
                  fillColor: Colors.white,
                  icon: Icon(Icons.email),
                ),
                validator: (val) => val.isEmpty ? 'Entrez une adresse email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe ',
                    icon: Icon(Icons.vpn_key),
                ),
                obscureText: true,
                validator: (val) =>
                    val.length < 8 ? 'Entrez un mot de passe de 8 caractères ou plus' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom ',
                    icon: Icon(Icons.perm_identity),
                ),
                validator: (val) => val.isEmpty ? 'Entrez le nom' : null,
                onChanged: (val) {
                  setState(() => nom = val);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'N° téléphone ',
                  icon: Icon(Icons.phone),
                ),
                validator: (val) => val.isEmpty ? 'Entrez le n° de téléphone' : null,
                onChanged: (val) {
                  setState(() => tel = val);
                },
              ),

              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  elevation: 5.0,
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(color: Colors.white),
                  ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password, nom, tel);
                          
                      if (result == null) {
                        setState(() {
                          error = 'Entrez une adresse e-mail valide';
                        });
                      }
                      else{Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );}
                      /**/
                    }
                  }),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Déjà sur Coloco ? ",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF616161),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                ),
              ),
              FlatButton(
                child: new Text("S'identifier ",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                  ),),
                onPressed: () => widget.toggleView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
