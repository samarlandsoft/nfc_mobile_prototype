import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/widgets/blur_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 18.0,
          fontFamily: 'Montserrat',
        ),
        child: ContentWrapper(
          backgroundSrc: 'assets/images/background_3.png',
          widget: BlurWrapper(
            widget: ScrollableWrapper(
              widgets: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Salt DAO:',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text('https://snapshot.org/#/saltdao.eth'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Discord:',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text('https://discord.com/invite/Zj7PnT5EEw'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
