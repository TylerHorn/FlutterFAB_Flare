import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  final FlareControls animationControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;

  // Width and height retrieved from the animation artboard values
  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo) {
          setState(() {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(tapInfo.globalPosition);

            var topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;
            var leftSideTouched = localTouchPosition.dx < AnimationWidth / 3;
            var rightSideTouched =
                localTouchPosition.dx > (AnimationWidth / 3) * 2;
            var middleTouched = !leftSideTouched && !rightSideTouched;

            if (leftSideTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.CameraTapped);
              print('Camera Tapped');
            } else if (middleTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.PulseTapped);
              print('Pulse Tapped');
            } else if (rightSideTouched && topHalfTouched) {
              _setAnimationToPlay(AnimationToPlay.ImageTapped);
              print('Image Tapped');
            } else {
              if (isOpen) {
                _setAnimationToPlay(AnimationToPlay.Deactivate);
                print('Deactivated');
              } else {
                _setAnimationToPlay(AnimationToPlay.Activate);
                print('Activated');
              }

              isOpen = !isOpen;
            }
          });
        },
        child: FlareActor(
          'assets/button-animation.flr',
          controller: animationControls,
          animation: _getAnimationName(_animationToPlay),
        ),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return 'activate';
      case AnimationToPlay.Deactivate:
        return 'deactivate';
      case AnimationToPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationToPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationToPlay.ImageTapped:
        return 'image_tapped';
      default:
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    var isTappedAnimation = _getAnimationName(animation).contains("_tapped");
    if (isTappedAnimation &&
        _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }

    animationControls.play(_getAnimationName(animation));

    // Set the last played animation to check state
    _lastPlayedAnimation = animation;
  }
}
