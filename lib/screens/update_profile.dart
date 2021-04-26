import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/util/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Updateprofile extends StatefulWidget {
  final UserDetails userData;
  Updateprofile({this.userData});
  @override
  _UpdateprofileState createState() => _UpdateprofileState(userData);
}

class _UpdateprofileState extends State<Updateprofile> {
  UserDetails userData;
  _UpdateprofileState(this.userData);
  // variables
  bool showPassword = false;
  final db = FirebaseFirestore.instance;
  File image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          onPressed: () {
            cancel();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
        child: ListView(children: [
          Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 2,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 10),
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${userData.uProfilePic}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 4),
                    ),
                    child: IconButton(
                      splashColor: Colors.black26,
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          buildTextField("Full Name", "${userData.uName}", false, "name"),
          buildTextField("Email Id", "${userData.uEmail}", false, "email"),
          buildTextField("Type", "${userData.uType}", false, "type"),
          buildTextField("Password", "********", true, "password"),
          SizedBox(
            height: 35,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            OutlineButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                cancel();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2.2,
                  color: Colors.black,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                save();
              },
              color: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2.2,
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ]),
      ),
    );
  }

  Widget buildTextField(String labeltext, String placeholder,
      bool isObscureTextField, String textField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35),
      child: TextField(
        onChanged: (value) {
          if (textField == "name") {
            userData.uName = value.trim();
          } else if (textField == "email") {
            userData.uEmail = value.trim();
          } else if (textField == "type") {
            userData.uType = value.trim();
          } else {
            userData.uPassword = value.trim();
          }
        },
        obscureText: isObscureTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isObscureTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labeltext,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void cancel() {
    print('');
    Navigator.pop(context);
  }

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadFile(File file) async {
    // File file = File(filePath);
    await firebase_storage.FirebaseStorage.instance
        .ref('images/${userData.uId}/profile.jpg')
        .putFile(file);
  }

  void save() {
    db.collection('/users').doc('/${userData.uId}').set({
      'name': userData.uName,
      'email': userData.uEmail,
      'type': userData.uType,
      'password': userData.uPassword,
    });
    uploadFile(image).whenComplete(() {
      Navigator.pop(context);
    });
  }
}
