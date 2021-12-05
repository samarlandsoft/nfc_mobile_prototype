import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/services/web_view_service.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class SaltLinkIcon extends StatelessWidget {
  final String label;
  final String iconSrc;
  final String url;
  final double width;

  const SaltLinkIcon({
    Key? key,
    required this.label,
    required this.iconSrc,
    required this.url,
    required this.width,
  }) : super(key: key);

  void _onOpenLinkHandler() {
    locator<WebViewService>().openInWebView(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onOpenLinkHandler,
      child: Column(
        children: <Widget>[
          Container(
            height: width * 1.4,
            width: width,
            color: Colors.white,
            child: Center(
              child: Image.asset(
                iconSrc,
                width: width * 0.75,
              ),
            ),
          ),
          const SizedBox(
            height: StyleConstants.kDefaultPadding,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
