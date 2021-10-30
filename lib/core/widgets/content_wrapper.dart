import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final String? backgroundSrc;
  final bool withLabel;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.backgroundSrc,
    this.withLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final topPadding = withLabel ? mq.viewPadding.top + 10.0 : 10.0;

    return BlocBuilder<AppBloc, AppBlocState>(builder: (context, state) {
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
                  SizedBox(
                    height: 70.0,
                    child: Image.asset('assets/icons/logo.png'),
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
                          ? mq.size.height - (topPadding + 100.0)
                          : mq.size.height,
                      child: widget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
