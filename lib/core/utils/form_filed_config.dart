import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldType { dropdown, text,date }

class FormFieldConfig {
  final FieldType type;
  final String title;
  final List<String>? values;
  final Function(String?) onChange;
  final String? Function(String?)? validator;
  final String? value;
  final int? maxLength;
  final TextInputType? textInputType;
  final List<TextInputFormatter>?formatters;
  

  FormFieldConfig({
    required this.type,
    required this.title,
    this.maxLength, 
    this.values,
    required this.onChange,
    this.textInputType,
    this.formatters, 
    this.validator,
    this.value,
  });
}
