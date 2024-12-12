import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 500이 기본이고 높아질수록 짙어짐. 낮아질수록 옅어짐.
      backgroundColor: Colors.pink[100],
      // SafeArea : 안전 지대 (위에 상단 바 밑에서부터 시작)
      body: SafeArea(
        // top: true, true 면 없어도 됨.
        bottom: false,
        // SizedBox : 크기를 지정해주는 클래스
        child: SizedBox(
          // MediaQuery : 화면 크기를 가지고 옴. MediaQuery.of(context).size.width는 double.infinity와 같은 역할임.
          // MediaQuery.of(context).size.width /2 이런식으로 사용 가능
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Column(
            children: [
              // 글자
              _Top(),
              // 이미지
              _Botton()
            ],
          ),
        ),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    int day = 1;
    DateTime date = DateTime.now();
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        // color: Colors.red,
        child: Column(
          children: [
            Text(
              'U&I',
              style: textTheme.displayLarge,
            ),
            Text(
              '우리 처음 만난 날',
              style: textTheme.bodyLarge,
            ),
            Text(
              '2023.05.06',
              style: textTheme.bodyMedium,
            ),
            IconButton(
              iconSize: 60,
              color: Colors.red,
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.white,
                        height: 300,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime date) {
                            print(date.);
                          },
                          dateOrder: DatePickerDateOrder.ymd,
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.favorite,
              ),
            ),
            Text(
              'D+$day',
              style: textTheme.displayMedium,
            )
          ],
        ),
      ),
    );
  }
}

class _Botton extends StatelessWidget {
  const _Botton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.blue,
        child: Image.asset('asset/img/middle_image.png'),
      ),
    );
  }
}
