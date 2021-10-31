import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/widgets/scrollable_wrapper.dart';

class CardTags extends StatelessWidget {
  final List<String> tags;

  const CardTags({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableWrapper(
      direction: Axis.horizontal,
      widgets: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          margin: const EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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
