// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final String hint;
//   final IconData prefixIcon;
//   final bool isPassword;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     required this.hint,
//     required this.prefixIcon,
//     this.isPassword = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           obscureText: isPassword,
//           decoration: InputDecoration(
//             hintText: hint,
//             prefixIcon: Icon(prefixIcon, color: Colors.grey),
//             suffixIcon: isPassword
//                 ? IconButton(
//                     icon: const Icon(Icons.visibility_off),
//                     onPressed: () {},
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? prefix;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix ?? Icon(prefixIcon, color: Colors.grey),
            suffixIcon: isPassword
                ? IconButton(
                    icon: const Icon(Icons.visibility_off),
                    onPressed: () {},
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}