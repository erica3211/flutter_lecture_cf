import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

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
          // 웬만하면 한눈에 보이기 편하게 하기 위해 밑에 onHeartPressedButton룰 만듦.
          child: Column(
            children: [
              // 글자
              _Top(
                selectedDate: selectedDate,
                // VoidCallback : 반환값이 없는 하나의 함수.
                // onHeartPressedButton() 은 실행 후 반환이 된 결과인 void가 들어감.
                // onHeartPressedButton 자체를 넣어서 실행은 IconButton안 onPressed에서 할 수 있도록 해야 함.
                onPressed: onHeartPressedButton,
              ),
              // 이미지
              _Botton()
            ],
          ),
        ),
      ),
    );
  }

  onHeartPressedButton() {
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
              initialDateTime: selectedDate,
              maximumDate: DateTime.now(),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        );
      },
    );
  }
}

class _Top extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onPressed;
  const _Top({required this.selectedDate, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
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
              '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
              style: textTheme.bodyMedium,
            ),
            IconButton(
              iconSize: 60,
              color: Colors.red,
              onPressed: onPressed,
              icon: Icon(
                Icons.favorite,
              ),
            ),
            Text(
              'D+${now.difference(selectedDate).inDays + 1}',
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
