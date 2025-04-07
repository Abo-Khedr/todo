import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';

typedef myValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String lable;
  myValidator validator;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText;

  CustomTextFormField({
    super.key,
    required this.lable,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.redColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.redColor,
              width: 2,
            ),
          ),
          labelText: lable,
        ),
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}
