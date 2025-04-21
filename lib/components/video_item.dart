import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String url;
  const VideoItem({super.key, required this.url});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;

  BoxFit _checkVideoRatio(double width, double height) =>
      width > height ? BoxFit.cover : BoxFit.contain;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child:
          _controller.value.isInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    fit : _checkVideoRatio(
                      _controller.value.size.width,
                      _controller.value.size.height,
                    ),
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  if (!_controller.value.isPlaying)
                    Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: MediaQuery.sizeOf(context).width * 0.4,
                        color: Colors.white30,
                      ),
                    ),
                ],
              )
              : Container(color: Colors.black),
    );
  }
}
