import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/widgets/card_tags.dart';

class ProductDescription extends StatelessWidget {
  final NFCSweater product;
  final double? width;
  final bool fromToken;

  const ProductDescription({
    Key? key,
    required this.product,
    this.width,
    this.fromToken = false,
  }) : super(key: key);

  Widget _buildSmallItemDescription() {
    return Text(
      product.title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDetailedItemDescription(BuildContext context) {
    final mq = MediaQuery.of(context);
    final textSize = TextPainter(
      text: const TextSpan(
        text: 'none',
        style: TextStyle(
          fontSize: 22.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isCustomTheme != current.isCustomTheme;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: StyleConstants.kDefaultPadding * 2.0,
            horizontal: StyleConstants.kDefaultPadding * 1.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: mq.size.width,
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 34.0,
                    color: state.isCustomTheme
                        ? product.currency == CryptoCurrency.btc
                            ? StyleConstants.kBTCColor
                            : StyleConstants.kETHColor
                        : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: StyleConstants.kDefaultPadding * 2.0,
              ),
              if (product.sold != null)
                SizedBox(
                  width: mq.size.width,
                  child: Text(
                    fromToken
                        ? 'Edition ${product.sold!} of 20'
                        : 'Edition ${(product.sold! + 1)} of 20',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: state.isCustomTheme
                          ? product.currency == CryptoCurrency.btc
                              ? StyleConstants.kBTCColor
                              : StyleConstants.kETHColor
                          : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (product.sold == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Edition ',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: state.isCustomTheme
                            ? product.currency == CryptoCurrency.btc
                                ? StyleConstants.kBTCColor
                                : StyleConstants.kETHColor
                            : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AnimatedLoader(
                      height: textSize.height,
                      width: textSize.height,
                    ),
                    Text(
                      ' of 20',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: state.isCustomTheme
                            ? product.currency == CryptoCurrency.btc
                                ? StyleConstants.kBTCColor
                                : StyleConstants.kETHColor
                            : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              const SizedBox(
                height: StyleConstants.kDefaultPadding,
              ),
              CardTags(tags: product.tags),
              const SizedBox(
                height: StyleConstants.kDefaultPadding,
              ),
              Row(
                children: <Widget>[
                  Text(
                    product.price != null
                        ? 'Current price: ${product.price.toString()}'
                        : 'Current price: ',
                    style: const TextStyle(
                      color: StyleConstants.kSelectedTextColor,
                    ),
                  ),
                  if (product.price == null)
                    AnimatedLoader(
                      height: textSize.height,
                      width: textSize.height,
                    ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    product.priceStep != null
                        ? 'Price step: ${product.priceStep.toString()}'
                        : 'Price step: ',
                  ),
                  if (product.priceStep == null)
                    AnimatedLoader(
                      height: textSize.height,
                      width: textSize.height,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 22.0,
        fontFamily: 'Montserrat',
      ),
      child: width != null
          ? _buildSmallItemDescription()
          : _buildDetailedItemDescription(context),
    );
  }
}
