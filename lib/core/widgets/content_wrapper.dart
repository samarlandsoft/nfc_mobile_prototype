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
  final bool withNetworkBar;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.title,
    this.backgroundSrc,
    this.withLabel = true,
    this.withNavigation = false,
    this.withNetworkBar = true,
  }) : super(key: key);

  static const _animationDuration = 500;

  void _onGoToMainScreenButtonHandler() {
    locator<UpdateScreenIndex>().call(HomeScreen.screenIndex);
  }

  double _getContentAvailableSize(
    double logoSize,
    double titleSize,
    double navigationSize,
    double topPadding,
    double screenSize,
    double networkBarSize,
    bool isNetworkEnabled,
  ) {
    var labelHeight =
        withLabel ? (logoSize + StyleConstants.kDefaultPadding * 0.5) : 0.0;
    var titleHeight = (title != null && title != '') ? titleSize : 0.0;
    var navigationHeight =
        withNavigation ? navigationSize + StyleConstants.kDefaultPadding : 0.0;
    var networkBarHeight = isNetworkEnabled ? 0.0 : networkBarSize;

    return screenSize -
        topPadding -
        labelHeight -
        titleHeight -
        navigationHeight -
        networkBarHeight -
        (StyleConstants.kDefaultPadding * 2.0);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final topPadding = withLabel
        ? mq.viewPadding.top + StyleConstants.kDefaultPadding
        : StyleConstants.kDefaultPadding;

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

    final networkTextSize = TextPainter(
      text: const TextSpan(
        text: 'none',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    final logoSize = StyleConstants.kGetLogoHeight(context);
    final networkBarSize =
        networkTextSize.height + StyleConstants.kDefaultPadding * 2.0;
    final buttonWidth = mq.size.width * 0.7;
    final buttonHeight = NeonButton.getButtonHeight(context);

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return (prev.isCustomTheme != current.isCustomTheme) ||
            (prev.isNetworkEnabled != current.isNetworkEnabled);
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: _animationDuration),
              top: state.isNetworkEnabled
                  ? topPadding
                  : (topPadding + networkBarSize),
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: _animationDuration),
                        height: _getContentAvailableSize(
                          logoSize,
                          titleTextSize.height,
                          buttonHeight,
                          topPadding,
                          mq.size.height,
                          networkBarSize,
                          state.isNetworkEnabled,
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
            if (withNetworkBar)
              Positioned(
                top: mq.viewPadding.top,
                left: StyleConstants.kDefaultPadding,
                right: StyleConstants.kDefaultPadding,
                child: _NetworkConnectionBar(
                  isNetworkEnabled: state.isNetworkEnabled,
                  size: networkBarSize,
                  duration: _animationDuration,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _NetworkConnectionBar extends StatelessWidget {
  final bool isNetworkEnabled;
  final double size;
  final int duration;

  const _NetworkConnectionBar({
    Key? key,
    required this.isNetworkEnabled,
    required this.size,
    this.duration = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: duration),
      height: isNetworkEnabled ? 0.0 : size,
      width: mq.size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
            Radius.circular(StyleConstants.kDefaultPadding)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(StyleConstants.kDefaultPadding),
        child: Center(
          child: Text(
            'Network connection is disabled',
            style: TextStyle(
              fontSize: 16.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
