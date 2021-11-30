import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nfc_mobile_prototype/core/models/app_service_data.dart';
import 'package:nfc_mobile_prototype/core/services/logger_service.dart';

class FirebaseService {
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;

  static const _collectionName = 'reports';
  static const _bucketName = 'logs';

  Future<void> init() async {
    logDebug('FirebaseService -> init()');
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _firestore.settings = const Settings(
      sslEnabled: true,
      persistenceEnabled: true,
    );
  }

  Future<void> sendReport(
    AppServiceData serviceData,
    String message,
    String logFileName,
  ) async {
    logDebug('FirebaseService -> sendReport()');
    final batch = _firestore.batch();
    final logDownloadURL = await _getDownloadLink(logFileName);

    batch.set(_firestore.collection(_collectionName).doc(), {
      'metadata': serviceData.toJson(),
      'message': message,
      'logName': '$logFileName.txt',
      'logDownloadURL': logDownloadURL ?? 'null',
    });
    await batch.commit();
  }

  Future<bool> uploadReportFile(File logs, String logID) async {
    logDebug('FirebaseService -> uploadReportFile($logID)');
    try {
      await _storage.ref('$_bucketName/$logID.txt').putFile(logs);
    } on FirebaseException catch (e) {
      logDebug('FirebaseException: $e');
      return false;
    }

    return true;
  }

  Future<String?> _getDownloadLink(String logFileName) async {
    logDebug('FirebaseService -> _getDownloadLink($logFileName)');
    try {
      return await _storage.ref('$_bucketName/$logFileName.txt').getDownloadURL();
    } on FirebaseException catch (e) {
      logDebug('FirebaseException: $e');
    }

    return null;
  }
}
