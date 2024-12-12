import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    //Timer.periodic: 단일 실행 말고 반복적으로 실행할 경우 사용
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;
      if (nextPage > 4) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage,
          duration: Duration(microseconds: 500), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    if(timer != null){
      timer!.cancel();
    }
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map((e) =>
            Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover))
            .toList(),
      ),
    );
  }
}
