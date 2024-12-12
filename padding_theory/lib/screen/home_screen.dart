import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          child: Padding(
            padding:
                // const EdgeInsets. all(32.0),
                // const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
                // const EdgeInsets.only(
                //     top: 32.0, left: 64.0, right: 16.0, bottom: 128.0),
            const EdgeInsets.fromLTRB(32.0, 64.0, 16.0, 8.0),
            child: Container(
              color: Colors.blue,
              width: 50.0,
              height: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}
