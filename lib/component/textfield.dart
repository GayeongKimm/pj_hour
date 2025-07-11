import 'package:flutter/material.dart';
import 'package:hour/component/theme/color.dart';
import 'package:hour/component/theme/style.dart';

class HourTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? supportText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color? textColor;

  const HourTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.supportText,
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textColor,
  });

  @override
  State<HourTextField> createState() => _HourTextFieldState();
}

class _HourTextFieldState extends State<HourTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: HourStyles.label1.copyWith(
              color: _focusNode.hasFocus ? HourColors.primary300 : HourColors.staticWhite,
            ),
          ),
        const SizedBox(height: 4),
        TextFormField(
          focusNode: _focusNode,
          controller: _controller,
          style: HourStyles.label1.copyWith(
            color: widget.textColor ?? HourColors.staticWhite,
          ),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: HourColors.primary300,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: HourStyles.label1,
            helperText: widget.supportText,
            helperStyle: HourStyles.label1,
            fillColor: HourColors.primary300,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: HourColors.gray500,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: HourColors.primary300,
              ),
            ),
            errorBorder: InputBorder.none,
          ),
        ),
      ],
    );
  }
}