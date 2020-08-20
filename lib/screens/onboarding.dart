import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/db_helper.dart';

class Onboarding extends StatelessWidget {
  static const routeName = '/onboarding';

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
        title: 'Test',
        body: 'Test12',
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'Test',
        body: 'Test12',
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
        DBHelper.onboardedUser();
        Navigator.popAndPushNamed(context, '/');
      },
    );
  }
}
