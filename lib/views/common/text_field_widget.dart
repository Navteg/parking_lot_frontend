import 'package:flutter/material.dart';
import 'package:parking_lot_system/utils/responsive_utils.dart';
import 'package:parking_lot_system/utils/theme.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final bool numberKeyboard;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool textCapitalization;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
    this.numberKeyboard = false,
    required this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUtils.screenHeight(context) * 0.06,
      padding:
          EdgeInsets.only(top: ResponsiveUtils.textScaleFactor(context) * 5),
      decoration: BoxDecoration(
        color: ColorTheme.textfield,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: ColorTheme.grayThemeLight,
          width: 1,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          widget.onChanged(value);
        },
        cursorColor: const Color.fromARGB(55, 97, 97, 97),
        keyboardType:
            widget.numberKeyboard ? TextInputType.number : TextInputType.name,
        style: TextStyle(
          color: ColorTheme.nearBlack,
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveUtils.textScaleFactor(context) * 16,
        ),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: ColorTheme.nearBlack,
            fontSize: ResponsiveUtils.textScaleFactor(context) * 16,
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: const Color.fromARGB(115, 0, 0, 0),
          ),
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
        textCapitalization: widget.textCapitalization
            ? TextCapitalization.characters
            : TextCapitalization.none,
      ),
    );
  }
}
