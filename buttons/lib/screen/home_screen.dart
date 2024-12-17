import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 테두리가 있고 그림자가 있음
            ElevatedButton(
                onPressed: () {},
                // onPressed: null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    disabledBackgroundColor: Colors.green,
                    disabledForegroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 10.0,
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                    padding: EdgeInsets.all(32.0),
                    side: BorderSide(color: Colors.black, width: 12.0),
                    // minimumSize: Size(100, 150),
                    // maximumSize:  Size(100, 150),
                    // fixedSize: Size(100, 150),
                    shadowColor: Colors.green),
                child: Text('ElevatedButton')),
            // 테두리만 있음
            OutlinedButton(
                onPressed: () {},
                // Material State (상태 종류)
                //
                // hovered -  호버링 상태 (마우스 커서를 올려놓은 상태)
                // focused - 포커스 됐을 때 (텍스트 필드)
                // pressed - 눌렀을 때
                // dragged - 드래그 됐을 떄
                // selected - 선택 됐을 때 (체크박스, 라디오 버튼)
                // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                // disabled - 비활성화 됐을 떄
                // error - 에러 상태일 때

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(200, 150)),
                ),
                child: Text('OutlinedButton')),
            // 버튼의 글자만 있음
            TextButton(
                onPressed: () {},
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.red;
                  }
                  return Colors.black;
                }), minimumSize: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Size(200, 150);
                  }
                  return Size(300, 200);
                })),
                child: Text('TextButton')),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  // shape: StadiumBorder(), // 기본 값
                  // shape: RoundedRectangleBorder(
                  // shape: ContinuousRectangleBorder(
                  //   // 둥근 정도를 지정할 수 있음
                  //   borderRadius: BorderRadius.circular(16.0),
                  // ),
                  shape: CircleBorder(eccentricity: 1 // 0 ~ 1 까지 넣을 수 있음.
                      )),
              child: Text('shape'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.keyboard_alt_outlined),
              label: Text('keyboard'),
            ),
          ],
        ),
      ),
    );
  }
}
