import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/core/constants.dart';
import 'package:nfc_mobile_prototype/core/widgets/buttons/salt_text_button.dart';
import 'package:nfc_mobile_prototype/core/widgets/salt_input_field.dart';
import 'package:nfc_mobile_prototype/core/widgets/wrappers/content_wrapper.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/bloc/debug_state.dart';
import 'package:nfc_mobile_prototype/features/scanner/domain/usecases/debug_nfc_chip.dart';
import 'package:nfc_mobile_prototype/locator.dart';

class DebugDialog extends StatefulWidget {
  final DebugBlocState debugState;

  const DebugDialog({
    Key? key,
    required this.debugState,
  }) : super(key: key);

  @override
  State<DebugDialog> createState() => _DebugDialogState();
}

class _DebugDialogState extends State<DebugDialog> {
  late final TextEditingController _tagIDController;
  late final TextEditingController _tokenIDController;
  late final TextEditingController _md5HashController;
  String? _tokenMessage;

  @override
  void initState() {
    super.initState();
    _tagIDController = TextEditingController(
      text: widget.debugState.chipID,
    );
    _tokenIDController = TextEditingController(
      text: widget.debugState.tokenID,
    );
    _md5HashController = TextEditingController(
      text: widget.debugState.md5Hash,
    );
  }

  @override
  void deactivate() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.deactivate();
  }

  Future<void> _onDebugTokenHandler() async {
    if (_tagIDController.value.text.isEmpty ||
        _tokenIDController.value.text.isEmpty ||
        _md5HashController.value.text.isEmpty) {
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    final tokenData = await locator<DebugNFCChip>().call(DebugBlocState(
      chipID: _tagIDController.value.text,
      tokenID: _tokenIDController.value.text,
      md5Hash: _md5HashController.value.text,
    ));

    if (tokenData.error != null) {
      setState(() {
        _tokenMessage = tokenData.error;
      });
    } else if (tokenData.tokenID != null) {
      setState(() {
        _tokenMessage = 'Success';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: StyleConstants.kGetDefaultTextStyle(context).copyWith(
        fontSize: StyleConstants.kGetScreenRatio(context) ? 22.0 : 18.0,
      ),
      child: ContentWrapper(
        withVerticalPadding: true,
        widget: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Debug console'),
              const SizedBox(
                height: StyleConstants.kDefaultPadding * 2.0,
              ),
              SaltInputField(
                controller: _tagIDController,
                labelText: 'Chip ID',
                hintText: 'Chip ID',
                withCapitalization: true,
              ),
              const SizedBox(
                height: StyleConstants.kDefaultPadding * 1.5,
              ),
              SaltInputField(
                controller: _tokenIDController,
                labelText: 'Token ID',
                hintText: 'Token ID',
              ),
              const SizedBox(
                height: StyleConstants.kDefaultPadding * 1.5,
              ),
              SaltInputField(
                controller: _md5HashController,
                labelText: 'MD5 Hash',
                hintText: 'MD5 Hash',
              ),
              if (_tokenMessage != null) ...[
                const SizedBox(
                  height: StyleConstants.kDefaultPadding * 2.0,
                ),
                Text(_tokenMessage!),
              ],
              const SizedBox(
                height: StyleConstants.kDefaultPadding * 2.0,
              ),
              SaltTextButton(
                label: 'CHECK',
                width: double.maxFinite,
                callback: _onDebugTokenHandler,
                buttonColor: StyleConstants.kMarketColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
