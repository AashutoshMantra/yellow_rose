import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/common_widgets/title_form_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/common_utils.dart';
import 'package:yellow_rose/core/utils/form_filed_config.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/gender.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_title.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/passenger_detail_form/passenger_detail_form_cubit.dart';

class AddUpdatePassengerDetailsScreen extends StatefulWidget {
  final PassengerDetailsEntity? passengerDetailsEntity;
  final PassengerType passengerType;

  const AddUpdatePassengerDetailsScreen(
      {super.key, this.passengerDetailsEntity, required this.passengerType});

  @override
  State<AddUpdatePassengerDetailsScreen> createState() =>
      _AddUpdatePassengerDetailsScreenState();
}

class _AddUpdatePassengerDetailsScreenState
    extends State<AddUpdatePassengerDetailsScreen> {
  final _fromKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _scrollController = ScrollController();
  List<FormFieldConfig> getUiConfig(BuildContext context) {
    var uiConfig = [
      FormFieldConfig(
          type: FieldType.dropdown,
          title: 'Title',
          values: PassengerTitle.values.map((d) => d.name).toList(),
          onChange: (value) {
            context.read<PassengerDetailFormCubit>().onTitleChange(value);
          },
          value: context.read<PassengerDetailFormCubit>().state.title.name),
      FormFieldConfig(
          type: FieldType.text,
          title: 'Name',
          onChange: (value) {
            context.read<PassengerDetailFormCubit>().onNameChange(value);
          },
          validator: (value) {
            var state = context.read<PassengerDetailFormCubit>().state;
            if (state.name == null || state.name!.isEmpty) {
              return "Please enter name";
            }
            return null;
          },
          value: context.read<PassengerDetailFormCubit>().state.name),
      FormFieldConfig(
          type: FieldType.text,
          title: 'Last Name',
          onChange: (value) {
            context.read<PassengerDetailFormCubit>().onLastNameChange(value);
          },
          validator: (value) {
            var state = context.read<PassengerDetailFormCubit>().state;
            if (state.lastName == null || state.lastName!.isEmpty) {
              return "Please enter last name";
            }
            return null;
          },
          value: context.read<PassengerDetailFormCubit>().state.lastName),
      FormFieldConfig(
          type: FieldType.text,
          title: 'Email',
          onChange: (value) {
            context.read<PassengerDetailFormCubit>().onEmailChange(value);
          },
          validator: (value) {
            var state = context.read<PassengerDetailFormCubit>().state;
            if (state.email == null ||
                !Utils.emailRegex.hasMatch(state.email!)) {
              return "Please enter valid email";
            }
            return null;
          },
          value: context.read<PassengerDetailFormCubit>().state.email),
      FormFieldConfig(
          type: FieldType.text,
          title: 'Phone Number',
          maxLength: 10,
          onChange: (value) {
            context.read<PassengerDetailFormCubit>().onPhoneNumberChange(value);
          },
          textInputType: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            var state = context.read<PassengerDetailFormCubit>().state;
            if (state.phoneNumber == null ||
                state.phoneNumber!.isEmpty ||
                state.phoneNumber!.length < 10) {
              return "Please enter valid phone number";
            }
            return null;
          },
          value: context.read<PassengerDetailFormCubit>().state.phoneNumber),
    ];
    if (!widget.passengerType.isAdult()) {
      uiConfig.add(
        FormFieldConfig(
            type: FieldType.date,
            title: 'Date Of Birth',
            onChange: (value) {
              context.read<PassengerDetailFormCubit>().onDobChange(value);
            },
            validator: (value) {
              var state = context.read<PassengerDetailFormCubit>().state;
              if (state.dob == null) {
                return "Please select Date of birth";
              }
              return null;
            },
            value: context.read<PassengerDetailFormCubit>().state.dob != null
                ? DateFormat('dd/MM/yyyy')
                    .format(context.read<PassengerDetailFormCubit>().state.dob!)
                : 'dd/MM/yyyy'),
      );
    }
    return uiConfig;
  }

  DateTime today = DateTime.now();

  DateTime getFirstDate(PassengerType passengerType) {
    if (passengerType.isChild()) {
      return today.subtract(const Duration(days: 12 * 365)); // 12 years ago
    } else if (passengerType.isInfant()) {
      return today.subtract(const Duration(days: 2 * 365)); // 2 years ago
    }
    return today
        .subtract(const Duration(days: 100 * 365)); // Default for adults
  }

  _selectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          BlocProvider.of<PassengerDetailFormCubit>(context).state.dob ??
              DateTime.now(),
      firstDate: getFirstDate(widget.passengerType),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      context.read<PassengerDetailFormCubit>().onDobChange(picked.toString());
    }
    Future.delayed(const Duration(milliseconds: 0), () {
      if (_autoValidate) {
        _fromKey.currentState?.validate();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PassengerDetailFormCubit(
          passengerDetailsEntity: widget.passengerDetailsEntity,
          passengerType: widget.passengerType),
      child: BlocBuilder<PassengerDetailFormCubit, PassengerDetailFormState>(
        builder: (context, state) {
          return Form(
            key: _fromKey,
            autovalidateMode:
                _autoValidate ? AutovalidateMode.onUserInteraction : null,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .85,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Add Traveler details",
                              textAlign: TextAlign.center,
                              style: TextStyles.bodyXLargeMediumStyle(),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      Divider(
                        height: 0,
                        color: AppColors.primaryTextSwatch[200],
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 24.h),
                          child: ListView(
                            controller: _scrollController,
                            children: [
                              Row(
                                children: Gender.values.map((gender) {
                                  return Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.h),
                                      child: PillButton(
                                        text: gender.name,
                                        pillType: state.gender == gender
                                            ? PillType.primary
                                            : PillType.secondary,
                                        onClick: () {
                                          context
                                              .read<PassengerDetailFormCubit>()
                                              .onGenderChange(gender);
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              ...getUiConfig(context).map((config) {
                                if (config.type == FieldType.text) {
                                  return TitleFormWidget(
                                    text: config.title,
                                    child: CustomTextFormField(
                                      maxlenght: config.maxLength,
                                      initvalue: config.value,
                                      text: config.title,
                                      type: config.textInputType,
                                      formatters: config.formatters,
                                      validator: config.validator,
                                      onchange: config.onChange,
                                    ),
                                  );
                                }
                                if (config.type == FieldType.date) {
                                  return TitleFormWidget(
                                    text: config.title,
                                    child: GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: CustomTextFormField(
                                          enabled: false,
                                          showColoredDisabled: true,
                                          suffixicon: const Icon(
                                            Icons.calendar_month,
                                            color: AppColors.primary,
                                          ),
                                          initvalue: config.value,
                                          validator: config.validator,
                                        )),
                                  );
                                }
                                return TitleFormWidget(
                                  text: config.title,
                                  child: CustomDropDownField(
                                    validator: config.validator,
                                    onchange: config.onChange,
                                    data: config.values,
                                    val: config.value,
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 100.h,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: AppColors.primarySwatch[100],
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: CustomButton(
                        text: "Confirm",
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {
                            var detalis = context
                                .read<PassengerDetailFormCubit>()
                                .getPassengerDetails();
                            Navigator.of(context).pop(detalis);
                          } else {
                            if (state.dob == null) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent +
                                      100,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.decelerate);
                            }
                            setState(() {
                              _autoValidate = true;
                            });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
