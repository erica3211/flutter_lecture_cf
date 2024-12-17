import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int number;

  const RouteOneScreen({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    // PopScope : 시스템 안에서 제공해주는 뒤로가기 버튼을 제어할 수 있음.
    // true : 뒤로가기 버튼 눌림.
    // false : 뒤로가기 버튼 안눌림.
    return PopScope(
      canPop: false,
      child: DefaultLayout(
        title: 'RouteOneScreen',
        children: [
          Text(
            'number : $number',
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: Text('Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).maybePop(456);
            },
            child: Text('Maybe Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RouteTwoScreen();
                    },
                    settings: RouteSettings(
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
