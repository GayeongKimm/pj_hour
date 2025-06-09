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

  const HourTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.supportText,
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
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
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            widget.labelText ?? "",
            style: HourStyles.label1.copyWith(
              fontSize: 14.0,
              height: 1.2,
              color: _focusNode.hasFocus
                  ? HourColors.primary300
                  : HourColors.gray700,
            ),
          ),
        ),
        Positioned(
          child: TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            style: HourStyles.label1.copyWith(height: 1.3),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: HourColors.primary300,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: HourStyles.label1.copyWith(height: 1.3),
              helperText: widget.supportText,
              helperStyle: HourStyles.label1.copyWith(
                fontSize: 14,
                height: 1.4,
              ),
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
        ),
      ],
    );
  }
}