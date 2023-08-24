import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:provider/provider.dart';
import 'package:schoolapp/ApiCalls/auth.dart';
import 'package:schoolapp/main.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: Global.mediumBlue,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Global.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: Global.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldWidget(
                  uorp: 1,
                  hintText: 'username',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      uorp: 2,
                      hintText: 'Password',
                      obscureText: true,
                      prefixIconData: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Global.mediumBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                ButtonWidget(
                  title: 'Login',
                  hasBorder: false,
                ),
                SizedBox(
                  height: 10.0,
                ),
                ButtonWidget(
                  title: 'Sign Up',
                  hasBorder: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;

  ButtonWidget({
    required this.title,
    required this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Global.white : Global.mediumBlue,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: Global.mediumBlue,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: hasBorder ? Global.mediumBlue : Global.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          onTap: () {
            fetchLoginData(Global.username.text, Global.password.text, context);
          },
        ),
      ),
    );
  }
}

class Global {
  static const Color white = const Color(0xffffffff);
  static const Color mediumBlue = const Color(0xff4A64FE);
  static const List validEmail = ['test@gmail.com'];
  static TextEditingController username = TextEditingController();
  static TextEditingController password = TextEditingController();
}

class ClipperWidget extends CustomClipper<Path> {
  final List<Offset> waveList;
  ClipperWidget({required this.waveList});

  @override
  getClip(Size size) {
    final Path path = Path();
    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;
  final int uorp;

  TextFieldWidget(
      {required this.hintText,
      required this.prefixIconData,
      required this.obscureText,
      required this.uorp});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: uorp == 1 ? Global.username : Global.password,
      obscureText: obscureText,
      cursorColor: Global.mediumBlue,
      style: TextStyle(
        color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Global.mediumBlue),
        focusColor: Global.mediumBlue,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Global.mediumBlue),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Global.mediumBlue,
        ),
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Icon(Icons.abc),
        ),
      ),
    );
  }
}

class WaveWidget extends StatefulWidget {
  final Size size;
  final double yOffset;
  final Color color;

  WaveWidget({
    required this.size,
    required this.yOffset,
    required this.color,
  });

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000))
          ..addListener(() {
            wavePoints.clear();

            final double waveSpeed = animationController.value * 1080;
            final double fullSphere = animationController.value * Math.pi * 2;
            final double normalizer = Math.cos(fullSphere);
            final double waveWidth = Math.pi / 270;
            final double waveHeight = 20.0;

            for (int i = 0; i <= widget.size.width.toInt(); ++i) {
              double calc = Math.sin((waveSpeed - i) * waveWidth);
              wavePoints.add(
                Offset(
                  i.toDouble(), //X
                  calc * waveHeight * normalizer + widget.yOffset, //Y
                ),
              );
            }
          });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(
            waveList: wavePoints,
          ),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}
