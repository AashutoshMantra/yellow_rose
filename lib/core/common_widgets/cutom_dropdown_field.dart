import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';

class CustomDropDownField extends StatelessWidget {
  List<String>? data;
  List<DropdownMenuItem<String>>? data1;
  String? hint;
  double? erroTextHeihgt;

  Function(String?)? onchange;
  Function(String?)? onSaved;
  String? Function(String?)? validator;
  String? val;
  bool showBorder;
  bool isEnabled;
  Color? fillColor;
  TextStyle? textStyle;
  GlobalKey<FormFieldState<dynamic>>? dropdownState;

  CustomDropDownField(
      {super.key,
      this.data,
      this.hint,
      this.onchange,
      this.textStyle,
      this.validator,
      this.dropdownState,
      this.fillColor,
      this.data1,
      this.val,
      this.onSaved,
      this.erroTextHeihgt,
      this.isEnabled = true,
      this.showBorder = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (7)),
      color: fillColor,
      child: DropdownButtonFormField(
        value: val,
        key: dropdownState,
        items: data1 ??
            data!
                .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textStyle ??
                                const TextStyle(color: AppColors.primaryText),
                          ),
                        ],
                      ),
                    ))
                .toList(),
        hint: hint != null ? Text(hint!) : null,
        onChanged: onchange,
        menuMaxHeight: MediaQuery.of(context).size.height * .5,
        validator: validator,
        isExpanded: true,
        onSaved: onSaved,
        decoration: InputDecoration(
          fillColor: fillColor,
          errorStyle: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: erroTextHeihgt ?? 16,
                  fontWeight: FontWeight.normal,
                  height: erroTextHeihgt)
              .copyWith(color: const Color.fromRGBO(255, 125, 125, 1)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: (7), vertical: 5),
          enabled: isEnabled,
          enabledBorder: OutlineInputBorder(
              borderSide: !showBorder
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.primary, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderSide: !showBorder
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.primary, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: !showBorder
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.primary, width: 1)),
          border: OutlineInputBorder(
            borderSide: !showBorder
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
    );
  }
}
