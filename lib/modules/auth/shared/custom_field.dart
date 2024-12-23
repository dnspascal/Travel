import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
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
  final ValueChanged<String>? onChanged;

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
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            filled: false,
            labelText: widget.label,
            hintText: widget.hint,
            labelStyle: GoogleFonts.quicksand(
              color: widget.focusState.value
                  ? Colors.blueAccent.shade700
                  : Colors.black,
            ),
            hintStyle: GoogleFonts.quicksand(
              color: widget.focusState.value
                  ? Colors.blueAccent.shade700
                  : Colors.black,
            ),
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: widget.focusState.value
                        ? Colors.blueAccent.shade700
                        : Colors.black,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: Text(
                      _isObscured ? 'Show' : 'Hide',
                      style: const TextStyle(color: Colors.black),
                    ),
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
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          obscureText: _isObscured,
          validator: widget.validator,
          style: GoogleFonts.quicksand(
            color: widget.focusState.value
                ? Colors.blueAccent.shade700
                : Colors.black,
          ),
          focusNode: widget.focusNode,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          }),
    );
  }
}
