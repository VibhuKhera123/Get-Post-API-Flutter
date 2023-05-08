import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:loginapi/login_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final double _width = 300;
  final double _height = 300;
  final double _radius = 150;
  final String _text = "Get and Post API";
  final double _fontSize = 30;
  bool animated = false;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      animated = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 1200),
    );
    Get.to(
      () => const LoginPage(),
      transition: Transition.upToDown,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          width: animated ? MediaQuery.of(context).size.width : _width,
          height: animated ? MediaQuery.of(context).size.height : _height,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(animated ? 0 : _radius),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: animated ? 1 : 0,
              child: Text(
                _text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
