import 'package:nfc_mobile_prototype/core/models/usecase.dart';
import 'package:nfc_mobile_prototype/core/services/firebase_service.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class UploadAppLogs implements Usecase<bool, String> {
  final LoggerService loggerService;
  final FirebaseService firebaseService;

  const UploadAppLogs({
    required this.loggerService,
    required this.firebaseService,
  });

  @override
  Future<bool> call(String message) async {
    logDebug('UploadAppLogs usecase -> call()');
    final metaData = await loggerService.getAppMetaData();
    final logsID =
        '${DateTime.now().microsecondsSinceEpoch}-${metaData.deviceName}';
    var isUploaded = false;

    final loggerResult = await loggerService.getLogs();
    await loggerResult.fold(
          (failure) => null,
          (logs) async {
        isUploaded = await firebaseService.uploadReportFile(logs, logsID);
      },
    );

    if (isUploaded) {
      firebaseService.sendReport(metaData, message, logsID);
    }

    return isUploaded;
  }
}
