// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget(
      {super.key,
      required this.items,
      this.height,
      required this.viewportFraction,
      this.onPageChanged,
      this.initialPage = 0,
      this.carouselController});
  final List<Widget>? items;
  final double? height;
  final double viewportFraction;
  final int initialPage;
  final CarouselController? carouselController;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
            height: height,
            aspectRatio: 16 / 9,
            viewportFraction: viewportFraction,
            initialPage: initialPage,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal),
        items: items);
  }
}
