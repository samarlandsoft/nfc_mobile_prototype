import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/usecases/upload_logs.dart';
import 'package:nfc_mobile_prototype/core/widgets/animated_loader.dart';
import 'package:nfc_mobile_prototype/core/widgets/dialogs_wrapper.dart';
import 'package:nfc_mobile_prototype/core/widgets/neon_button.dart';
import 'package:nfc_mobile_prototype/core/widgets/text_input_field.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key? key}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController _controller = TextEditingController();
  final int _reportMaxLength = 100;
  final int _reportMinLength = 10;

  bool _isButtonDisabled = true;
  bool _isReportUploading = false;
  bool _isErrorShown = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkButtonDisability);
  }

  @override
  void dispose() {
    _controller.removeListener(_checkButtonDisability);
    super.dispose();
  }

  void _checkButtonDisability() {
    final showError = _controller.text.length < _reportMinLength;
    final isDisabled = (_controller.text.isEmpty ||
        _controller.text.length < _reportMinLength ||
        _controller.text.length > _reportMaxLength);

    if (_isErrorShown != showError) {
      setState(() {
        _isErrorShown = showError;
      });
    }

    if (_isButtonDisabled != isDisabled) {
      setState(() {
        _isButtonDisabled = isDisabled;
      });
    }
  }

  Future<void> _onSendReportHandler() async {
    setState(() {
      _isButtonDisabled = true;
      _isReportUploading = true;
    });

    final isSuccess = await locator<UploadLogs>().call(_controller.text.trim());
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final buttonWidth = mq.size.width * 0.7;
    final buttonHeight = NeonButton.getButtonHeight(context);

    final titleTextSize = TextPainter(
      text: const TextSpan(
        text: 'Send bug report',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    final double dialogSize = TextInputField.inputFiledHeight +
        buttonHeight +
        titleTextSize.height +
        (StyleConstants.kDefaultPadding * 7.0);

    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 18.0,
        fontFamily: 'Montserrat',
      ),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: SizedBox(
          height: dialogSize,
          child: DialogsWrapper(
            widget: Column(
              children: <Widget>[
                const SizedBox(
                  height: StyleConstants.kDefaultPadding,
                ),
                const Text(
                  'Send bug report',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: StyleConstants.kDefaultPadding * 2.0,
                ),
                Expanded(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: StyleConstants.kDefaultPadding * 0.5),
                          child: TextInputField(
                            controller: _controller,
                            hintText: 'Whats\' your problem???',
                            errorText: 'Enter at least $_reportMinLength characters',
                            maxLength: _reportMaxLength,
                            showError: _isErrorShown,
                          ),
                        ),
                        const SizedBox(
                          height: StyleConstants.kDefaultPadding * 0.5,
                        ),
                        SizedBox(
                          height: buttonHeight,
                          child: _isReportUploading
                              ? AnimatedLoader(
                                  height: buttonHeight,
                                  width: buttonHeight,
                                )
                              : AbsorbPointer(
                                  absorbing: _isButtonDisabled,
                                  child: NeonButton(
                                    label: 'Send report',
                                    callback: _onSendReportHandler,
                                    width: buttonWidth,
                                    isTapped: !_isButtonDisabled,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: StyleConstants.kDefaultPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
