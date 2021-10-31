import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/splash/widgets/animated_app_icon.dart';
import 'package:nfc_mobile_prototype/features/splash/widgets/animated_description.dart';
import 'package:nfc_mobile_prototype/features/splash/widgets/animated_logo.dart';
import 'package:nfc_mobile_prototype/main.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInit = false;
  bool _isLogoVisible = false;
  bool _isFinish = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _playAnimation(2000);
    }
    super.didChangeDependencies();
  }

  void _playAnimation(int duration) {
    Future.delayed(Duration(milliseconds: duration)).then((_) {
      setState(() {
        _isInit = true;
      });
    });
    Future.delayed(Duration(milliseconds: duration + 1000)).then((_) {
      setState(() {
        _isLogoVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: duration + 5000)).then((_) {
      setState(() {
        _isFinish = true;
      });
    });
    Future.delayed(Duration(milliseconds: duration + 6500)).then((_) {
      Navigator.of(context).pushReplacementNamed(ScreenNavigator.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top + 10.0;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, topPadding, 10.0, 10.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedAppIcon(
              isVisible: _isInit,
            ),
            AnimatedLogo(
              isVisible: _isLogoVisible,
              isEndAnimation: _isFinish,
            ),
            AnimatedDescription(
              isVisible: _isFinish ? !_isFinish : _isLogoVisible,
            ),
          ],
        ),
      ),
    );
  }
}
