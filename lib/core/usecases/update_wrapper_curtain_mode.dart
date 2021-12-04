import 'package:nfc_mobile_prototype/core/bloc/app_bloc.dart';
import 'package:nfc_mobile_prototype/core/bloc/app_events.dart';
import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UpdateWrapperCurtainMode implements Usecase<void, NoParams> {
  final AppBloc bloc;

  const UpdateWrapperCurtainMode({
    required this.bloc,
  });

  @override
  Future<void> call(
    NoParams params, {
    bool isTopCurtainEnabled = false,
    bool isBottomCurtainEnabled = false,
    bool isCurtainOpacityEnabled = false,
  }) async {
    logDebug('UpdateWrapperCurtainMode usecase -> call($isTopCurtainEnabled, $isBottomCurtainEnabled)');
    bloc.add(AppUpdateWrapperCurtainMode(
      isTopCurtainEnabled: isTopCurtainEnabled,
      isBottomCurtainEnabled: isBottomCurtainEnabled,
      isCurtainOpacityEnabled: isCurtainOpacityEnabled,
    ));
  }
}
