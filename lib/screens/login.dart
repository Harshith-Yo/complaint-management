import 'package:complaint_management/main.dart';
import 'package:complaint_management/screens/admin_home.dart';
import 'package:complaint_management/screens/techni_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import '../helpers/auth.dart';
import 'home.dart';

bool _isSignedIn = false;
bool get signInStatus => _isSignedIn;

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.6,
              child: Image.asset(
                'assets/port.jpg',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              // alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  signIn().then((value) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Image.asset(
                            'assets/google.png',
                          ),
                        ),
                      ),
                      Text(
                        "Sign In with Google",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
    )
            // Container(
            //     padding: const EdgeInsets.all(20.0),
            //     child: SingleChildScrollView(
            //         child: Form(
            //       key: _loginFormKey,
            //       child: Column(
            //         children: <Widget>[
            //           TextFormField(
            //             decoration: InputDecoration(
            //                 labelText: 'Email*', hintText: "john.doe@gmail.com"),
            //             controller: emailInputController,
            //             keyboardType: TextInputType.emailAddress,
            //             validator: emailValidator,
            //           ),
            //           TextFormField(
            //             decoration: InputDecoration(
            //                 labelText: 'Password*', hintText: "********"),
            //             controller: pwdInputController,
            //             obscureText: true,
            //             validator: pwdValidator,
            //           ),
            //           RaisedButton(
            //             child: Text("Login"),
            //             color: Theme.of(context).primaryColor,
            //             textColor: Colors.white,
            //             onPressed: () {
            //               if (_loginFormKey.currentState.validate()) {
            //                 FirebaseAuth.instance
            //                     .signInWithEmailAndPassword(
            //                         email: emailInputController.text,
            //                         password: pwdInputController.text)
            //                     .then((currentUser) => FirebaseFirestore.instance
            //                         .collection("users")
            //                         .doc(currentUser.user.uid)
            //                         .get()
            //                         .then((value) => Navigator.pushReplacement(
            //                             context,
            //                             MaterialPageRoute(
            //                                 builder: (context) => products())))
            //                         .catchError((err) => print(err)))
            //                     .catchError((err) => print(err));
            //               }
            //             },
            //           ),
            //           ElevatedButton(
            //             child: Text("Click here to Sign-in with Google!"),
            //             onPressed: () {
            //               signIn().then((value) => Navigator.of(context)
            //                   .pushReplacement(MaterialPageRoute(
            //                       builder: (context) => products())));
            //             },
            //           )
            //         ],
            //       ),
            //     )))
            ));
  }
}
