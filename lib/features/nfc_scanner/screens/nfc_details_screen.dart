import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCDetailsScreen extends StatelessWidget {
  final Ndef ndef;

  const NFCDetailsScreen({
    Key? key,
    required this.ndef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const Text(
            'NDEF',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            ndef.isWritable.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            ndef.maxSize.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            ndef.additionalData['identifier'].toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            ndef.additionalData['canMakeReadOnly'].toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Text(
            ndef.additionalData['type'].toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          if (ndef.cachedMessage != null)
            Column(
              children: ndef.cachedMessage!.records
                  .map((record) => Column(
                        children: <Widget>[
                          Text(
                            '${record.identifier.toString()} - ${String.fromCharCodes(record.identifier)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            '${record.type.toString()} - ${String.fromCharCodes(record.type)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            record.typeNameFormat.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            '${record.payload.toString()} - ${String.fromCharCodes(record.payload)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
