import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_mobile_prototype/core/widgets/content_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/dialogs_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';

class NFCDetailsScreen extends StatelessWidget {
  final Ndef ndef;

  const NFCDetailsScreen({
    Key? key,
    required this.ndef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(
        color: Colors.black,
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
              'Chip ID - ${ndef.additionalData['identifier'].toString()}',
            ),
            Text(
              'Type - ${ndef.additionalData['type'].toString()}',
            ),
            if (ndef.cachedMessage != null)
              Column(
                children: ndef.cachedMessage!.records
                    .map((record) => Column(
                          children: <Widget>[
                            const Text(
                              'Data(in JWT):',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              String.fromCharCodes(record.payload),
                            ),
                          ],
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
