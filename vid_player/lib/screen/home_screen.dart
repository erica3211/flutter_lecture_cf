import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Colors 의 개수만큼 입력해야함. 그라데이션 범위 지정.
              stops: [0,1],
              // RadialGradient 안에 center : 그라데이션 방향, radius : 숫자가 커질수록 반지름이 넓어진다.
              //   center: Alignment.bottomLeft,
              //   // RadialGradient 숫자가 커질수록 반지름이 넓어진다.
              //   radius: 3,

                colors: [Color(0xFF2A3A7C), Color(0xFF2000118),])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Logo(),
            SizedBox(height: 28.0),
            _Title(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/image/logo.png');
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 32.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle.copyWith(fontWeight: FontWeight.w300),
        ),
        Text(
          'PLAYER',
          // copyWith : 덮어 쓰기. 기존에 있던 바탕으로 추가 가능.
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
