import 'package:flutter/material.dart';
import 'package:Ads/Authorisations/Authenticate.dart';
import 'package:Ads/Authorisations/auth.dart';
import 'package:Ads/Widgets/Logo.dart';
import 'package:Ads/Widgets/ToastMessage.dart';


// ignore: non_constant_identifier_names
Widget MainAppBar(BuildContext context,displayName) {
  AuthorisationMethods _authorisationMethods = new AuthorisationMethods();
  return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 40,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            logo(40, 50),
            Text(
              "Hi, "+displayName,//"☄️ Let's Enjoy Google Ads 🎠", // 💫🌠
              style: TextStyle(
                  fontSize: 25.0, color: Colors.white, fontFamily: "Signatra"),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _authorisationMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
                toastMessage("Signed-out successfully");
              },
              color: Colors.white,
              hoverColor: Colors.blueAccent,
            ),
          ]));
}
