import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/logo_icon.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final String? backgroundSrc;
  final bool withLabel;
  final bool withBottomBar;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.backgroundSrc,
    this.withLabel = true,
    this.withBottomBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final topPadding = withLabel ? mq.viewPadding.top + 10.0 : 10.0;
    final logoSize = StyleConstraints.getLogoHeight(context);
    final bottomBarSize =
        withBottomBar ? StyleConstraints.bottomBarHeight : 0.0;

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
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, topPadding, 10.0, 10.0),
              child: Column(
                children: <Widget>[
                  if (withLabel)
                    LogoIcon(
                      size: logoSize,
                    ),
                  if (withLabel)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: withLabel
                            ? mq.size.height -
                                (topPadding + logoSize + bottomBarSize + 30.0)
                            : mq.size.height - bottomBarSize,
                        child: widget,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
