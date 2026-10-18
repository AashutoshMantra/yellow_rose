import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/searchable_traveler_dropdown.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/common_widgets/selected_user_tags.dart';
import 'package:yellow_rose/core/common_widgets/title_form_widget.dart';
import 'package:yellow_rose/core/utils/common_utils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_detail.dart';
import 'package:yellow_rose/features/trip/data/models/trip_guest.dart';
import 'package:yellow_rose/features/trip/data/models/trip_rm_tag.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_detail_screen.dart';

class CreateTripBottomSheet extends StatefulWidget {
  final List<TripFor> allowedTripForOptions;

  const CreateTripBottomSheet({
    super.key,
    required this.allowedTripForOptions,
  });

  @override
  State<CreateTripBottomSheet> createState() => _CreateTripBottomSheetState();
}

class _CreateTripBottomSheetState extends State<CreateTripBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _buttonController = RoundedLoadingButtonController();
  final _tripNameController = TextEditingController();
  final _tripDescriptionController = TextEditingController();

  late TripFor _selectedTripFor;
  String? _selectedPurpose;
  final List<UserBookingProfile> _selectedUsers = [];

  BillingEntity? _selectedBillingEntity;
  String? _selectedPtcNptc;
  List<TripRmTag> _rmTags = [];
  final Map<String, TextEditingController> _rmControllers = {};
  final Map<String, String> _rmDropdownValues = {};

  final _guestFirstNameController = TextEditingController();
  final _guestLastNameController = TextEditingController();
  final _guestEmailController = TextEditingController();
  final _guestMobileController = TextEditingController();
  final _guestOrganizationController = TextEditingController();
  final _guestJustificationController = TextEditingController();
  String _guestTitle = 'Mr';

  final List<String> _ptcNptcOptions = ['PTC', 'NPTC'];
  final List<String> _guestTitleOptions = ['Mr', 'Ms', 'Mrs'];

  final List<String> _purposeOptions = [
    'Meeting',
    'Training',
    'Customer Visit',
    'Conference',
    'Other'
  ];

  final int _maxOnBehalfOfUsers = 10; // Maximum users for on behalf of

  List<UserBookingProfile> get _allProfiles {
    return context.read<AuthCubit>().allProfiles;
  }

  bool _isPolicyEnabled(String code) {
    return context
        .read<AuthCubit>()
        .corporatePolicies
        .isBoolPolicyEnabled(code);
  }

  bool get _isBillingEnabled => _isPolicyEnabled('enable-trip-billing');
  bool get _isRmTagsEnabled => _isPolicyEnabled('enable-trip-rmtags');
  bool get _isPtcNptcEnabled =>
      _isPolicyEnabled('enable-ptc-nptc-approval-policy');

  List<BillingEntity> get _billingEntities {
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      return authState.billingEntities;
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    _selectedTripFor = widget.allowedTripForOptions.first;
    if (_isRmTagsEnabled) {
      _loadRmTags();
    }
  }

  @override
  void dispose() {
    _tripNameController.dispose();
    _tripDescriptionController.dispose();
    for (final controller in _rmControllers.values) {
      controller.dispose();
    }
    _guestFirstNameController.dispose();
    _guestLastNameController.dispose();
    _guestEmailController.dispose();
    _guestMobileController.dispose();
    _guestOrganizationController.dispose();
    _guestJustificationController.dispose();
    super.dispose();
  }

  Future<void> _loadRmTags() async {
    final authCubit = context.read<AuthCubit>();
    final tripCubit = context.read<TripCubit>();
    final userUid = authCubit.userProfile?.userUid;
    if (userUid == null) return;

    try {
      final tags = await tripCubit.getRmTags(userUid);
      if (!mounted) return;
      setState(() {
        _rmTags = tags;
        for (final tag in tags) {
          final name = tag.tagName ?? '';
          final fixedValue = _resolveFixedValue(tag.tagFixedValue);
          if (tag.fieldType == 'D') {
            if (fixedValue.isNotEmpty) _rmDropdownValues[name] = fixedValue;
          } else {
            _rmControllers[name] = TextEditingController(text: fixedValue);
          }
        }
      });
    } catch (e, s) {
      log("$e $s");
    }
  }

  String _resolveFixedValue(String? fixedValue) {
    if (fixedValue == null || fixedValue.isEmpty) return '';
    if (!fixedValue.startsWith(':')) return fixedValue;

    final profile = context.read<AuthCubit>().userProfile;
    switch (fixedValue.substring(1).toLowerCase()) {
      case 'band':
        return profile?.band ?? '';
      case 'department':
        return profile?.department ?? '';
      case 'designation':
        return profile?.designation ?? '';
      case 'location':
        return profile?.location ?? '';
      case 'division':
        return profile?.division ?? '';
      default:
        return '';
    }
  }

  String _rmTagValue(TripRmTag tag) {
    final name = tag.tagName ?? '';
    if (tag.fieldType == 'D') return _rmDropdownValues[name] ?? '';
    return _rmControllers[name]?.text.trim() ?? '';
  }

  bool get _isGuestTrip => _selectedTripFor == TripFor.NonEmployee;

  Future<void> _createTrip() async {
    if (!_formKey.currentState!.validate()) {
      _buttonController.reset();
      return;
    }

    // Validate on behalf of selection
    if (_selectedTripFor == TripFor.OnBehalfOf && _selectedUsers.isEmpty) {
      _buttonController.reset();
      WidgetUtil.showSnackBar(
        'Please select at least one user for "On Behalf Of"',
        context,
      );
      return;
    }

    if (_isBillingEnabled && _selectedBillingEntity == null) {
      _buttonController.reset();
      WidgetUtil.showSnackBar('Please select billing entity', context);
      return;
    }

    for (final tag in _rmTags) {
      if (tag.isMandatory && tag.fieldType != 'F' && _rmTagValue(tag).isEmpty) {
        _buttonController.reset();
        WidgetUtil.showSnackBar(
            'Please enter ${tag.tagDisplayName ?? tag.tagName}', context);
        return;
      }
    }

    final request = TripCreateRequest(
      tripName: _tripNameController.text.trim(),
      tripDescription: _tripDescriptionController.text.trim(),
      tripFor: _selectedTripFor,
      tripPurpose: _selectedPurpose,
      tripDetails: _selectedTripFor == TripFor.OnBehalfOf
          ? TripDetail(
              onBehalf: _selectedUsers
                  .map((u) => u.userUid ?? '')
                  .where((id) => id.isNotEmpty)
                  .toList(),
            )
          : null,
      billingEntity:
          _isBillingEnabled ? _selectedBillingEntity?.entityRefId : null,
      ptcNptcType: _isPtcNptcEnabled ? _selectedPtcNptc : null,
      rmTags: _isRmTagsEnabled && _rmTags.isNotEmpty
          ? _rmTags
              .where((tag) => tag.fieldType != 'F')
              .map((tag) => tag.copyWith(value: _rmTagValue(tag)))
              .toList()
          : null,
      otherList: _isGuestTrip
          ? [
              TripGuest(
                title: _guestTitle,
                firstName: _guestFirstNameController.text.trim(),
                lastName: _guestLastNameController.text.trim(),
                email: _guestEmailController.text.trim(),
                mobile: _guestMobileController.text.trim(),
                passengerType: 'ADT',
                justification: _guestJustificationController.text.trim(),
                organization: _guestOrganizationController.text.trim(),
                isGov: false,
              ),
            ]
          : null,
    );

    try {
      var createdTrip = await context.read<TripCubit>().createTrip(request);
      _buttonController.successReset();
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            Navigator.of(context).pop();
            Navigator.pushNamed(
              context,
              TripDetailScreen.routeName,
              arguments: {'trip': createdTrip, "isTeamTrips": false},
            );
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

  Widget _buildBillingField() {
    return TitleFormWidget(
      text: 'Billing Entity *',
      child: CustomDropDownField(
        hint: 'Select Billing Entity',
        val: _selectedBillingEntity?.entityName,
        data: _billingEntities.map((e) => e.entityName ?? '').toList(),
        onchange: (value) {
          setState(() {
            _selectedBillingEntity = _billingEntities.firstWhere(
              (e) => e.entityName?.equalsIgnoreCase(value ?? '') == true,
              orElse: () => _billingEntities.first,
            );
          });
        },
        validator: (_) {
          if (_selectedBillingEntity == null) {
            return 'Please select billing entity';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPtcNptcField() {
    return TitleFormWidget(
      text: 'PTC / NPTC *',
      child: CustomDropDownField(
        hint: 'Select PTC / NPTC',
        val: _selectedPtcNptc,
        data: _ptcNptcOptions,
        onchange: (value) {
          setState(() {
            _selectedPtcNptc = value;
          });
        },
        validator: (_) {
          if (_selectedPtcNptc == null || _selectedPtcNptc!.isEmpty) {
            return 'Please select PTC / NPTC';
          }
          return null;
        },
      ),
    );
  }

  List<Widget> _buildRmTagFields() {
    return _rmTags.where((tag) => tag.fieldType != 'F').map((tag) {
      final name = tag.tagName ?? '';
      final label = (tag.tagDisplayName ?? '').isNotEmpty
          ? tag.tagDisplayName!
          : name;
      final title = tag.isMandatory ? '$label *' : label;

      if (tag.fieldType == 'D') {
        return TitleFormWidget(
          text: title,
          child: CustomDropDownField(
            hint: 'Select $label',
            val: _rmDropdownValues[name],
            data: tag.options,
            onchange: (value) {
              setState(() {
                _rmDropdownValues[name] = value ?? '';
              });
            },
            validator: (_) {
              if (tag.isMandatory && (_rmDropdownValues[name] ?? '').isEmpty) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        );
      }

      return TitleFormWidget(
        text: title,
        child: CustomTextFormField(
          cont: _rmControllers[name],
          text: label,
          type: TextInputType.text,
          validator: (value) {
            if (tag.isMandatory && (value == null || value.trim().isEmpty)) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      );
    }).toList();
  }

  List<Widget> _buildGuestFields() {
    return [
      TitleFormWidget(
        text: 'Guest Title *',
        child: CustomDropDownField(
          hint: 'Select Title',
          val: _guestTitle,
          data: _guestTitleOptions,
          onchange: (value) {
            setState(() {
              _guestTitle = value ?? 'Mr';
            });
          },
        ),
      ),
      TitleFormWidget(
        text: 'Guest First Name *',
        child: CustomTextFormField(
          cont: _guestFirstNameController,
          text: 'First Name',
          type: TextInputType.name,
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Please enter first name'
              : null,
        ),
      ),
      TitleFormWidget(
        text: 'Guest Last Name *',
        child: CustomTextFormField(
          cont: _guestLastNameController,
          text: 'Last Name',
          type: TextInputType.name,
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Please enter last name'
              : null,
        ),
      ),
      TitleFormWidget(
        text: 'Guest Email *',
        child: CustomTextFormField(
          cont: _guestEmailController,
          text: 'Email',
          type: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter email';
            }
            if (!Utils.emailRegex.hasMatch(value.trim())) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ),
      TitleFormWidget(
        text: 'Guest Mobile *',
        child: CustomTextFormField(
          cont: _guestMobileController,
          text: 'Mobile',
          type: TextInputType.phone,
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Please enter mobile'
              : null,
        ),
      ),
      TitleFormWidget(
        text: 'Organization',
        child: CustomTextFormField(
          cont: _guestOrganizationController,
          text: 'Organization',
          type: TextInputType.text,
        ),
      ),
      TitleFormWidget(
        text: 'Justification',
        child: CustomTextFormField(
          cont: _guestJustificationController,
          text: 'Justification',
          type: TextInputType.text,
          maxLines: 2,
        ),
      ),
    ];
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
          Form(
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
                  TitleFormWidget(
                    text: 'Trip For *',
                    child: Container(
                      margin: EdgeInsets.only(top: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:
                                widget.allowedTripForOptions.map((tripFor) {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6.h),
                                  child: PillButton(
                                    text: tripFor.value,
                                    pillType: _selectedTripFor == tripFor
                                        ? PillType.primary
                                        : PillType.secondary,
                                    onClick: () {
                                      setState(() {
                                        _selectedTripFor = tripFor;
                                        if (tripFor != TripFor.OnBehalfOf) {
                                          _selectedUsers.clear();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          if (_selectedTripFor == TripFor.OnBehalfOf) ...[
                            SizedBox(height: 12.h),
                            SearchableTravelerDropdown(
                              profiles: _allProfiles,
                              mode: SelectionMode.profile,
                              multiSelect: true,
                              maxSelections: _maxOnBehalfOfUsers,
                              excludeProfileIds: _selectedUsers
                                  .map((u) =>
                                      u.bookingProfileUuid ?? u.userUid ?? '')
                                  .toList(),
                              onProfileSelected: (profile) {
                                setState(() {
                                  final profileId =
                                      profile.bookingProfileUuid ??
                                          profile.userUid ??
                                          '';
                                  final existingIndex =
                                      _selectedUsers.indexWhere((u) =>
                                          (u.bookingProfileUuid ??
                                              u.userUid ??
                                              '') ==
                                          profileId);
                                  if (existingIndex != -1) {
                                    _selectedUsers.removeAt(existingIndex);
                                  } else {
                                    _selectedUsers.add(profile);
                                  }
                                });
                              },
                              onAddNew: () {
                                // Not applicable for user selection
                              },
                            ),
                            if (_selectedUsers.isNotEmpty) ...[
                              SizedBox(height: 12.h),
                              SelectedUserTags(
                                selectedUsers: _selectedUsers,
                                onRemove: (user) {
                                  setState(() {
                                    _selectedUsers.remove(user);
                                  });
                                },
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_isGuestTrip) ..._buildGuestFields(),
                  if (_isBillingEnabled) _buildBillingField(),
                  if (_isPtcNptcEnabled) _buildPtcNptcField(),
                  if (_isRmTagsEnabled) ..._buildRmTagFields(),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: 'Create Trip',
                    buttonController: _buttonController,
                    onPressed: _createTrip,
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
