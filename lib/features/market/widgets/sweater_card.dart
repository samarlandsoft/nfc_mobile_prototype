import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_text_button.dart';
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
    locator<UpdateScreenIndex>().call(MarketDetailsScreen.screenIndex);
    locator<UpdateWrapperCurtainMode>().call(
      NoParams(),
      isTopCurtainEnabled: true,
      isBottomCurtainEnabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onDetailsTappedHandler,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleConstants.kDefaultPadding),
                  child: Text(
                    sweater.edition,
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SweaterImageWrapper(
                      size: constraints.maxWidth,
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
                  label: 'APE IN',
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
