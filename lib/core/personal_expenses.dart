import 'package:flutter/material.dart';

import 'package:personal_expenses/core/home_page.dart';

class PersonalExpenses extends StatelessWidget {
  const PersonalExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff262424),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          foregroundColor: Color(0xff9381d6),
          titleTextStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: Color(0xff9381d6),
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
            fontSize: 28,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff9381d6),
          elevation: 20,
          focusElevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          splashColor: const Color(0xff262424),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 32,
          opacity: 1,
        ),
        tooltipTheme: const TooltipThemeData(
          textStyle: TextStyle(
            fontFamily: 'OpenSans',
            color: Colors.white,
            fontSize: 16,
          ),
          waitDuration: Duration(seconds: 2),
          showDuration: Duration(seconds: 2),
          preferBelow: true,
          triggerMode: TooltipTriggerMode.longPress,
          verticalOffset: 30,
        ),
      ),
      home: Homepage(),
    );
  }
}
