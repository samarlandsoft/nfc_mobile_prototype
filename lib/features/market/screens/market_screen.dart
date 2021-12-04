import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_card.dart';

class MarketScreen extends StatelessWidget {
  static const screenIndex = 3;

  const MarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketBloc, MarketBlocState>(
      builder: (context, state) {
        return ContentWrapper(
          widget: ScrollableWrapper(
            widgets: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: StyleConstants.kDefaultPadding),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.sweaters.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: StyleConstants.kDefaultPadding * 3.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    return SweaterCard(sweater: state.sweaters[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
