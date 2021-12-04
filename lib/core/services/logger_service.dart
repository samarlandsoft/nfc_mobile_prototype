import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:nfc_mobile_prototype/core/models/failures.dart';
import 'package:nfc_mobile_prototype/core/models/logger_service_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class LoggerService {
  static const logDirectory = 'logs';

  Future<void> init() async {
    await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.ERROR,
        LogLevel.INFO,
        LogLevel.SEVERE,
        LogLevel.WARNING,
      ],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.FOR_DATE,
      logTypesEnabled: [logDirectory],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: 'logger',
      logsExportDirectoryName: 'logger/exported',
      zipsRetentionPeriodInDays: 1,
      logsRetentionPeriodInDays: 1,
    );

    final metaData = await getAppMetaData();
    final metaMessage = _getAppMetaMessage(metaData);

    FlutterLogs.clearLogs();
    FlutterLogs.logToFile(
      logFileName: logDirectory,
      logMessage: metaMessage,
    );
  }

  /// Get app version and other app parameters
  Future<LoggerServiceData> getAppMetaData() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = Platform.isAndroid
        ? await DeviceInfoPlugin().androidInfo
        : await DeviceInfoPlugin().iosInfo;

    return LoggerServiceData(
      appName: packageInfo.appName,
      appVersion: packageInfo.version,
      environmentId: packageInfo.buildNumber,
      deviceName: Platform.isAndroid
          ? (deviceInfo as AndroidDeviceInfo).model
          : (deviceInfo as IosDeviceInfo).model,
      deviceType: Platform.isAndroid ? 'android' : 'ios',
      deviceSdkInt: Platform.isAndroid
          ? (deviceInfo as AndroidDeviceInfo).version.release
          : (deviceInfo as IosDeviceInfo).systemVersion,
    );
  }

  /// Return log file content
  Future<Either<Failure, File>> getLogs() async {
    final externalDirectory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    var logsDirectory = Directory('${externalDirectory!.path}/logger/Logs');

    if (logsDirectory.listSync().isEmpty) {
      return Left(CommonFailure('Directory is empty'));
    }

    final currentDirectory = Directory(logsDirectory.listSync()[0].path);
    final currentLogFile = File('${currentDirectory.path}/$logDirectory.log');

    if (!currentLogFile.existsSync()) {
      return Left(CommonFailure('Log file doens\'t exists'));
    }

    return Right(currentLogFile);
  }

  String _getAppMetaMessage(LoggerServiceData metaData) {
    var metaMessage = '=========================\n';
    metaMessage += 'META INFO:\n';
    metaMessage += metaData.toString();
    metaMessage += '\n=========================\n';
    metaMessage += 'LOGS:\n';

    return metaMessage;
  }
}

void logDebug(String message) {
  final time = DateTime.now();
  final formattedTime =
      '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}';

  FlutterLogs.logToFile(
    logFileName: LoggerService.logDirectory,
    logMessage: '***** $formattedTime > $message\n',
  );
}
