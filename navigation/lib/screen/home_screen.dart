import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultLayout(
        title: 'HomeScreen',
        children: [
          OutlinedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteOneScreen(
                      number: 20,
                    );
                  },
                ),
              );
              print(result);
            },
            child: Text('Push'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: Text('Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              // pop을 좀 더 안전하게 할 수 있는 방법
              Navigator.of(context).maybePop(456);
            },
            child: Text('Maybe Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              // canPop은 반환값을 돌려준다.
              // true : 뒤로가기 가능
              // false : 현재 라우트에서 유일함. 뒤로가기 불가능
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),
        ],
      ),
    );
  }
}
