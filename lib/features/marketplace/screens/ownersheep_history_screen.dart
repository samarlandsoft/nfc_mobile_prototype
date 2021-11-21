import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/dialogs_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_state.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/blockchain_memberships.dart';

class OwnerHistoryScreen extends StatelessWidget {
  final int token;

  const OwnerHistoryScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  static const _initialAddress = '0x0000000000000000000000000000000000000000';
  static const _senderAddress = '0xd362db73b59a824558ffebdfc83073f9e364dbc6';

  Widget _buildOwnershipHistory(List<BlockchainOwnerships> history) {
    history.sort((a, b) => a.blockNum.compareTo(b.blockNum));

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: StyleConstants.kDefaultPadding),
      child: ScrollableWrapper(
        crossAxisAlignment: CrossAxisAlignment.start,
        widgets: history.map((element) {
          if (element.payer.toString() == _initialAddress) {
            return const Text('Token created');
          }
          if (element.payer.toString() == _senderAddress) {
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
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<MarketBloc, MarketBlocState>(
      buildWhen: (prev, current) {
        return prev.memberships != current.memberships;
      },
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
                    child: _buildOwnershipHistory(state.memberships
                        .where((element) => element.tokenID.toInt() == token)
                        .toList()),
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
