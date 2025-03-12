import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: Colors.blue,
                  ),
                ),
                TextButton(
                  onPressed: () => _controller.jumpToPage(2),
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          //PageView để chuyển slides.
          //Ngoài ra ở đây vì không dùng stack nên phải Expanded để nó biết phải chiếm hết không gian còn lại.
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
              children: [
                buildPage(
                  image: "assets/images/bro.png",
                  title: "Easy Time Management",
                  description:
                      "Manage tasks based on priority and daily routines.",
                ),
                buildPage(
                  image: "assets/images/bro2.png",
                  title: "Increase Work Effectiveness",
                  description:
                      "Improve job statistics and performance over time.",
                ),
                buildPage(
                  image: "assets/images/bro3.png",
                  title: "Reminder Notification",
                  description:
                      "Set reminders to track your assignments effectively.",
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 40, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage > 0
                    ? ElevatedButton(
                      child: Icon(Icons.arrow_back, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      
                      onPressed: () {
                        _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ) : SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    if (currentPage == 2) {
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(isLastPage ? "Get Started" : "Next", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
