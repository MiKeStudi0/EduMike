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
  final PageController _pageController = PageController();
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

          // Indicator and navigation buttons
          Positioned(
            bottom: 40.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (onFirstPage)
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(1);
                    },
                    child: const Text('Skip', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  ),
                if (!onFirstPage)
                  GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                    child: const Text('Back', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color.fromARGB(255, 255, 255, 255),
                    dotColor: Colors.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                if (onLastPage)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeIn;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, secondaryAnimation) => const LetSYouInScreen(),
                        ),
                      );
                    },
                    child: const Text('Done', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  ),
                if (!onLastPage)
                  GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text('Next', style: TextStyle(color: Color.fromARGB(255, 235, 237, 239))),
                  ),
              ],
            ),
          ),
    
        ],
      ),
    );
  }
}
