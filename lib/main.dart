import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/services/local_storage_service.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_app_theme.dart';
import 'package:nfc_mobile_prototype/core/widgets/custom_bottom_bar.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/nfc_data_props.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/marketplace_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_scanner_screen.dart';
import 'package:nfc_mobile_prototype/features/splash/screens/splash_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  await locator<LocalStorageService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<AppBloc>()),
        BlocProvider.value(value: locator<MarketBloc>()),
        BlocProvider.value(value: locator<NFCBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: StyleConstants.kBackgroundColor,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontSize: 16.0,
              color: StyleConstants.kGetLightColor(),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              color: StyleConstants.kGetDarkColor(),
            ),
          ),
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case ProductDetailsScreen.routeName:
              {
                return PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, first, second) {
                    return FadeTransition(
                      opacity: first,
                      child: ProductDetailsScreen(
                        sweater: (settings.arguments as NFCDataProps).sweater,
                        fromToken: (settings.arguments as NFCDataProps).fromToken,
                      ),
                    );
                  },
                );
              }
          }
        },
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          ScreenNavigator.routeName: (context) => const ScreenNavigator(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}

class ScreenNavigator extends StatefulWidget {
  static const routeName = '/home';

  const ScreenNavigator({Key? key}) : super(key: key);

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    var isCustomTheme = locator<LocalStorageService>().getAppTheme();
    locator<UpdateAppTheme>().call(isCustomTheme, updateLocalStorage: false);
  }

  final List<Widget> _screens = const [
    MarketplaceScreen(),
    NfcScannerScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return (prev.currentScreenIndex != current.currentScreenIndex);
      },
      builder: (context, state) {
        return Scaffold(
          body: PageStorage(
            bucket: _bucket,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _screens[state.currentScreenIndex],
            ),
          ),
          bottomNavigationBar: const CustomBottomBar(),
        );
      },
    );
  }
}
