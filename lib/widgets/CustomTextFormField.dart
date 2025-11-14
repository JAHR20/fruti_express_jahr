// archivo: lib/widgets/custom_text_form_field.dart
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
