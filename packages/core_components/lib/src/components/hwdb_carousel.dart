import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// TODO(xiru): optimize carousel

class HWDBCarousel extends StatelessWidget {
  const HWDBCarousel({
    required this.itemCount,
    required this.itemBuilder,
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.enableInfiniteScroll = true,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.scrollPhysics,
    this.scrollDirection = Axis.horizontal,
    this.enlargeStrategy = CenterPageEnlargeStrategy.scale,
    this.enlargeFactor = 0.3,
    this.disableCenter = false,
    super.key,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index, int realIndex) itemBuilder;
  final double? height;
  final double aspectRatio;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 0.8, which means each page fills 80% of the carousel.
  final double viewportFraction;
  final bool enableInfiniteScroll;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides.
  /// Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 4 seconds.
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  /// Determines the animation curve physics.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve autoPlayCurve;

  /// Determines if current page should be larger than the side images,
  /// creating a feeling of depth in the carousel.
  ///
  /// Defaults to false.
  final bool? enlargeCenterPage;
  final Axis scrollDirection;
  final void Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  /// How the carousel should respond to user input.
  ///
  /// For example, determines how the items continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? scrollPhysics;

  /// Use [enlargeStrategy] to determine which method to enlarge the center page.
  final CenterPageEnlargeStrategy enlargeStrategy;

  /// How much the pages next to the center page will be scaled down.
  /// If `enlargeCenterPage` is false, this property has no effect.
  final double enlargeFactor;

  /// Whether or not to disable the `Center` widget for each slide.
  final bool disableCenter;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      options: CarouselOptions(
        height: height,
        aspectRatio: aspectRatio,
        viewportFraction: viewportFraction,
        enableInfiniteScroll: enableInfiniteScroll,
        autoPlay: autoPlay,
        autoPlayInterval: autoPlayInterval,
        autoPlayAnimationDuration: autoPlayAnimationDuration,
        autoPlayCurve: autoPlayCurve,
        enlargeCenterPage: enlargeCenterPage,
        onPageChanged: onPageChanged,
        scrollPhysics: scrollPhysics,
        scrollDirection: scrollDirection,
        enlargeStrategy: enlargeStrategy,
        enlargeFactor: enlargeFactor,
        disableCenter: disableCenter,
      ),
    );
  }
}
