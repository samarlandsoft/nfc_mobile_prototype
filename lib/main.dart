import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/services/firebase_service.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/services/network_service.dart';
import 'package:nfc_mobile_prototype/core/widgets/scaffold_wrapper.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/features/market/domain/bloc/market_bloc.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/scanner_bloc.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: StyleConstants.kGetDarkColor(),
  ));

  initLocator();
  await locator<LoggerService>().init();
  locator<NetworkService>().listenNetworkChanges();
  locator<FirebaseService>().init();

  runApp(const MyAppTemp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<AppBloc>()),
        BlocProvider.value(value: locator<ScannerBloc>()),
        BlocProvider.value(value: locator<MarketBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: StyleConstants.kBackgroundColor,
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              color: StyleConstants.kGetDarkColor(),
            ),
          ),
        ),
        home: const ScreenNavigator(),
      ),
    );
  }
}

class MyAppTemp extends StatelessWidget {
  const MyAppTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<AppBloc>()),
        BlocProvider.value(value: locator<ScannerBloc>()),
        BlocProvider.value(value: locator<MarketBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: StyleConstants.kDefaultTextStyle.fontFamily,
          scaffoldBackgroundColor: StyleConstants.kBackgroundColor,
        ),
        home: const ScreenNavigator(),
      ),
    );
  }
}

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({Key? key}) : super(key: key);

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<Widget> _screens = const [
    HomeScreen(),
    AboutScreen(),
    ScannerScreen(),
    MarketScreen(),
    MarketDetailsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return (prev.currentScreenIndex != current.currentScreenIndex);
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: DefaultTextStyle(
            style: StyleConstants.kDefaultTextStyle,
            child: ScaffoldWrapper(
              widget: PageStorage(
                bucket: _bucket,
                child: _screens[state.currentScreenIndex],
              ),
            ),
          ),
        );
      },
    );
  }
}
