import 'package:flutter/cupertino.dart';
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
    double topPadding,
    double screenSize,
  ) {
    var labelHeight =
        withLabel ? (logoSize + StyleConstants.kDefaultPadding * 0.5) : 0.0;
    var titleHeight = (title != null && title != '') ? titleSize : 0.0;
    return screenSize -
        topPadding -
        labelHeight -
        titleHeight -
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
          fontSize: 24.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

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
              bottom: StyleConstants.kDefaultPadding,
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
                          fontSize: 24.0,
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
                bottom: StyleConstants.kDefaultPadding * 2.0,
                right: StyleConstants.kDefaultPadding * 2.0,
                child: NeonButton(
                  icon: Icons.home,
                  callback: _onGoToMainScreenButtonHandler,
                  isRounded: true,
                  isTapped: true,
                  activeColor: state.isCustomTheme
                      ? Colors.green
                      : StyleConstants.kSelectedTextColor,
                ),
              ),
          ],
        );
      },
    );
  }
}
