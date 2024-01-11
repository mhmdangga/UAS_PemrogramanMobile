import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Menggunakan ReverseTween agar animasi mundur otomatis tanpa perlu menentukan nilai begin dan end
    _scaleAnimation = _controller.drive(Tween<double>(
      begin: 1.0, // Mulai dari skala penuh
      end: 0.9,
    ).chain(CurveTween(curve: Curves.easeInOutBack)));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    Timer(Duration(seconds: 2), () {
      try {
        setState(() {
          isLoading = true;
        });

        _controller.forward();

        Timer(Duration(seconds: 5), () {
          Navigator.pushNamed(context, '/intro');
        });
      } catch (e) {
        print('Error navigating to login page: $e');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 5),
        color: Color(0xFF265073),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: isLoading
                    ? SizedBox(
                        width: 200.0,
                        height: 200.0,
                        child: Image.asset(
                          'assets/logo/HIKY.png',
                        ),
                      )
                    : Container(),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
