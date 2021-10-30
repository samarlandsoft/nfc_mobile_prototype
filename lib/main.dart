import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/marketplace_screen.dart';
import 'package:nfc_mobile_prototype/features/marketplace/screens/product_details_screen.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/bloc/nfc_bloc.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/screens/nfc_scanner_screen.dart';
import 'package:nfc_mobile_prototype/features/splash/screens/splash_screen.dart';
import 'package:nfc_mobile_prototype/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
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
                      detailsProduct: settings.arguments as DetailsProduct,
                    ),
                  );
                },
              );
            }
        }
      },
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: locator<AppBloc>()),
          BlocProvider.value(value: locator<NFCBloc>()),
        ],
        child: const ScreenNavigator(),
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
  final List<Widget> _screens = [
    const SplashScreen(),
    const NfcScannerScreen(),
    const MarketplaceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppBlocState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _screens[state.currentScreenIndex],
              ),
            ],
          );
        },
      ),
    );
  }
}
