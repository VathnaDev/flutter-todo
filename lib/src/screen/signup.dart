import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/bloc/bloc.dart';
import 'package:todo_app/src/bloc/provider.dart';
import 'package:todo_app/src/screen/home.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome To Khmer Todo",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                Text(
                  "New Account",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontFamily: 'Raleway',
                  ),
                ),
                SizedBox(height: 20.0),
                _buildEmailInput(bloc),
                SizedBox(height: 8.0),
                _buildPasswordInput(bloc),
                SizedBox(height: 8.0),
                _buildSubmitButton(context, bloc)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildEmailInput(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.email,
    builder: (context, snapshot) {
      return TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        onChanged: bloc.changeEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          border: OutlineInputBorder(),
          errorText: snapshot.error,
        ),
      );
    },
  );
}

Widget _buildPasswordInput(Bloc bloc) {
  return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            border: OutlineInputBorder(),
            errorText: snapshot.error,
          ),
        );
      });
}

Widget _buildSubmitButton(BuildContext con, Bloc bloc) {
  return SizedBox(
    width: double.infinity,
    height: 40.0,
    child: StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          textColor: Colors.white,
          disabledTextColor: Colors.grey,
          child: Text("Register"),
          onPressed: !snapshot.hasData
              ? null
              : () {
                  performRegisterAccount(bloc, context);
                },
        );
      },
    ),
  );
}

performRegisterAccount(Bloc bloc, BuildContext context) async {
  FirebaseUser user = await bloc.registerUser();
  if (user == null) {
    print("Invalid");
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
