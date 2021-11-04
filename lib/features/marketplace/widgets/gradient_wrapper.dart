import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';

class GradientWrapper extends StatelessWidget {
  final double height, width;
  final double cardPadding, wrapperPadding;
  final String? imageSrc, chipSrc;
  final CryptoCurrency currency;

  const GradientWrapper({
    Key? key,
    required this.height,
    required this.width,
    this.cardPadding = StyleConstants.kDefaultPadding,
    this.wrapperPadding = StyleConstants.kDefaultPadding * 0.5,
    this.imageSrc,
    this.chipSrc,
    required this.currency,
  }) : super(key: key);

  static const Map<CryptoCurrency, List<Color>> _gradients = {
    CryptoCurrency.btc: [
      Color(0xFF083d77),
      Color(0xFFF7931A),
    ],
    CryptoCurrency.eth: [
      Color(0xFF4CC9F0),
      Color(0xFFF72585),
    ],
    CryptoCurrency.none: [
      Color(0xFFEB2227),
      Color(0xFFAC51F2),
    ],
  };

  Widget _buildImageContainer() {
    if (imageSrc != null && chipSrc != null) {
      return _ImageSlider(
        imagesSrc: [imageSrc!, chipSrc!],
      );
    }

    if (imageSrc != null) {
      return Image.asset(
        imageSrc!,
        fit: BoxFit.cover,
      );
    }

    if (chipSrc != null) {
      return chipSrc!.contains('assets')
          ? Image.asset(
              chipSrc!,
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              imageUrl: chipSrc!,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return AnimatedLoader(
                  height: height - (wrapperPadding * 2),
                  width: width - (wrapperPadding * 2),
                );
              },
              errorWidget: (context, url, error) {
                return Center(
                  child: Text('Error: ${error.runtimeType}'),
                );
              },
            );
    }

    return const Center(
      child: Text('Null'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageSrc ?? 'none',
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _gradients[currency]!,
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
            child: _buildImageContainer(),
          ),
        ),
      ),
    );
  }
}

class _ImageSlider extends StatefulWidget {
  final List<String> imagesSrc;

  const _ImageSlider({
    Key? key,
    required this.imagesSrc,
  }) : super(key: key);

  @override
  State<_ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<_ImageSlider> {
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
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
