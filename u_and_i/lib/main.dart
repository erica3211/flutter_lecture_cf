import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    // 테마
    theme: ThemeData(
      // 기본 폰트
        fontFamily: 'sunflower',
        // 버튼 테마
        buttonTheme: ButtonThemeData(),

        // 글씨 테마
        textTheme: TextTheme(

          // display인지 body인지는 팀원들과 상의해서 결정
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 80.0,
            fontFamily: 'parisienne',
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        )),
    home: HomeScreen(),
  ));
}
