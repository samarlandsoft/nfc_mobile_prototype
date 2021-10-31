import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_app_theme.dart';
import 'package:nfc_mobile_prototype/core/widgets/blur_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _onToggleThemeHandler(bool value) {
    locator<UpdateAppTheme>().call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 18.0,
          fontFamily: 'Montserrat',
        ),
        child: BlocBuilder<AppBloc, AppBlocState>(
          builder: (context, state) {
            return ContentWrapper(
              backgroundSrc: 'assets/images/background_3.png',
              widget: BlurWrapper(
                widget: ScrollableWrapper(
                  widgets: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 50.0,
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
