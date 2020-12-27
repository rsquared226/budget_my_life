import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/db_helper.dart';

class Onboarding extends StatelessWidget {
  static const routeName = '/onboarding';

  final bool openedFromDrawer;

  // TODO: Support dark mode or force light mode.

  const Onboarding({
    this.openedFromDrawer = false,
  });

  Widget buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    final introPages = <PageViewModel>[
      PageViewModel(
        image: buildImage('Intro1'),
        title: 'Welcome to Budget My Life!',
        body: 'Here are a few things you should know to get started',
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: buildImage('Intro2'),
        title: 'Adding Transactions',
        body:
            'Click on the button in the bottom right of the dashboard screen to add a transaction!',
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: buildImage('Intro3'),
        title: 'Customize Labels',
        body:
            'Open the drawer to customize labels. These help provide you with insights on how you earn/spend your money',
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: buildImage('Intro4'),
        title: 'View Insights',
        body:
            'Click on the second bottom tab on the main screen to view your insights!',
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: buildImage('Intro5'),
        title: 'Get Started!',
        body:
            'You can always view this intro again by tapping "Help" in the drawer',
        decoration: pageDecoration,
      ),
    ];

    return IntroductionScreen(
      pages: introPages,
      skipFlex: 0,
      nextFlex: 0,
      showSkipButton: true,
      skip: const Text('SKIP'),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        'LET\'S GO',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      curve: Curves.easeInOutSine,
      onDone: () {
        if (!openedFromDrawer) {
          DBHelper.onboardedUser();
        }
        Navigator.pop(context);
      },
    );
  }
}
