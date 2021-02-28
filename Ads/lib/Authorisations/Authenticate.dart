import 'package:flutter/material.dart';
import 'package:Ads/Authorisations/auth.dart';
import 'package:Ads/Classes/SaveUser.dart';
import 'package:Ads/Pages/Home.dart';
import 'package:Ads/Widgets/Loading.dart';
import 'package:Ads/Widgets/Logo.dart';
import 'package:Ads/Widgets/ToastMessage.dart';

class Authenticate extends StatefulWidget {
  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  SaveUser _user;
  AuthorisationMethods _authorisationMethods = new AuthorisationMethods();
  var _isLoading = false;

  reset() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  nextPage(SaveUser _user) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(_user)));
  }

  signingWithGoogle() async {
    reset();
    try {
      await _authorisationMethods
          .signInWithGoogle()
          .then((value) => _user = value);

      if (_user == null) {
        reset();
      } else {
        toastMessage("Welcome, " + _user.displayName);
        nextPage(_user);
      }
    } catch (e) {
      toastMessage(e.toString());
      reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: MainAppBar(context),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: _isLoading
            ? loading(context)
            : LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                            minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: logo(width * 4 / 5, width),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 35.0, bottom: 30.0),
                                child: Text(
                                  "🐰 Let's Enjoy Google Ads ☀️", // 💫🌠🐰🌥️ ☀️ 🎠	🏫
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                      fontFamily: "Signatra"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  // color: Colors.green,
                                  ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 0.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          print("Button Tapped");
                                          signingWithGoogle();
                                        },
                                        child: Container(
                                          width: 280.0,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(22.5)),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/google1.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 40,top:20),
                                    child: Text(
                                      "By  Shiru",
                                      style: TextStyle(
                                        fontSize: 32.0,
                                        color: Colors.black,
                                        fontFamily: "Signatra",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        )));
              })

        // body: _isLoading
        //     ? loading(context)

        //     : SingleChildScrollView(
        //         child: Container(
        //           child: Center(
        //             child: Column(
        //               mainAxisSize: MainAxisSize.max,
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.center,

        //               children: <Widget>[
        //                 Container(
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(top: 100.0),
        //                     child: logo(width * 4 / 5, width),
        //                   ),
        //                 ),
        //                 Container(
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(top: 28.0, bottom: 30.0),
        //                     child: Text(
        //                       "🏫  Let's Enjoy Google Ads 🎠", // 💫🌠🐰🌥️☄️ ☀️ 	🏫
        //                       style: TextStyle(
        //                           fontSize: 30.0,
        //                           color: Colors.black,
        //                           fontFamily: "Signatra"),
        //                     ),
        //                   ),
        //                 ),
        //                 Container(
        //                   child: Padding(
        //                     padding: const EdgeInsets.symmetric(
        //                         vertical: 10.0, horizontal: 0.0),
        //                     child: GestureDetector(
        //                       onTap: () {
        //                         print("Button Tapped");
        //                         signingWithGoogle();
        //                       },
        //                       child: Container(
        //                         width: 280.0,
        //                         height: 45.0,
        //                         decoration: BoxDecoration(
        //                           borderRadius:
        //                               BorderRadius.all(Radius.circular(22.5)),
        //                           color: Colors.white,
        //                           image: DecorationImage(
        //                             image: AssetImage("assets/images/google1.png"),
        //                             fit: BoxFit.cover,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Container(
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(bottom: 30),
        //                     child: Text(
        //                       "By  Shiru",
        //                       style: TextStyle(
        //                         fontSize: 32.0,
        //                         color: Colors.black,
        //                         fontFamily: "Signatra",
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 10,
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),

        );
  }
}
