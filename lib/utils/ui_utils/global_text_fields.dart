import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors/app_colors.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool isSee = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.c_0C1A30,),
      keyboardType: TextInputType.name,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.c_838589,),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            )),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.c_C93545,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
