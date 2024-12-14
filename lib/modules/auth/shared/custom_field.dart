import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final FormFieldValidator<String>? validator;
  final FocusNode focusNode;
  final RxBool focusState;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    required this.focusNode,
    required this.focusState,
    this.keyboardType,
    this.inputFormatters,
    this.isPassword = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: false,
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.quicksand(
            color: focusState.value ? Colors.blueAccent.shade700 : Colors.black,
          ),
          hintStyle: GoogleFonts.quicksand(
            color: focusState.value ? Colors.blueAccent.shade700 : Colors.black,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: focusState.value
                      ? Colors.blueAccent.shade700
                      : Colors.black,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.blueAccent.shade700,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 0.3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.blueAccent.shade700,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1,
            ),
          ),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: isPassword,
        validator: validator,
        style: GoogleFonts.quicksand(
          color: focusState.value ? Colors.blueAccent.shade700 : Colors.black,
        ),
        focusNode: focusNode,
      ),
    );
  }
}
