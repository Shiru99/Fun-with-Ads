// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:Ads/Classes/SaveUser.dart';
import 'package:Ads/Widgets/Loading.dart';
import 'package:Ads/Widgets/MainAppBar.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

import 'package:flutter_native_admob/native_admob_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  SaveUser _user;
  HomePage(this._user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = true;

  List<String> postList = [ ];

  static const _adUnitID = "ca-app-pub-9018830444056918/1200725784";
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    

    for (var i = 0; i < 5; i++) {
      postList.add(null);
      postList.add("https://photos.app.goo.gl/wna2aAWf3ZNTiqoe7");
    }

    _isLoading = false;

    return Scaffold(
      appBar: MainAppBar(context, widget._user.displayName),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? loading(context) // null //
          : new ListView.builder(
              itemCount: postList.length,
              itemBuilder: (_, index) {
                return postUI(postList[index], _nativeAdController);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Refresh Ads"),
        onPressed: () {
          _nativeAdController.reloadAd(forceRefresh: true);
        },
      ),
    );
  }

  Widget postUI(
    String link,
    NativeAdmobController nativeAdController,
  ) {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: link != null
          ? Container(
              padding: new EdgeInsets.all(15.0),
              child: Image.network(
                link,
                fit: BoxFit.cover,
              ),
            )
          : Container(
              height: 330,
              padding: new EdgeInsets.all(15.0),
              child: NativeAdmob(
                adUnitID: _adUnitID,
                // numberAds: 3,
                type: NativeAdmobType.full,
                controller: _nativeAdController,
              ),
            ),
    );
  }
}
