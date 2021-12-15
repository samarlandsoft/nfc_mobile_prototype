import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/services/web_view_service.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class SaltLinkIcon extends StatelessWidget {
  final String label;
  final String iconSrc;
  final String url;
  final double height, width;

  const SaltLinkIcon({
    Key? key,
    required this.label,
    required this.iconSrc,
    required this.url,
    required this.height,
    required this.width,
  }) : super(key: key);

  void _onOpenLinkHandler() {
    locator<WebViewService>().openInWebView(url);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return GestureDetector(
      onTap: _onOpenLinkHandler,
      child: SizedBox(
        height: height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: width,
                color: Colors.white,
                child: Center(
                  child: Image.asset(
                    iconSrc,
                    width: width * 0.75,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: isLargeScreen
                  ? StyleConstants.kDefaultPadding
                  : StyleConstants.kDefaultPadding * 0.5,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: isLargeScreen ? 20.0 : 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
