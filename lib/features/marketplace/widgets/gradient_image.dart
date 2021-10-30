import 'package:flutter/material.dart';

class GradientImage extends StatelessWidget {
  final double height, width;
  final List<Color> gradient;
  final double cardPadding, wrapperPadding;
  final String imageSrc;

  const GradientImage({
    Key? key,
    required this.height,
    required this.width,
    required this.gradient,
    this.cardPadding = 10.0,
    this.wrapperPadding = 5.0,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.25, 1.0],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.all(Radius.circular(cardPadding)),
      ),
      child: Padding(
        padding: EdgeInsets.all(wrapperPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(wrapperPadding),
          child: Hero(
            tag: imageSrc,
            child: Image.asset(
              imageSrc,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}