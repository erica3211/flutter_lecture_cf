import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:video_call/const/keys.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int uid = 0;
  int? remoteUid;

  Future<void> init() async {
    final res = await [Permission.camera, Permission.microphone].request();

    final cameraPermisson = res[Permission.camera];
    final microPhonePermissoin = res[Permission.microphone];

    if (cameraPermisson != PermissionStatus.granted ||
        microPhonePermissoin != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }
    if (engine == null) {
      engine = createAgoraRtcEngine();

      await engine!.initialize(
        RtcEngineContext(
          appId: appId,
        ),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsed) {
          print('-------User Joined-------');
          setState(() {
            this.remoteUid = remoteUid;
          });
        }),
      );

      await engine!.enableAudio();
      await engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await engine!.joinChannel(
        token: token,
        channelId: channelName,
        // uid가 0이면 자동으로 생성해줌
        uid: uid,
        options: options,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder<void>(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return Stack(
              children: [
                Container(
                  child: renderMainView(),
                ),
                Container(
                  width: 120,
                  height: 160,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine!,
                      canvas: VideoCanvas(
                        uid: uid,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('나가기'),
                  ),
                ),
              ],
            );
          }),
    );
  }

  renderMainView() {
    if (remoteUid == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine!,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(
          channelId: channelName,
        ),
      ),
    );
  }
}