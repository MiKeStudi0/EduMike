import 'package:edumike/screens/loginscreen/into_two_screen.dart';
import 'package:edumike/screens/loginscreen/intro_one_screen.dart';
import 'package:edumike/screens/loginscreen/intro_three_screen.dart';
import 'package:edumike/screens/loginscreen/let_s_you_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  PageController _pageController = PageController();
  bool onLastPage = false;
  bool onFirstPage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                onFirstPage = (index == 0);
              });
            },
            children: const [
              IntroOneScreen(),
              introTwoScreen(),
              introThreeScreen(),
            ],
          ),

          //indicator
          Container(
              alignment: const Alignment(0, 0.83),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  onFirstPage
                      ? GestureDetector(
                          onTap: () {
                            _pageController.jumpToPage(2);
                          },
                          child: const Text('Skip'))
                      : GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          },
                          child: const Text('Back')),

                  //indicator
                  SmoothPageIndicator(controller: _pageController, count: 3),
                  //Nest or DOne
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds:
                                        500), // Adjust duration as needed
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0,
                                      0.0); // Define the start position of the new screen
                                  const end = Offset
                                      .zero; // Define the end position of the new screen
                                  const curve = Curves
                                      .easeIn; // Define the curve of the transition
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        LetSYouInScreen(),
                              ),
                            );
                          },
                          child: const Text('Done'))
                      : GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text('Next')),
                ],
              )),
        ],
      ),
    );
  }
}
