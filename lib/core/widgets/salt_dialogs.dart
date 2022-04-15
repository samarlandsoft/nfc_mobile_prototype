import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

Future<dynamic> saltShowBottomSheet(
  BuildContext context,
  Widget dialog,
) async {
  return await showModalBottomSheet<dynamic>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(StyleConstants.kDefaultPadding),
      ),
    ),
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.black.withOpacity(0.8),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: dialog,
      );
    },
  );
}
