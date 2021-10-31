import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GradientWrapper extends StatelessWidget {
  final double height, width;
  final List<Color> gradient;
  final double cardPadding, wrapperPadding;
  final String imageSrc;
  final String? chipSrc;

  const GradientWrapper({
    Key? key,
    required this.height,
    required this.width,
    required this.gradient,
    this.cardPadding = 10.0,
    this.wrapperPadding = 5.0,
    required this.imageSrc,
    this.chipSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageSrc,
      child: Container(
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
            child: chipSrc != null
                ? ImageSlider(
                    imagesSrc: [imageSrc, chipSrc!],
                  )
                : Image.asset(
                    imageSrc,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> imagesSrc;

  const ImageSlider({
    Key? key,
    required this.imagesSrc,
  }) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final CarouselController _controller = CarouselController();
  int _currentImage = 0;

  void _onChangeImageHandler(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentImage = index;
    });
  }

  void _onSwapIndicatorHandler(int index) {
    _controller.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        LayoutBuilder(builder: (context, constraints) {
          return CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                height: constraints.maxHeight,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                onPageChanged: _onChangeImageHandler),
            items: widget.imagesSrc.map((image) {
              return Image.asset(
                image,
                fit: BoxFit.cover,
              );
            }).toList(),
          );
        }),
        Positioned(
          bottom: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imagesSrc.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _onSwapIndicatorHandler(entry.key),
                child: Container(
                  height: 12.0,
                  width: 12.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_currentImage == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
