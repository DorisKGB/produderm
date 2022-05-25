import 'package:flutter/material.dart';

class SWInput extends StatefulWidget {
  const SWInput(
      {Key? key,
      required this.outData,
      required this.inData,
      required this.labelText,
      this.maxLines = 1,
      this.isEnable,
      this.obscureText = false,
      this.myFocusNode,
      this.textAlign = TextAlign.center,
      this.textInputType = TextInputType.text,
      this.textCapitalization = TextCapitalization.sentences,
      this.isAutoFocus = false,
      this.prefixIcon,
      this.textInputAction,
      this.suffixIcon})
      : super(key: key);

  final Stream<String> outData;
  final Function(String) inData;
  final String labelText;
  final int maxLines;
  final bool obscureText;
  final FocusNode? myFocusNode;
  final dynamic isEnable;  final bool isAutoFocus;
  final TextAlign textAlign;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  @override
  State<SWInput> createState() => _SWInputState();
}

class _SWInputState extends State<SWInput> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.outData,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && controller.text.isEmpty) {
          controller.text = snapshot.data.toString();
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
        }
        return getInput(snapshot.hasError ? snapshot.error.toString() : null);
      },
    );
  }

  Widget getInput(String? error) {
    return TextFormField(
      key: widget.key,
      textInputAction: widget.textInputAction,
      style: const TextStyle(fontSize: 18),
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
          errorText: error,
          border: const OutlineInputBorder(          
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon),
      onChanged: widget.inData,
      focusNode: widget.myFocusNode,
      controller: controller,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines,
      enabled: widget.isEnable,
      autofocus: widget.isAutoFocus,
    );
  }
}
