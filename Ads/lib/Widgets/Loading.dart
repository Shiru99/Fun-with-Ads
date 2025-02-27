import 'dart:math';
import 'package:flutter/material.dart';
import 'package:Ads/Widgets/Logo.dart';

Container loading(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ColorLoader3(radius: width / 3, dotRadius: width / 25),
        ],
      ),
    ),
  );
}



class ColorLoader3 extends StatefulWidget {
  final double radius;
  final double dotRadius;

  ColorLoader3({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _ColorLoader3State createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader3>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  Animation<double> animation_rotation;
  // ignore: non_constant_identifier_names
  Animation<double> animation_radius_in;
  // ignore: non_constant_identifier_names
  Animation<double> animation_radius_out;
  AnimationController controller;

  double radius;
  double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius; // width/3
    dotRadius = widget.dotRadius; // width/25

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 2500),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: 200.0,
      height: 200.0,
      //color: Colors.black12,
      child: new Center(
        child: new Stack(
          children: <Widget>[
            logo(width / 2.5, width),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Loading . . .",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.green[400],
                    fontFamily: "Signatra"
                    ),
              ),
            ),
            new RotationTransition(
              turns: animation_rotation,
              child: new Container(
                //color: Colors.limeAccent,
                child: new Center(
                  child: Stack(
                    children: <Widget>[
                      // new Transform.translate(
                      //   offset: Offset(0.0, 0.0),
                      //   // child: logo(width * 4 / 10, width / 2),
                      //   // Dot(
                      //   //   radius: radius,
                      //   //   // color: Colors.black12,

                      //   // ),
                      // ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.amber,
                        ),
                        offset: Offset(
                          radius * cos(0.0),
                          radius * sin(0.0),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.deepOrangeAccent,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 1 * pi / 4),
                          radius * sin(0.0 + 1 * pi / 4),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.pinkAccent,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 2 * pi / 4),
                          radius * sin(0.0 + 2 * pi / 4),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.purple,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 3 * pi / 4),
                          radius * sin(0.0 + 3 * pi / 4),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.yellow,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 4 * pi / 4),
                          radius * sin(0.0 + 4 * pi / 4),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.lightGreen,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 5 * pi / 4),
                          radius * sin(0.0 + 5 * pi / 4),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.orangeAccent,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 6 * pi / 4),
                          radius * sin(0.0 + 6 * pi / 4),
                        ),
                      ),
                      new Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.blueAccent,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 7 * pi / 4),
                          radius * sin(0.0 + 7 * pi / 4),
                        ),
                      ),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
