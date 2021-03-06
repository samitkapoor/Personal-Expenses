import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:personal_expenses/controller/expense_controller.dart';
import 'package:personal_expenses/core/home_page.dart';

class PersonalExpenses extends StatelessWidget {
  const PersonalExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initialising the controller
    ExpenseController expenseController = Get.put(ExpenseController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme that is followed throughout the application
      theme: ThemeData(
        // scaffoldBackgroundColor: const Color(0xff262424),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xff262424),
        // highlightColor: const Color(0xff42d6ff),
        highlightColor: Colors.white,
        indicatorColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Color(0xff42d6ff),
          titleTextStyle: TextStyle(
            // color: Color(0xff42d6ff),
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontFamily: 'OpenSans',
            fontSize: 24,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black, size: 32),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff42d6ff),
          elevation: 20,
          focusElevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          splashColor: const Color(0xff262424),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
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
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            // color: Color(0xff262424),
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: 20,
            fontWeight: FontWeight.w900,
            // color: Color(0xff262424),
            color: Colors.black,
          ),
          headline1: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            // fontStyle: FontStyle.italic,
            // color: Color(0xff262424),
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
          subtitle2: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      home: Homepage(),
    );
  }
}
