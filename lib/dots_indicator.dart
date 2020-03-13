library dots_indictor;

import 'dart:math';
import 'package:flutter/material.dart';

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  final Color color;

  /// The base size of the dots
  final double dotSize;

  /// The increase in the size of the selected dot
  final double selectionZoom;

  /// The distance between the center of each dot
  final double dotSpace;

  /// The shape of the dots
  final MaterialType dotShape;

  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected: (int index) {},
    this.color: Colors.white,
    this.dotSize: 4.0,
    this.selectionZoom: 2.0,
    this.dotSpace: 12.0,
    this.dotShape: MaterialType.circle,
  }) : super(listenable: controller);

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (selectionZoom - 1.0) * selectedness;
    return Container(
      width: dotSpace,
      child: Center(
        child: Material(
          color: color,
          type: dotShape,
          child: Container(
            width: dotSize * zoom,
            height: dotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
