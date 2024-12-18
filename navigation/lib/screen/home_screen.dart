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
                      // 이후 페이지에 number: 20이라는 값 전달.
                      number: 20,
                    );
                  },
                ),
              );
              print(result);
            },
            child: Text('Push'),
          ),

          // 홈스크린에서는 더이상 이전 페이지가 없기 때문에 검은 화면만 뜸.
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: Text('Pop'),
          ),

          // 더이상 이전 페이지가 없어서 클릭해도 페이지 이동을 하지 않음.
          OutlinedButton(
            onPressed: () {
              // pop을 좀 더 안전하게 할 수 있는 방법
              Navigator.of(context).maybePop(456);
            },
            child: Text('Maybe Pop'),
          ),

          // 뒤로 갈 수 있는 페이지가 있는지 확인하는 방법.
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
