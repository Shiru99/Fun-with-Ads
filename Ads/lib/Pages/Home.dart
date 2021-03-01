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

  List<String> postList = [];
  List<String> driveImageID = [
    "https://i.ibb.co/1QPHsZx/31.jpg",
    "https://i.ibb.co/gVvhNgY/30.jpg",
    "https://i.ibb.co/vhXd1hw/29.jpg",
    "https://i.ibb.co/WP2xgH4/28.jpg",
    "https://i.ibb.co/mCPtxHW/27.jpg",
    "https://i.ibb.co/qpNZwFJ/26.jpg",
    "https://i.ibb.co/vjN6nkn/25.jpg",
    "https://i.ibb.co/bKgwK54/24.jpg",
    "https://i.ibb.co/YpBtmrc/23.jpg",
    "https://i.ibb.co/SQYPrGD/22.png",
    "https://i.ibb.co/R0n8wmY/21.jpg",
    "https://i.ibb.co/7GTZT0N/20.jpg",
    "https://i.ibb.co/PjcsgYL/19.jpg",
    "https://i.ibb.co/dPJTD1b/18.jpg",
    "https://i.ibb.co/HHLhSx4/17.png",
    "https://i.ibb.co/VHbc04h/16.jpg",
    "https://i.ibb.co/tMQVZ2g/15.jpg",
    "https://i.ibb.co/wWN8C7p/13.jpg",
    "https://i.ibb.co/gRKZyfL/14.jpg",
    "https://i.ibb.co/ySBW5PK/12.jpg",
    "https://i.ibb.co/PCfpBdV/11.jpg",
    "https://i.ibb.co/Fh2Qcv9/10.jpg",
    "https://i.ibb.co/T0gX85F/9.jpg",
    "https://i.ibb.co/ydLMBwH/8.jpg",
    "https://i.ibb.co/J2CjxbD/7.jpg",
    "https://i.ibb.co/nM02hN8/6.jpg",
    "https://i.ibb.co/fvxJTgM/5.jpg",
    "https://i.ibb.co/QbZ8M9Z/3.jpg",
    "https://i.ibb.co/mTBK18T/4.jpg",
    "https://i.ibb.co/XxPz21r/2.jpg",
    "https://i.ibb.co/tZKYWwN/1.jpg",
  ];

  static const _adUnitID = "ca-app-pub-9018830444056918/1200725784";
  final _nativeAdController = NativeAdmobController();

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < driveImageID.length; i++) {
      postList.add(null);
      postList.add(driveImageID[i]);
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
