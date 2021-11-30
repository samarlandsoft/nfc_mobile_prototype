import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/dialogs_wrapper.dart';

class QRCodeDialog extends StatelessWidget {
  const QRCodeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final titleTextSize = TextPainter(
      text: const TextSpan(
        text: 'QR code',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    final double imageSize = mq.size.width * 0.7;
    final double dialogSize = imageSize + titleTextSize.height + (StyleConstants.kDefaultPadding * 7.0);

    return SizedBox(
      height: dialogSize,
      child: DialogsWrapper(
        widget: Column(
          children: <Widget>[
            const SizedBox(
              height: StyleConstants.kDefaultPadding,
            ),
            const Text(
              'QR code',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding * 2.0,
            ),
            Image.asset(
              'assets/images/qr_code_to_marketplace.png',
              height: imageSize,
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
