import 'package:flutter/material.dart';

class NumberToImage extends StatelessWidget {
  final int number;
  const NumberToImage({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: number
            .toString()
            .split('')
            .map(
              (n) => Image.asset(
                'asset/img/$n.png',
                width: 50.0,
                height: 70,
              ),
            )
            .toList());
  }
}
