import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

// 라우팅 할 때 값 전달 방법 2
class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 이전 페이지에서 전달받은 값
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return DefaultLayout(
      title: 'RouteTwoScreen',
      children: [
        Text(
          // 전달 받은 값 String으로 변환
          arguments.toString(),
          textAlign: TextAlign.center,
        ),

        // 이전 페이지에 456 값 전달
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: Text('Pop'),
        ),

        // 이름으로 페이지 이동.
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 111111,
            );
          },
          child: Text('Push Route Three'),
        ),

        // 현재 페이지를 pop한 후에 세번째 스크린을 push한다.
        OutlinedButton(
          onPressed: () {
            /// [HomeScreen, RouteOneScreen, RouteTwoScreen]
            /// push = [HomeScreen, RouteOneScreen, RouteTwoScreen, RouteThreeScreen]
            /// pushReplacement - [HomeScreen, RouteOneScreen, RouteThreeScreen]
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteThreeScreen();
                  },
                  settings: RouteSettings(
                    arguments: 999,
                  )),
            );
          },
          child: Text('Push Replacement'),
        ),

        // 현재 페이지를 pop한 후에 세번째 스크린을 push한다. (path로)
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text('Push Replacement Named'),
        ),


        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) {
                /// 만약에 삭제할거면 (Route Stack) false 반환
                /// 만약에 삭제를 안할거면 true 반환
                /// 이건 path가 '/' 인 페이지만 true이므로 스택이 '/' 만 쌓여있음.
                /// 세번째 페이지에서 뒤로가기(pop) 누르면 홈으로 이동.
                return route.settings.name == '/';
              },
              arguments: 999,
            );
          },
          child: Text('Push Replacement And Remove Until'),
        ),
      ],
    );
  }
}
