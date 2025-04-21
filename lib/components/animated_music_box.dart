import 'package:flutter/material.dart';
import 'package:tiktok_ui_clone/constants.dart';

class AnimatedMusicBox extends StatefulWidget {
  const AnimatedMusicBox({super.key});

  @override
  State<AnimatedMusicBox> createState() => _AnimatedMusicBoxState();
}

class _AnimatedMusicBoxState extends State<AnimatedMusicBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: const CircleAvatar(
        backgroundImage: NetworkImage(profilePicUrl),
        radius: 25.0,
      ),
    );
  }
}
