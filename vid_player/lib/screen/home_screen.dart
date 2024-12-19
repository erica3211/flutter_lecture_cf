import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool showVideoPlayer = false;
  XFile? video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null
          ? _VideoPlayer(
              video: video!,
            )
          : _VideoSelector(onLogoTap: onLogoTap),
    );
  }

  onLogoTap() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    print(video);
    setState(() {
      this.video = video;
    });
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;
  const _VideoSelector({required this.onLogoTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Colors 의 개수만큼 입력해야함. 그라데이션 범위 지정.
              stops: [
            0,
            1
          ],
              // RadialGradient 안에 center : 그라데이션 방향, radius : 숫자가 커질수록 반지름이 넓어진다.
              //   center: Alignment.bottomLeft,
              //   // RadialGradient 숫자가 커질수록 반지름이 넓어진다.
              //   radius: 3,

              colors: [
            Color(0xFF2A3A7C),
            Color(0xFF2000118),
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          SizedBox(height: 28.0),
          _Title(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, child: Image.asset('asset/image/logo.png'));
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

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  const _VideoPlayer({required this.video, super.key});

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    initializeControllor();
  }

  initializeControllor() async {
    videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );
    await videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController),
            _PlayButton(
              onReversePressed: onReversePressed,
              onPlayPressed: onPlayPressed,
              onForwardPressed: onForwardPressed,
              isPlaying: videoPlayerController.value.isPlaying,
            ),
            _Bottom(
                position: videoPlayerController.value.position,
                maxPosition: videoPlayerController.value.duration),
            _PickAnotherVideo(onPressed: () {}),
          ],
        ),
      ),
    );
  }

  onReversePressed() {
    () {
      final currentPosition = videoPlayerController.value.position;

      Duration position = Duration();
      if (currentPosition.inSeconds > 3) {
        position = currentPosition - Duration(seconds: 3);
      }
      videoPlayerController.seekTo(position);
    };
  }

  onPlayPressed() {
    () {
      setState(() {
        if (videoPlayerController.value.isPlaying) {
          videoPlayerController.pause();
        } else {
          videoPlayerController.play();
        }
      });
    };
  }

  onForwardPressed() {
    () {
      final maxPosition = videoPlayerController.value.duration;
      final currentPosition = videoPlayerController.value.position;

      Duration position = maxPosition;
      if ((maxPosition - Duration(seconds: 3)).inSeconds >
          currentPosition.inSeconds) {
        position = currentPosition + Duration(seconds: 3);
      }
      videoPlayerController.seekTo(position);
    };
  }
}

class _PlayButton extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;
  const _PlayButton(
      {required this.onReversePressed,
      required this.onPlayPressed,
      required this.onForwardPressed,
      required this.isPlaying,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: Colors.white,
            onPressed: onReversePressed,
            icon: Icon(Icons.rotate_left),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onPlayPressed,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onForwardPressed,
            icon: Icon(Icons.rotate_right),
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final Duration position;
  final Duration maxPosition;
  const _Bottom({
    required this.position,
    required this.maxPosition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: position.inSeconds.toDouble(),
                max: maxPosition.inSeconds.toDouble(),
                onChanged: (double val) {},
              ),
            ),
            Text(
              '${position.inMinutes.toString().padLeft(2, '0')}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickAnotherVideo extends StatelessWidget {
  final VoidCallback onPressed;
  const _PickAnotherVideo({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.photo_camera_back),
      ),
    );
  }
}