import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/domain/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/domain/models/details_product.dart';
import 'package:nfc_mobile_prototype/features/content/screens/content_screen.dart';
import 'package:nfc_mobile_prototype/features/content/screens/details_screen.dart';
import 'package:nfc_mobile_prototype/features/loader/screens/loader_screen.dart';
import 'package:nfc_mobile_prototype/features/token/screens/token_screen.dart';
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
          case DetailsScreen.routeName:
            {
              return PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, first, second) {
                  return FadeTransition(
                    opacity: first,
                    child: DetailsScreen(
                      detailsProduct: settings.arguments as DetailsProduct,
                    ),
                  );
                },
              );
            }
        }
      },
      home: BlocProvider.value(
        value: locator<AppBloc>(),
        child: const PageSwitcher(),
      ),
    );
  }
}

class PageSwitcher extends StatefulWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  State<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  final List<Widget> _screens = [
    const LoaderScreen(),
    const TokenScreen(),
    const ContentScreen(),
  ];

  SnackBar _buildSnackBar(String tag) {
    return SnackBar(
      content: Text('Read NFC: $tag'),
      duration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppBloc, AppState>(
        listenWhen: (prevState, currentState) {
          return prevState.tag != '' || currentState.tag != '';
        },
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(state.tag));
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _screens[state.index],
              ),
            ],
          );
        },
      ),
    );
  }
}
