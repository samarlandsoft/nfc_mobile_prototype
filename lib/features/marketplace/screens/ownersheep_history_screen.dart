import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/core/widgets/dialogs_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/blockchain_memberships.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/get_blockchain_memberships.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/get_blockchain_prices.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class OwnerHistoryScreen extends StatefulWidget {
  final int token;
  final CryptoCurrency currency;

  const OwnerHistoryScreen({
    Key? key,
    required this.token,
    required this.currency,
  }) : super(key: key);

  static const _initialAddress = '0x0000000000000000000000000000000000000000';
  static const _senderAddress = '0xd362db73b59a824558ffebdfc83073f9e364dbc6';

  @override
  State<OwnerHistoryScreen> createState() => _OwnerHistoryScreenState();
}

class _OwnerHistoryScreenState extends State<OwnerHistoryScreen> {
  Timer? _errorTimer;
  bool _isErrorShowed = false;

  void _onRetryRequestHandler() {
    locator<GetBlockchainPrices>().call(widget.currency);
    locator<GetBlockchainOwnerships>().call(widget.currency);
  }

  Widget _buildOwnershipHistory(
      List<BlockchainOwnerships> history, double buttonWidth) {
    if (history.isEmpty) {
      _errorTimer ??= Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _isErrorShowed = true;
          });
        }
      });

      return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedLoader(
                height: constraints.maxWidth * 0.5,
                width: constraints.maxWidth * 0.5,
              ),
              const SizedBox(
                height: StyleConstants.kDefaultPadding,
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _isErrorShowed ? 1.0 : 0.0,
                child: AbsorbPointer(
                  absorbing: !_isErrorShowed,
                  child: NeonButton(
                    label: 'Retry',
                    callback: _onRetryRequestHandler,
                    width: buttonWidth,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    history.sort((a, b) => a.blockNum.compareTo(b.blockNum));
    _isErrorShowed = false;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: StyleConstants.kDefaultPadding),
      child: ScrollableWrapper(
        crossAxisAlignment: CrossAxisAlignment.start,
        widgets: history.map((element) {
          if (element.payer.toString() == OwnerHistoryScreen._initialAddress) {
            return const Text('Token created');
          }
          if (element.payer.toString() == OwnerHistoryScreen._senderAddress) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Token transferred to'),
                Text(
                  element.nft.toString(),
                  style: const TextStyle(
                    color: StyleConstants.kSelectedTextColor,
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Token transferred to'),
              Text(
                element.nft.toString(),
                style: const TextStyle(
                  color: StyleConstants.kSelectedTextColor,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _errorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final buttonWidth = mq.size.width * 0.5;

    /// TODO add builderWhen
    return BlocBuilder<MarketBloc, MarketBlocState>(
      builder: (context, state) {
        return DefaultTextStyle(
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Montserrat',
          ),
          child: SizedBox(
            height: mq.size.height * 0.5,
            child: DialogsWrapper(
              widget: Column(
                children: <Widget>[
                  const SizedBox(
                    height: StyleConstants.kDefaultPadding,
                  ),
                  const Text(
                    'Ownership History',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: StyleConstants.kDefaultPadding * 2.0,
                  ),
                  Expanded(
                    child: _buildOwnershipHistory(
                        state.memberships
                            .where((element) =>
                                element.tokenID.toInt() == widget.token)
                            .toList(),
                        buttonWidth),
                  ),
                  const SizedBox(
                    height: StyleConstants.kDefaultPadding,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
