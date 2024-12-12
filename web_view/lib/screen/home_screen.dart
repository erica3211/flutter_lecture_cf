import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://blog.codefactory.ai');

class HomeScreen extends StatelessWidget {
  // 점 2개를 넣으면 함수를 실행하는데 결과를 반환하는게 아니고 대상을 반환한다.
  // WebViewController controller2 = WebViewController(); controller2.loadRequest()와 결과가 같음
  // JavaScriptMode.unrestricted : 유튜브 등 기능 동작.
  WebViewController controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(homeUrl);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(homeUrl);
            },
            icon: Icon(Icons.home),
          )
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
