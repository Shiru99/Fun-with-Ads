import 'package:flutter/material.dart';
import 'package:Ads/Authorisations/Authenticate.dart';

import 'package:Ads/Classes/SaveUser.dart';
import 'package:Ads/Pages/Home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var user = Provider.of<SaveUser>(context);
    print(user);

    // return either the Home or Authenticate widget
    if(user==null){return Authenticate();}
    return HomePage(user);

  }
}