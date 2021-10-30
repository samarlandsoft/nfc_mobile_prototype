import 'package:flutter/material.dart';

class ContentWrapper extends StatelessWidget {
  final Widget widget;

  const ContentWrapper({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, mq.viewPadding.top + 10.0, 10.0, 10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 70.0,
            child: Image.asset('assets/icons/logo.png'),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: mq.size.height - (mq.viewPadding.top + 100.0),
                child: widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
