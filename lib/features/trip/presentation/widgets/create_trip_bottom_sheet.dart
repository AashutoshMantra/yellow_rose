import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/common_widgets/title_form_widget.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class CreateTripBottomSheet extends StatefulWidget {
  const CreateTripBottomSheet({super.key});

  @override
  State<CreateTripBottomSheet> createState() => _CreateTripBottomSheetState();
}

class _CreateTripBottomSheetState extends State<CreateTripBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _buttonController = RoundedLoadingButtonController();
  final _tripNameController = TextEditingController();
  final _tripDescriptionController = TextEditingController();

  String? _selectedTripFor;
  String? _selectedPurpose;

  final List<String> _purposeOptions = [
    'Meeting',
    'Training',
    'Customer Visit',
    'Conference',
    'Other'
  ];

  @override
  void dispose() {
    _tripNameController.dispose();
    _tripDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _createTrip() async {
    if (!_formKey.currentState!.validate()) {
      _buttonController.reset();
      return;
    }

    final request = TripCreateRequest(
      tripName: _tripNameController.text.trim(),
      tripDescription: _tripDescriptionController.text.trim(),
      tripFor: _selectedTripFor,
      tripPurpose: _selectedPurpose,
    );

    try {
      await context.read<TripCubit>().createTrip(request);
      _buttonController.successReset();
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      }
    } catch (e) {
      _buttonController.errorReset();
      if (mounted) {
        WidgetUtil.showSnackBar(
          'Failed to create trip. Please try again.',
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const BottomSheetTitleWidget(
            title: 'Create Trip',
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    TitleFormWidget(
                      text: 'Trip Name *',
                      child: CustomTextFormField(
                        cont: _tripNameController,
                        text: 'Trip Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Trip name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    TitleFormWidget(
                      text: 'Description',
                      child: CustomTextFormField(
                        cont: _tripDescriptionController,
                        text: 'Description',
                        maxLines: 2,
                      ),
                    ),
                    TitleFormWidget(
                      text: 'Purpose',
                      child: CustomDropDownField(
                        hint: 'Select Purpose',
                        val: _selectedPurpose,
                        data: _purposeOptions,
                        validator: (_) {
                          if (_selectedPurpose == null ||
                              _selectedPurpose!.isEmpty) {
                            return 'Please select a purpose';
                          }
                          return null;
                        },
                        onchange: (value) {
                          setState(() {
                            _selectedPurpose = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      text: 'Create Trip',
                      buttonController: _buttonController,
                      onPressed: _createTrip,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
