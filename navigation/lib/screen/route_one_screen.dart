import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

// 라우팅 할 때 값 전달 방법 1
class RouteOneScreen extends StatelessWidget {
  // 이전 페이지에서 전달받은 값
  final int number;

  const RouteOneScreen({
    required this.number,
    super.key});

  @override
  Widget build(BuildContext context) {
    // PopScope : 시스템 안에서 제공해주는 뒤로가기 버튼을 제어할 수 있음.
    return PopScope(
      // true : 뒤로가기 버튼 눌림.
      // false : 뒤로가기 버튼 안눌림.
      canPop: true,
      child: DefaultLayout(
        title: 'RouteOneScreen',
        children: [
          Text(
            'number : $number',
            textAlign: TextAlign.center,
          ),

          // 이전 페이지에 456 이라는 값 전달.
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: Text('Pop'),
          ),

          // canPop: true이면 앞으로 페이지 이동됨. false면 페이지 이동 안됨.
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).maybePop(456);
            },
            child: Text('Maybe Pop'),
          ),

          // canPop: true이면 앞으로 페이지 이동됨. false면 페이지 이동 안됨.
          OutlinedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),

          // 두 번째 스크린으로 이동
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RouteTwoScreen();
                    },
                    settings: RouteSettings(
                      // 전달할 값 : arguments: 789
                      arguments: 789,
                    )),
              );
            },
            child: Text('Push'),
          ),
        ],
      ),
    );
  }
}
