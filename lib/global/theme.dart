import 'package:flutter/material.dart';
import 'package:social_app/global/custom_colors.dart';
import 'package:sizer/sizer.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                // fixedSize: MaterialStateProperty.all(
                //     Size.fromWidth(40)),
                backgroundColor:
                    MaterialStateProperty.all(CustomColors.primaryColor))),
        brightness: Brightness.light,
        primaryColor: CustomColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Gilory', //3
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
            color: CustomColors.primaryColor,
          ),
          subtitle2: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: CustomColors.primaryColor,
          ),
          headline5: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headline6: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w900,
              color: CustomColors.primaryColor),
          caption: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: CustomColors.primaryColor),
          headline2: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              color: Colors.black),
          headline3: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black),
          headline4: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryColor),
          subtitle1: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: CustomColors.liteGrey),
        ),
        iconTheme: IconThemeData(color: CustomColors.primaryColor, size: 35.sp),
        primaryIconTheme:
            IconThemeData(color: CustomColors.primaryColor, size: 35.sp),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.primaryColor,
        ));
  }

  static ThemeData get darkTheme {
    //1
    return ThemeData(
        //2
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                // fixedSize: MaterialStateProperty.all(
                //     Size.fromWidth(40)),
                backgroundColor:
                    MaterialStateProperty.all(CustomColors.primaryColor))),
        brightness: Brightness.dark,
        primaryColor: CustomColors.primaryColor,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        fontFamily: 'Gilory', //3
        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w900,
              color: CustomColors.primaryColor,
            ),
            headline5: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            bodyText1: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w900,
                color: CustomColors.primaryColor),
            caption: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.primaryColor),
            headline2: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black),
            headline3: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black),
            headline4: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black),
            bodyText2: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryColor),
            subtitle1: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.liteGrey)),
        iconTheme: IconThemeData(color: CustomColors.primaryColor, size: 35.sp),
        primaryIconTheme:
            IconThemeData(color: CustomColors.primaryColor, size: 35.sp),
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.primaryColor,
        ));
  }
}
