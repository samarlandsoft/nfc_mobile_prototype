import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;
  final EdgeInsets? padding;

  const ContentWrapper({
    Key? key,
    required this.widget,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isCurtainOpacityEnabled != current.isCurtainOpacityEnabled;
      },
      builder: (context, state) {
        return Padding(
          padding: padding ??
              EdgeInsets.fromLTRB(
                StyleConstants.kDefaultPadding + horizontalPadding,
                state.isCurtainOpacityEnabled
                    ? 0.0
                    : StyleConstants.kDefaultPadding * 3.0,
                StyleConstants.kDefaultPadding + horizontalPadding,
                0.0,
              ),
          child: widget,
        );
      },
    );
  }
}
