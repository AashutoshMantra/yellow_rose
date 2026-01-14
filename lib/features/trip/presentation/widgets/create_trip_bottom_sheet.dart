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
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_detail.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_detail_screen.dart';

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

  TripFor _selectedTripFor = TripFor.Self;
  String? _selectedPurpose;
  final List<UserBookingProfile> _selectedUsers = [];

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

    // Validate on behalf of selection
    if (_selectedTripFor == TripFor.OnBehalfOf && _selectedUsers.isEmpty) {
      _buttonController.reset();
      WidgetUtil.showSnackBar(
        'Please select at least one user for "On Behalf Of"',
        context,
      );
      return;
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
                            children: TripFor.values.map((tripFor) {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6.h),
                                  child: PillButton(
                                    text: tripFor == TripFor.Self
                                        ? 'Self'
                                        : 'On Behalf Of',
                                    pillType: _selectedTripFor == tripFor
                                        ? PillType.primary
                                        : PillType.secondary,
                                    onClick: () {
                                      setState(() {
                                        _selectedTripFor = tripFor;
                                        if (tripFor == TripFor.Self) {
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
