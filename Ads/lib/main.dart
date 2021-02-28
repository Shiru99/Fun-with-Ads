import 'package:flutter/material.dart';
import 'Authorisations/auth.dart';
import 'Classes/SaveUser.dart';
import 'Pages/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<SaveUser>.value(
      value: AuthorisationMethods().user,
      child: MaterialApp(
        title: 'Ads',
        debugShowCheckedModeBanner: true,
        // theme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.green , //Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.lightGreen[100],
        ),
        home: Wrapper(),
      ),
    );
  }
}