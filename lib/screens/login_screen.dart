import 'package:flutter/material.dart';
import 'package:remind_me/screens/register_screen.dart';
import 'package:remind_me/util/auth.dart';
import 'package:remind_me/util/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  UserDetails user = UserDetails();

  void validate() {
    if (formkey.currentState.validate()) {
      logIn(user.uEmail.trim(), user.uPassword.trim());
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.dangerous,
                color: Colors.red,
                size: 28,
              ),
              title: Text(":) Could not Validate"),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 75, left: 15, right: 15),
        children: [
          Center(
            child: Image.asset(
              'assets/images/splash_icon.jpg',
              height: 180.0,
              width: 180.0,
            ),
          ),
          Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: "Email",
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else if (value.length < 8) {
                        return "Should be atleast 8 character";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => user.uEmail = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: "Password",
                      icon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else if (value.length < 8) {
                        return "Should be atleast 8 character";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => user.uPassword = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: FlatButton(
                    minWidth: 250,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: validate,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.orange,
                    textColor: Colors.white,
                    splashColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account?: Sign Up",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
