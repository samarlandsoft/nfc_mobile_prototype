import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';

class CardTags extends StatelessWidget {
  final List<String> tags;

  const CardTags({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: StyleConstants.kDefaultPadding * 0.5,
      runSpacing: StyleConstants.kDefaultPadding * 0.5,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: StyleConstants.kDefaultPadding * 0.5,
            horizontal: StyleConstants.kDefaultPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(StyleConstants.kDefaultPadding * 0.5)),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
