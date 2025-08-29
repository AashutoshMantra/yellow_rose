import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/common_widgets/labelled_container.dart'
    show LabeledContainerField;
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class LabeledDropDownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;

  const LabeledDropDownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return LabeledContainerField(
      label: label,
      child: CustomDropDownField(
        data: items,
        onchange: onChanged,
        val: selectedValue,
      ),
    );
  }
}
