import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color colorBeforePress;
  final Color colorAfterPress;
  final String tooltip;
  final String heroTag;
  final double elevation;
  final ShapeBorder shape;
  final Widget iconBeforePress;
  final Widget iconAfterPress;
  final Duration animationDuration;

  AnimatedFloatingButton({
    this.onPressed,
    this.colorBeforePress,
    this.colorAfterPress,
    this.tooltip,
    this.heroTag,
    this.elevation = 6.0,
    this.shape = const CircleBorder(),
    this.iconBeforePress,
    this.iconAfterPress,
    this.animationDuration = const Duration(milliseconds: 150),
  });

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Widget iconAfterPress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    iconAfterPress = Transform.rotate(
      angle: pi,
      child: widget.iconAfterPress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildFab();
  }

  Widget _buildFab() {
    return FloatingActionButton(
      shape: widget.shape,
      elevation: widget.elevation,
      heroTag: widget.heroTag,
      onPressed: () {
        widget.onPressed();
        toggle();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return _buildRotation(_buildAnimatedSwitcher());
        },
      ),
    );
  }

  void toggle() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget _buildRotation(Widget child) {
    return Transform.rotate(
      angle: _controller.value * pi,
      child: child,
    );
  }

  Widget _buildAnimatedSwitcher() {
    return AnimatedSwitcher(
      duration: widget.animationDuration,
      child: _controller.value < 0.2 ? widget.iconBeforePress : iconAfterPress,
    );
  }
}
