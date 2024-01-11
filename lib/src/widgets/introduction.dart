import 'package:fix/src/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroDuctPage createState() => _IntroDuctPage();
}

class _IntroDuctPage extends State<IntroPage> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/mountain.png',
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 250),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Explore Your\nFavorite Journey ',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'Let\'s Make Our Life Better',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 250),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 25,
                    ),
                    child: SwipeableButtonView(
                      buttonText: 'Let\'s Started',
                      buttonWidget: Container(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      activeColor: Color(0xFFB3C100),
                      isFinished: isFinished,
                      onWaitingProcess: () {
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            isFinished = true;
                          });
                        });
                      },
                      onFinish: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: LoginPage(),
                          ),
                        );
                        setState(() {
                          isFinished = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Menampilkan teks hanya jika tombol belum selesai digeser
                  if (!isFinished)
                    Text(
                      'Selamat Datang Di HIKY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}