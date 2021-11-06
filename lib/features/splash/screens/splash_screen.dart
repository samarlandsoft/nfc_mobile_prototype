import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/services/local_storage_service.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_app_theme.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_app_icon.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_sweater.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/usecases/init_marketplace.dart';
import 'package:nfc_mobile_prototype/features/splash/widgets/animated_description.dart';
import 'package:nfc_mobile_prototype/features/splash/widgets/animated_logo.dart';
import 'package:nfc_mobile_prototype/locator.dart';
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
  void initState() {
    super.initState();
    var isCustomTheme = locator<LocalStorageService>().getAppTheme();
    locator<UpdateAppTheme>().call(isCustomTheme, updateLocalStorage: false);
    locator<InitMarketplace>().call(CryptoCurrency.btc);
    locator<InitMarketplace>().call(CryptoCurrency.eth);
  }

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
    Future.delayed(Duration(milliseconds: duration + 6100)).then((_) {
      Navigator.of(context).pushReplacementNamed(ScreenNavigator.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding =
        MediaQuery.of(context).viewPadding.top + StyleConstants.kDefaultPadding;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          StyleConstants.kDefaultPadding,
          topPadding,
          StyleConstants.kDefaultPadding,
          StyleConstants.kDefaultPadding,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedAppIcon(
              isVisible: !_isInit,
            ),
            AnimatedLogo(
              isVisible: _isLogoVisible,
              isEndAnimation: _isFinish,
            ),
            AnimatedDescription(
              isVisible: _isLogoVisible,
              isEndAnimation: _isFinish,
            ),
          ],
        ),
      ),
    );
  }
}
