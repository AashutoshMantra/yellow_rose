import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/common_widgets/title_form_widget.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class TripNotesSheet extends StatefulWidget {
  final String title;
  final String buttonText;
  final bool isRequired;

  const TripNotesSheet({
    super.key,
    required this.title,
    required this.buttonText,
    this.isRequired = false,
  });

  @override
  State<TripNotesSheet> createState() => _TripNotesSheetState();
}

class _TripNotesSheetState extends State<TripNotesSheet> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(_notesController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetTitleWidget(title: widget.title),
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                TitleFormWidget(
                  text: widget.isRequired ? 'Notes *' : 'Notes',
                  child: CustomTextFormField(
                    cont: _notesController,
                    text: 'Add notes',
                    maxLines: 3,
                    type: TextInputType.multiline,
                    validator: (value) {
                      if (widget.isRequired &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Please enter notes';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: widget.buttonText,
                  onPressed: _submit,
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
