import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_state.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_screen_index.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  void _onChangeScreenButtonHandler(int index) {
    locator<UpdateScreenIndex>().call(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return (prev.currentScreenIndex != current.currentScreenIndex);
      },
      builder: (context, state) {
        return BottomNavigationBar(
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.orange.withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(
              label: 'Market',
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Scanner',
              icon: Icon(Icons.scanner_outlined),
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: Icon(Icons.description_outlined),
            ),
          ],
          currentIndex: state.currentScreenIndex,
          onTap: _onChangeScreenButtonHandler,
        );
      },
    );
  }
}
