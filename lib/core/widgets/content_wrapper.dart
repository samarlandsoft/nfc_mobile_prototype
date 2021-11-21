import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/core/widgets/logo_icon.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final String? title;
  final String? backgroundSrc;
  final bool withLabel;
  final bool withNavigation;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.title,
    this.backgroundSrc,
    this.withLabel = true,
    this.withNavigation = false,
  }) : super(key: key);

  void _onGoToMainScreenButtonHandler() {
    locator<UpdateScreenIndex>().call(HomeScreen.screenIndex);
  }

  double _getContentAvailableSize(
    double logoSize,
    double titleSize,
    double navigationSize,
    double topPadding,
    double screenSize,
  ) {
    var labelHeight =
        withLabel ? (logoSize + StyleConstants.kDefaultPadding * 0.5) : 0.0;
    var titleHeight = (title != null && title != '') ? titleSize : 0.0;
    var navigationHeight =
        withNavigation ? navigationSize + StyleConstants.kDefaultPadding : 0.0;

    return screenSize -
        topPadding -
        labelHeight -
        titleHeight -
        navigationHeight -
        (StyleConstants.kDefaultPadding * 2.0);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final topPadding = withLabel
        ? mq.viewPadding.top + StyleConstants.kDefaultPadding
        : StyleConstants.kDefaultPadding;

    final logoSize = StyleConstants.kGetLogoHeight(context);
    final titleTextSize = TextPainter(
      text: TextSpan(
        text: title ?? 'none',
        style: const TextStyle(
          fontSize: 30.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    final buttonWidth = mq.size.width * 0.7;
    final buttonHeight = NeonButton.getButtonHeight(context);

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isCustomTheme != current.isCustomTheme;
      },
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            if (backgroundSrc != null)
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: state.isCustomTheme ? 1.0 : 0.0,
                  child: Image.asset(
                    backgroundSrc!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Positioned(
              top: topPadding,
              bottom: withNavigation
                  ? buttonHeight + StyleConstants.kDefaultPadding * 2.0
                  : StyleConstants.kDefaultPadding,
              left: StyleConstants.kDefaultPadding,
              right: StyleConstants.kDefaultPadding,
              child: Column(
                children: <Widget>[
                  if (withLabel)
                    LogoIcon(
                      size: logoSize,
                    ),
                  if (withLabel)
                    const SizedBox(
                      height: StyleConstants.kDefaultPadding * 0.5,
                    ),
                  if (title != null && title != '')
                    SizedBox(
                      height: titleTextSize.height,
                      child: Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: StyleConstants.kDefaultPadding),
                      child: SizedBox(
                        height: _getContentAvailableSize(
                          logoSize,
                          titleTextSize.height,
                          buttonHeight,
                          topPadding,
                          mq.size.height,
                        ),
                        child: widget,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (withNavigation)
              Positioned(
                bottom: StyleConstants.kDefaultPadding,
                left: StyleConstants.kDefaultPadding,
                right: StyleConstants.kDefaultPadding,
                child: Center(
                  child: NeonButton(
                    label: 'Home',
                    callback: _onGoToMainScreenButtonHandler,
                    width: buttonWidth,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
