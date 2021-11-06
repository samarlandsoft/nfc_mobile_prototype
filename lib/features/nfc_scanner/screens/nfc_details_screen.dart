import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/dialogs_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/models/jwt_payload.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/jwt_service.dart';
import 'package:nfc_mobile_prototype/features/nfc_scanner/domain/services/nfc_service.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class NFCDetailsScreen extends StatelessWidget {
  final Ndef ndef;

  const NFCDetailsScreen({
    Key? key,
    required this.ndef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chipID = locator<NFCService>()
        .getChipID(ndef.additionalData['identifier'] as Uint8List);

    return DefaultTextStyle.merge(
      style: const TextStyle(
        fontSize: 16.0,
      ),
      child: DialogsWrapper(
        widget: ScrollableWrapper(
          widgets: <Widget>[
            const Text(
              'Result:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Max size - ${ndef.maxSize.toString()}Kb',
            ),
            Text(
              'Writable - ${ndef.isWritable.toString()}',
            ),
            Text(
              'Chip ID - $chipID',
            ),
            Text(
              'Type - ${ndef.additionalData['type'].toString()}',
            ),
            if (ndef.cachedMessage != null)
              Column(
                children: ndef.cachedMessage!.records.map((record) {
                  var chipID = locator<NFCService>()
                      .getChipID(ndef.additionalData['identifier'] as Uint8List);
                  var jwtPayload =
                      String.fromCharCodes(record.payload).substring(3);
                  var jwtResult = locator<JWTService>().verifyToken(jwtPayload, chipID);
                  var data = jwtResult.fold(
                    (failure) => jwtPayload,
                    (result) => JWTPayloadModel.fromJson(result),
                  );

                  return Column(
                    children: <Widget>[
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding,
                      ),
                      Text(
                        data is JWTPayloadModel
                            ? 'Data (JWT format):'
                            : 'Data (JWT not valid):',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: StyleConstants.kDefaultPadding * 0.5,
                      ),
                      if (data is JWTPayloadModel)
                        Text(
                          data.toJson().toString(),
                        ),
                      if (data is! JWTPayloadModel)
                        Text(
                          data.toString(),
                        ),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
