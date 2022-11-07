import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomeInput extends ConsumerWidget {
  const CustomeInput(
      {super.key,
      this.obscure,
      this.icon,
      required this.controller,
      this.validator,
      this.inputType,
      required this.label});
  final TextEditingController controller;
  final bool? obscure;
  final String? Function(String?)? validator;
  final String label;
  final IconData? icon;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade500, width: 2))),
    );
  }
}
