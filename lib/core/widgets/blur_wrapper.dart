import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';

class BlurWrapper extends StatelessWidget {
  final Widget widget;

  const BlurWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(buildWhen: (prev, current) {
      return prev.isCustomTheme != current.isCustomTheme;
    }, builder: (context, state) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: state.isCustomTheme
                ? Colors.grey.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: widget,
          ),
        ),
      );
    });
  }
}
