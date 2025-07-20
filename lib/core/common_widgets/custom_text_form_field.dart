import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  String? text;
  dynamic icon;
  Function(String?)? onsave;
  String? Function(String?)? validator;
  Color? fillColor;
  Widget? suffixicon;
  TextEditingController? cont;
  GlobalKey<FormFieldState>? formKey;
  List<TextInputFormatter>? formatters;
  bool? obs;
  bool? enabled;
  Function(String)? onFieldSubmitted;
  TextInputType? type;
  String? initvalue;
  int? maxlenght;
  Function(String?)? onchange;
  Color focusColor;
  Color focusBorder;
  FocusNode? focusNode;
  bool? showColoredDisabled;
  int? maxLines;
  bool? expands;
  String? errorText;
  bool showBorder;
  double? erroTextHeihgt;
  Color? disableColor;
  String? helperText;
  double? helperTextSize;
  CustomTextFormField(
      {super.key,
      this.text,
      this.icon,
      this.onsave,
      this.validator,
      this.suffixicon,
      this.fillColor,
      this.type,
      this.cont,
      this.focusNode,
      this.obs,
      this.enabled,
      this.initvalue,
      this.onFieldSubmitted,
      this.disableColor,
      this.formKey,
      this.errorText,
      this.maxlenght,
      this.erroTextHeihgt,
      this.showBorder = true,
      this.focusColor = Colors.white,
      this.focusBorder = const Color.fromRGBO(154, 154, 154, 1),
      this.onchange,
      this.formatters,
      this.expands,
      this.maxLines,
      this.helperText,
      this.helperTextSize,
      this.showColoredDisabled});

  @override
  State<CustomTextFormField> createState() => CustomFormFieldState();
}

class CustomFormFieldState extends State<CustomTextFormField> {
  final bool _validated = true;

  final _formKeyfield = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (7)),
      child: Focus(
        debugLabel: widget.text ?? "sds",
        child: Builder(builder: (context) {
          return TextFormField(
              maxLines: widget.maxLines,
              expands: widget.expands ?? false,
              key: _formKeyfield,
              focusNode: widget.focusNode,
              onChanged: (val) {
                if (widget.onchange != null) {
                  widget.onchange!(val);
                }
              },
              maxLength: widget.maxlenght,
              readOnly: widget.enabled == false ? true : false,
              initialValue: widget.initvalue,
              enabled: widget.enabled,
              textInputAction: TextInputAction.done,
              controller: widget.cont,
              onTap: () {
                Scrollable.ensureVisible(
                  _formKeyfield.currentContext!,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.decelerate,
                );
              },
              obscureText: widget.obs ?? false,
              inputFormatters: widget.formatters,
              style: TextStyles.bodyMediumMediumStyle()
                  .copyWith(color: !_validated ? AppColors.error : null),
              keyboardType: widget.type ?? TextInputType.emailAddress,
              decoration: InputDecoration(
                errorMaxLines: 4,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5),

                errorText: widget.errorText,
                fillColor: widget.fillColor,
                filled: widget.fillColor != null,
                errorStyle: TextStyles.bodySmallSemiBoldStyle().copyWith(
                    color: AppColors.error,
                    fontSize: widget.erroTextHeihgt,
                    height: widget.erroTextHeihgt),
                helperText: widget.helperText,
                helperStyle: TextStyles.bodyMediumMediumStyle()
                    .copyWith(color: AppColors.primaryTextSwatch[500]),

                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primarySwatch[500]!),
                  borderRadius: BorderRadius.circular((10)),
                ),

                enabledBorder: OutlineInputBorder(
                    borderSide: widget.showBorder
                        ? BorderSide(
                            color: AppColors.primaryTextSwatch[200]!, width: 1)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular((10))),
                disabledBorder: widget.showColoredDisabled == true
                    ? OutlineInputBorder(
                        borderSide: widget.showBorder
                            ? BorderSide(
                                color: AppColors.primaryTextSwatch[100]!,
                                width: 1)
                            : BorderSide.none,
                        borderRadius: BorderRadius.circular((5)))
                    : null,
                border: OutlineInputBorder(
                  borderSide: widget.showBorder
                      ? BorderSide(
                          color: AppColors.primaryTextSwatch[200]!, width: 1)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    (5),
                  ),
                ),

                hintText: widget.text, //'E-Mail
                hintStyle: TextStyles.bodyMediumMediumStyle()
                    .copyWith(color: AppColors.primaryTextSwatch[500]),

                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color:
                            (widget.enabled == null || widget.enabled == true)
                                ? AppColors.primaryText
                                : Colors.black12,
                      )
                    : null,
                suffixIcon: !_validated
                    ? const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                      )
                    : widget.suffixicon != null
                        ? Container(
                            margin: const EdgeInsets.only(right: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.suffixicon!,
                              ],
                            ),
                          )
                        : null,

                labelStyle: const TextStyle(
                    color: Color.fromRGBO(94, 94, 94, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              onFieldSubmitted: widget.onFieldSubmitted,
              onSaved: widget.onsave, //(value) => _email = value!,
              validator: widget.validator);
        }),
      ),
    );
  }
}
