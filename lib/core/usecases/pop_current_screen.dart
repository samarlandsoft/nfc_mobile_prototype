import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class PopCurrentScreen implements Usecase<void, NoParams> {
  final AppBloc bloc;
  final UpdateWrapperCurtainMode updateWrapperCurtainMode;

  const PopCurrentScreen({
    required this.bloc,
    required this.updateWrapperCurtainMode,
  });

  @override
  Future<void> call(NoParams params) async {
    logDebug('PopCurrentScreen usecase -> call()');
    bloc.add(AppPopScreen());

    final int lastIndex = bloc.state.routes.indexOf(bloc.state.routes.last);
    final int previousIndex = bloc.state.routes[lastIndex - 1];

    switch (previousIndex) {
      case HomeScreen.screenIndex:
        {
          updateWrapperCurtainMode.call(
            NoParams(),
            isTopCurtainEnabled: false,
            isBottomCurtainEnabled: false,
          );
          break;
        }

      case ScannerScreen.screenIndex:
        {
          updateWrapperCurtainMode.call(
            NoParams(),
            isTopCurtainEnabled: true,
            isBottomCurtainEnabled: true,
          );
          break;
        }

      case MarketScreen.screenIndex:
        {
          updateWrapperCurtainMode.call(
            NoParams(),
            isTopCurtainEnabled: false,
            isBottomCurtainEnabled: true,
          );
          break;
        }

      case MarketDetailsScreen.screenIndex:
        {
          updateWrapperCurtainMode.call(
            NoParams(),
            isTopCurtainEnabled: true,
            isBottomCurtainEnabled: true,
          );
          break;
        }
    }
  }
}