
import 'package:flutter/material.dart';

import 'color.dart';

class MyThemeData{

 static ThemeData lightTheme=ThemeData(
   primaryColor: primaryColor,
   scaffoldBackgroundColor:bkgColorGreen,
   colorScheme: ColorScheme(
       brightness: Brightness.light,
       primary: primaryColor,
       onPrimary: Colors.white,
       secondary: bkgColorGreen,
       onSecondary: Colors.white,
       error: Colors.red,
       onError: Colors.white,
       background: bkgColorGreen,
       onBackground: primaryColor,
       surface: Colors.grey,
       onSurface: Colors.white,
   ),
    appBarTheme: AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
        subtitle1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorBlack
        ),
      subtitle2: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: primaryColor
      )
    ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
       elevation: 0,
         backgroundColor: Colors.transparent,
         selectedItemColor: primaryColor,
         unselectedItemColor: Colors.grey
     ),
   floatingActionButtonTheme: FloatingActionButtonThemeData(
     backgroundColor: primaryColor,
   )
  );

 static ThemeData darkTheme=ThemeData(
   primaryColor: primaryColor,
   scaffoldBackgroundColor:bkgDarkColor,
   colorScheme: ColorScheme(
     brightness: Brightness.light,
     primary: primaryColor,
     onPrimary: Colors.white,
     secondary: bkgDarkColor,
     onSecondary: Colors.white,
     error: Colors.red,
     onError: Colors.white,
     background: bkgDarkColor,
     onBackground: primaryColor,
     surface: Colors.grey,
     onSurface: Colors.white,
   ),
   appBarTheme: AppBarTheme(
     color: primaryColor,
     iconTheme: IconThemeData(color: colorBlack),
   ),
   textTheme: TextTheme(
       headline1: TextStyle(
         fontSize: 25,
         fontWeight: FontWeight.bold,
         color: colorBlack,
       ),
       subtitle1: TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.bold,
           color: Colors.white
       ),
       subtitle2: TextStyle(
           fontSize: 15,
           fontWeight: FontWeight.bold,
           color: primaryColor
       )
   ),
   bottomNavigationBarTheme: BottomNavigationBarThemeData(
       backgroundColor: navBkgDarkColor,
       selectedItemColor: primaryColor,
       unselectedItemColor: Colors.white
   ),
 );
}