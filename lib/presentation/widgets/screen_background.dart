import 'package:flutter/material.dart';

import '../../core/constansts/image_manager.dart';

class ScreenBackground extends StatefulWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  State<ScreenBackground> createState() => _ScreenBackgroundState();
}

class _ScreenBackgroundState extends State<ScreenBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageManager.splash,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
