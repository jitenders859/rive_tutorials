import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PlayPause extends StatefulWidget {
  const PlayPause({super.key});

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  late RiveAnimationController _controller;

  isPlaying() => _controller.isActive;

  void togglePlay() => setState(() {
        _controller.isActive = !_controller.isActive;
      });

  void reset() {
    setState(() {
      _controller.isActive = true;
      (_controller as SimpleAnimation).reset();

      _controller.apply(
          (_controller as SimpleAnimation).instance!.animation.context, 0);
      _controller.isActive = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation("animate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: RiveAnimation.asset(
            "assets/rive/table_animation.riv",
            fit: BoxFit.cover,
            controllers: [_controller],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: togglePlay,
                icon: Icon(
                  isPlaying() ? Icons.pause : Icons.play_arrow,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: reset,
                icon: Icon(
                  Icons.restore,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
