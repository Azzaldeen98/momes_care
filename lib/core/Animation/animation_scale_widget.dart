import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationSlideWidget extends StatelessWidget {
  const AnimationSlideWidget(
      {super.key,
      required this.children,
      this.physics = const ClampingScrollPhysics()});
  final List<Widget> children;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        physics: physics,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInCubic,
              verticalOffset: 0,
              horizontalOffset: 0,
              child: ScaleAnimation(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: children[index]),
            ),
          );
        },
      ),
    );
  }
}
