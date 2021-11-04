import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_app_theme.dart';
import 'package:nfc_mobile_prototype/core/widgets/blur_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class AboutScreen extends StatelessWidget {
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
        backgroundSrc: 'assets/images/background_3.png',
        widget: BlurWrapper(
          widget: ScrollableWrapper(
            widgets: <Widget>[
              Padding(
                padding: const EdgeInsets.all(StyleConstants.kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Salt DAO:',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text('https://snapshot.org/#/saltdao.eth'),
                    const SizedBox(
                      height: StyleConstants.kDefaultPadding,
                    ),
                    const Text(
                      'Discord:',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text('https://discord.com/invite/Zj7PnT5EEw'),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text('Enable custom theme'),
                          BlocBuilder<AppBloc, AppBlocState>(
                              buildWhen: (prev, current) {
                            return prev.isCustomTheme != current.isCustomTheme;
                          }, builder: (context, state) {
                            return FlutterSwitch(
                              activeColor: Colors.orange,
                              inactiveColor: Colors.orange.withOpacity(0.3),
                              value: state.isCustomTheme,
                              onToggle: _onToggleThemeHandler,
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
