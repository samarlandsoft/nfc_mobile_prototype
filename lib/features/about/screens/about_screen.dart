import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_app_theme.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class AboutScreen extends StatelessWidget {
  static const String titleName = 'About';
  static const int screenIndex = 3;

  const AboutScreen({Key? key}) : super(key: key);

  void _onToggleThemeHandler(bool value) {
    locator<UpdateAppTheme>().call(value);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 18.0,
        fontFamily: 'Montserrat',
      ),
      child: ContentWrapper(
        title: AboutScreen.titleName,
        backgroundSrc: 'assets/images/background_4.png',
        withNavigation: true,
        widget: ScrollableWrapper(
          widgets: <Widget>[
            Padding(
              padding: const EdgeInsets.all(StyleConstants.kDefaultPadding),
              child: BlocBuilder<AppBloc, AppBlocState>(
                buildWhen: (prev, current) {
                  return prev.isCustomTheme != current.isCustomTheme;
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Join SaltDAO',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding,
                      ),
                      const Text(
                          'We\'re a growing community dedicated to providing the most fulfilling NFT community experience available. Joining SaltDAO is free but holding \$SALTY will allow you to progress the ranks, vote on governance proposals and obtain access to exclusive rewards and more!'),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding,
                      ),
                      const Text(
                        'https://snapshot.org/#/saltdao.eth',
                        style: TextStyle(
                          color: StyleConstants.kHyperlinkTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 3.0,
                      ),
                      const Text(
                        'Discord',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding,
                      ),
                      const Text(
                        'https://discord.com/invite/Zj7PnT5EEw',
                        style: TextStyle(
                          color: StyleConstants.kHyperlinkTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 3.0,
                      ),
                      const Text(
                        'Secret settings',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding,
                      ),
                      SizedBox(
                        height: 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Enable custom theme'),
                            FlutterSwitch(
                              activeColor: Colors.orange,
                              inactiveColor: Colors.orange.withOpacity(0.3),
                              value: state.isCustomTheme,
                              onToggle: _onToggleThemeHandler,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 3.0,
                      ),
                      Text(
                        'Salt & Satoshi is powered by Ethereum and governed by SaltDAO',
                        style: TextStyle(
                          color: state.isCustomTheme
                              ? Colors.white70
                              : Colors.white38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
