import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.colorScheme,
    required this.controller,
    this.hintText,
    required this.label,
    required this.iconData,
    this.isPassword = false,
    this.keyboardType = TextInputType.name,
    this.readOnly = false,
    this.press,
  });

  final ColorScheme colorScheme;
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final IconData iconData;
  final bool isPassword;
  final TextInputType keyboardType;
  final bool readOnly;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  blurRadius: 50,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(2, 2),
                  color: colorScheme.primaryContainer.withOpacity(0.5))
            ]),
        width: double.infinity,
        child: TextFormField(
          controller: controller,
          onTap: press,
          readOnly: readOnly,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            label: Text(label),
            border: InputBorder.none,
            hintText: hintText,
          ),
        ));
  }
}
