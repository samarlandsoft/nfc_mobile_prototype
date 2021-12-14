import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/push_next_screen.dart';
import 'package:nfc_mobile_prototype/core/widgets/buttons/salt_text_button.dart';
import 'package:nfc_mobile_prototype/locator.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_counter.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_description.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_image_wrapper.dart';

class SweaterCard extends StatelessWidget {
  final NFCSweater sweater;

  const SweaterCard({
    Key? key,
    required this.sweater,
  }) : super(key: key);

  void _onDetailsTappedHandler() {
    locator<UpdateMarketActiveSweater>().call(sweater);
    locator<PushNextScreen>().call(MarketDetailsScreen.screenIndex);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return GestureDetector(
      onTap: _onDetailsTappedHandler,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double imageSize = isLargeScreen
                ? constraints.maxWidth
                : constraints.maxWidth - StyleConstants.kDefaultPadding * 3.0;

            return Column(
              children: <Widget>[
                const SizedBox(
                  height: StyleConstants.kDefaultPadding,
                ),
                Text(
                  sweater.edition,
                  style: TextStyle(
                    fontSize: StyleConstants.kGetLargeTextSize(context),
                  ),
                ),
                SizedBox(
                  height: isLargeScreen
                      ? StyleConstants.kDefaultPadding
                      : StyleConstants.kDefaultPadding * 0.5,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SweaterImageWrapper(
                      size: imageSize,
                      imageSrc: sweater.imageSrc,
                    ),
                    Positioned(
                      top: 0.0,
                      child: SweaterCounter(
                        sold: sweater.sold!,
                        amount: sweater.amount!,
                      ),
                    ),
                  ],
                ),
                SweaterDescription(
                  description: sweater.description,
                  price: sweater.price,
                  size: constraints.maxWidth,
                ),
                const SizedBox(
                  height: StyleConstants.kDefaultPadding,
                ),
                SaltTextButton(
                  label: sweater.sold! < sweater.amount! ? 'APE IN' : 'SHOW',
                  callback: _onDetailsTappedHandler,
                  width: constraints.maxWidth,
                  buttonColor: StyleConstants.kMarketColor,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
