import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/services/web_view_service.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/market/domain/models/nfc_sweater_ownership.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_counter.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_description.dart';
import 'package:nfc_mobile_prototype/features/market/widgets/sweater_image_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class SweaterCardExtended extends StatefulWidget {
  final NFCSweater sweater;

  const SweaterCardExtended({
    Key? key,
    required this.sweater,
  }) : super(key: key);

  @override
  State<SweaterCardExtended> createState() => _SweaterCardExtendedState();
}

class _SweaterCardExtendedState extends State<SweaterCardExtended> {
  final _controller = PageController();
  var _activePage = 0;

  List<Widget> _getSweaterPage(double size) {
    return [
      SweaterImageWrapper(
        size: size,
        imageSrc: widget.sweater.imageSrc,
        chipSrc: widget.sweater.chipSrc,
      ),
      _SweaterOwnershipHistory(
        ownership: widget.sweater.ownership,
        size: size,
      ),
      _SweaterQRCode(
        qrSrc: widget.sweater.qrSrc!,
        size: size,
      ),
    ];
  }

  void _onPageChanged(int index) {
    setState(() {
      _activePage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.sweater.edition,
                style: const TextStyle(
                  fontSize: 28.0,
                ),
              ),
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding * 0.5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  SweaterCounter(
                    sold: widget.sweater.sold!,
                    amount: widget.sweater.amount!,
                  ),
                  const SizedBox(
                    width: StyleConstants.kDefaultPadding * 1.5,
                  ),
                  Text(
                    widget.sweater.title,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding,
            ),
            SizedBox(
              height: constraints.maxWidth,
              child: PageView(
                controller: _controller,
                onPageChanged: _onPageChanged,
                children: _getSweaterPage(constraints.maxWidth),
              ),
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding,
            ),
            SweaterDescription(
              description: widget.sweater.description,
              price: widget.sweater.price,
              size: constraints.maxWidth,
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding * 2.0,
            ),
            _SweaterPagePanel(
              controller: _controller,
              activePage: _activePage,
            ),
          ],
        );
      },
    );
  }
}

class _SweaterPagePanel extends StatefulWidget {
  final PageController controller;
  final int activePage;

  const _SweaterPagePanel({
    Key? key,
    required this.controller,
    this.activePage = 0,
  }) : super(key: key);

  @override
  State<_SweaterPagePanel> createState() => _SweaterPagePanelState();
}

class _SweaterPagePanelState extends State<_SweaterPagePanel> {
  List<_SweaterPanelButton> _buttons() {
    return [
      _SweaterPanelButton(
        index: 0,
        label: 'WEAR',
        iconSrc: 'assets/icons/wear.png',
        callback: _onSwapPageHandler,
        isActive: widget.activePage == 0,
      ),
      _SweaterPanelButton(
        index: 1,
        label: 'HISTORY',
        iconSrc: 'assets/icons/history.png',
        callback: _onSwapPageHandler,
        isActive: widget.activePage == 1,
      ),
      _SweaterPanelButton(
        index: 2,
        label: 'QR CODE',
        iconSrc: 'assets/icons/qr.png',
        callback: _onSwapPageHandler,
        isActive: widget.activePage == 2,
      ),
      _SweaterPanelButton(
        index: 3,
        label: 'GO TO NFT',
        iconSrc: 'assets/icons/redirect.png',
        callback: _onSwapPageHandler,
        isActive: false,
      ),
    ];
  }

  void _onSwapPageHandler(int index) {
    if (index == 3) {
      locator<WebViewService>().openInWebView('https://www.saltandsatoshi.com');
    } else {
      widget.controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: _buttons().map((button) {
            return SizedBox(
              height: 60.0,
              width: constraints.maxWidth / _buttons().length,
              child: button,
            );
          }).toList(),
        );
      },
    );
  }
}

class _SweaterPanelButton extends StatelessWidget {
  final int index;
  final String label;
  final String iconSrc;
  final Function(int) callback;
  final bool isActive;

  const _SweaterPanelButton({
    Key? key,
    required this.index,
    required this.label,
    required this.iconSrc,
    required this.callback,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(index),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              isActive ? StyleConstants.kSelectedColor : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              iconSrc,
              height: 30.0,
              width: 30.0,
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding * 0.2,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SweaterOwnershipHistory extends StatelessWidget {
  final List<NFCSweaterOwnership> ownership;
  final double size;

  const _SweaterOwnershipHistory({
    Key? key,
    required this.ownership,
    required this.size,
  }) : super(key: key);

  static const _initialAddress = '0x0000000000000000000000000000000000000000';
  static const _senderAddress = '0xd362db73b59a824558ffebdfc83073f9e364dbc6';

  Widget _buildHistoryText(NFCSweaterOwnership history) {
    if (history.payer.toString() == _initialAddress) {
      return const Text('TOKEN CREATED');
    }

    if (history.payer.toString() == _senderAddress) {
      return const Text('NEW OWNER SATOSHI');
    }

    return const Text('NEW OWNER NONE');
  }

  @override
  Widget build(BuildContext context) {
    if (ownership.isNotEmpty) {
      ownership.sort((a, b) => a.blockNum.compareTo(b.blockNum));
    }

    return SizedBox(
      height: size,
      child: ListView.separated(
        itemCount: ownership.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            bottom: StyleConstants.kDefaultPadding * 2.0),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 8.0,
            thickness: 1.0,
            color: StyleConstants.kInactiveColor,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _buildHistoryText(ownership[index]),
                Text(
                  ownership[index].blockNum.toString(),
                  style: const TextStyle(
                    color: StyleConstants.kInactiveColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SweaterQRCode extends StatelessWidget {
  final String qrSrc;
  final double size;

  const _SweaterQRCode({
    Key? key,
    required this.qrSrc,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(size * 0.2),
      child: Image.asset(qrSrc),
    );
  }
}
