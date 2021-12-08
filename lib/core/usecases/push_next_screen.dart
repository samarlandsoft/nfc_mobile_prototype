import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';
import 'package:nfc_mobile_prototype/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:nfc_mobile_prototype/features/about/screens/about_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_details_screen.dart';
import 'package:nfc_mobile_prototype/features/market/screens/market_screen.dart';
import 'package:nfc_mobile_prototype/features/scanner/screens/scanner_screen.dart';

class PushNextScreen implements Usecase<void, int> {
  final AppBloc bloc;
  final UpdateWrapperCurtainMode updateWrapperCurtainMode;

  const PushNextScreen({
    required this.bloc,
    required this.updateWrapperCurtainMode,
  });

  @override
  Future<void> call(int index) async {
    logDebug('PushNextScreen usecase -> call($index)');
    if (bloc.state.routes.contains(index)) return;
    bloc.add(AppPushScreen(screenIndex: index));

    switch (index) {
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

      case AboutScreen.screenIndex:
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
