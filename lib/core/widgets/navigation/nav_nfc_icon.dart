import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/animations/animation_fade_transition.dart';
import 'package:nfc_mobile_prototype/core/widgets/navigation/nav_core.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NavNFCIcon extends StatelessWidget {
  final Curve curve;

  const NavNFCIcon({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        if (state.routes.last != ScannerScreen.screenIndex) {
          return Container();
        }

        return Positioned(
          bottom: NavigationCore.getBottomCurtainSize(context) +
              (StyleConstants.kDefaultPadding * 2.0),
          right: StyleConstants.kDefaultPadding + horizontalPadding,
          child: AnimationFadeTransition(
            curve: curve,
            opacity: 1.0,
            isActive: state.routeToRemove != ScannerScreen.screenIndex,
            child: const _NFCIcon(),
          ),
        );
      },
    );
  }
}

class _NFCIcon extends StatefulWidget {
  const _NFCIcon({Key? key}) : super(key: key);

  @override
  _NFCIconState createState() => _NFCIconState();
}

class _NFCIconState extends State<_NFCIcon> {
  bool _isInit = false;
  bool _isNFCAvailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<NFCService>().checkNFCAvailable().then((isAvailable) {
        setState(() {
          _isInit = true;
          _isNFCAvailable = isAvailable;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30.0,
          width: 30.0,
          child: Image.asset(
            'assets/icons/nfc.png',
            fit: BoxFit.fill,
            color: _isNFCAvailable
                ? StyleConstants.kHyperLinkColor
                : StyleConstants.kInactiveColor,
          ),
        ),
        const SizedBox(
          height: StyleConstants.kDefaultPadding * 0.4,
        ),
        Text(
          _isNFCAvailable ? 'NFC ONSITE' : 'NFC UNABLE',
          style: StyleConstants.kGetBoldTextStyle(context).copyWith(
            fontSize: 12.0,
            color: _isNFCAvailable
                ? StyleConstants.kHyperLinkColor
                : StyleConstants.kInactiveColor,
          ),
        ),
      ],
    );
  }
}
