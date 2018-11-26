import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/bloc/bloc.dart';
import 'package:todo_app/src/bloc/provider.dart';
import 'package:todo_app/src/screen/home.dart';
import 'package:todo_app/src/screen/signup.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isBusy = false;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Align(
                child: LinearProgressIndicator(),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
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
                        "Login",
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
                      SizedBox(height: 20.0),
                      _buildSubmitButton(context, bloc),
                      SizedBox(height: 8.0),
                      buildRegisterRow(context)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildRegisterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(
            "Sign up",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
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
            child: Text("Login"),
            onPressed: !snapshot.hasData
                ? null
                : () {
                    performLogin(bloc, context);
                  },
          );
        },
      ),
    );
  }

  performLogin(Bloc bloc, BuildContext context) async {
    try {
      setState(() {
        isBusy = true;
      });
      FirebaseUser user = await bloc.loginUser();
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (ex) {
      setState(() {
        isBusy = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Username or Password"),
      ));
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //           title: Text("Error"),
      //           content: Text("Invalid username or password"),
      //         ));
    }
  }
}
