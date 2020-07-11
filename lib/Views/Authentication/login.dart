import 'package:ColocApp/Service/Auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  final Function toggleView;
  Login({ this.toggleView });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Center(
            child : CircularProgressIndicator()
       ) :  Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
        title: Text('CoLoCo'),

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Se connecter',
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
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe ',
                  icon: Icon(Icons.vpn_key),
                ),
                validator: (val) => val.isEmpty ? 'Entrez le mot de passe' : null,
                onChanged: (val) {
                  setState(() => password = val);
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
                  'Se connecter',
                  style: TextStyle(color: Colors.white),
                ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Combinaison e-mail mot de passe incorrecte';
                      });
                    }
                    /*else{
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                    }*/
                  }
                }
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Pas encore inscrit ? ",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF616161),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                ),
              ),
              FlatButton(
                child: new Text("S'inscrire",
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
