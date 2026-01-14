import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_booking_profile_extensions.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/profile_selector_modal.dart';

enum SelectionMode { passenger, profile }

class SearchableTravelerDropdown extends StatefulWidget {
  final List<UserBookingProfile> profiles;

  final Function(PassengerDetailsEntity)? onSelected;
  final PassengerType? passengerType;

  final Function(UserBookingProfile)? onProfileSelected;
  final bool multiSelect;
  final int? maxSelections;

  final VoidCallback onAddNew;
  final List<String>? excludeProfileIds;
  final SelectionMode mode;

  const SearchableTravelerDropdown({
    super.key,
    required this.profiles,
    required this.onAddNew,
    this.onSelected,
    this.passengerType,
    this.onProfileSelected,
    this.multiSelect = false,
    this.maxSelections,
    this.excludeProfileIds,
    this.mode = SelectionMode.passenger,
  }) : assert(
          mode == SelectionMode.passenger
              ? (onSelected != null && passengerType != null)
              : onProfileSelected != null,
          'For passenger mode, onSelected and passengerType are required. For profile mode, onProfileSelected is required.',
        );

  @override
  State<SearchableTravelerDropdown> createState() =>
      _SearchableTravelerDropdownState();
}

class _SearchableTravelerDropdownState
    extends State<SearchableTravelerDropdown> {
  late List<String> _currentSelectedIds;

  @override
  void initState() {
    super.initState();
    _currentSelectedIds = List.from(widget.excludeProfileIds ?? []);
  }

  @override
  void didUpdateWidget(SearchableTravelerDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update state when excludeProfileIds changes from parent
    if (widget.excludeProfileIds != oldWidget.excludeProfileIds) {
      _currentSelectedIds = List.from(widget.excludeProfileIds ?? []);
    }
  }

  List<UserBookingProfile> get _availableProfiles {
    var filtered = widget.profiles;

    if (widget.mode == SelectionMode.passenger &&
        widget.passengerType != null) {
      filtered = filtered
          .where(
              (profile) => profile.matchesPassengerType(widget.passengerType!))
          .toList();
    }

    if (_currentSelectedIds.isNotEmpty) {
      filtered = filtered.where((profile) {
        final profileId = profile.bookingProfileUuid ?? profile.userUid;
        return !_currentSelectedIds.contains(profileId);
      }).toList();
    }

    return filtered;
  }

  bool get _canSelectMore {
    if (!widget.multiSelect || widget.maxSelections == null) return true;
    return _currentSelectedIds.length < widget.maxSelections!;
  }

  Future<void> _showProfileSelector(BuildContext context) async {
    if (widget.multiSelect) {
      await WidgetUtil.showBottomSheet(
        context,
        ProfileSelectorModal(
          profiles: widget.profiles,
          passengerType: widget.passengerType,
          mode: widget.mode,
          multiSelect: widget.multiSelect,
          maxSelections: widget.maxSelections,
          selectedProfileIds: _currentSelectedIds,
          onProfileTap: _handleMultiSelectTap,
          onAddNew: () {
            Navigator.pop(context);
            widget.onAddNew();
          },
        ),
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      );
    } else {
      final selected = await WidgetUtil.showBottomSheet(
        context,
        ProfileSelectorModal(
          profiles: _availableProfiles,
          passengerType: widget.passengerType,
          mode: widget.mode,
          multiSelect: false,
          selectedProfileIds: const [],
          onAddNew: () {
            Navigator.pop(context);
            widget.onAddNew();
          },
        ),
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      );

      if (selected != null && selected is UserBookingProfile) {
        _handleSingleSelectTap(selected);
      }
    }
  }

  void _handleMultiSelectTap(UserBookingProfile profile) {
    final profileId = profile.bookingProfileUuid ?? profile.userUid ?? '';
    final isCurrentlySelected = _currentSelectedIds.contains(profileId);

    setState(() {
      if (isCurrentlySelected) {
        _currentSelectedIds.remove(profileId);
      } else {
        _currentSelectedIds.add(profileId);
      }
    });

    if (widget.mode == SelectionMode.profile &&
        widget.onProfileSelected != null) {
      widget.onProfileSelected!(profile);
    }
  }

  void _handleSingleSelectTap(UserBookingProfile profile) {
    if (widget.mode == SelectionMode.passenger &&
        widget.onSelected != null &&
        widget.passengerType != null) {
      widget.onSelected!(profile.toPassengerDetailsEntity(
          passengerType: widget.passengerType!));
    } else if (widget.mode == SelectionMode.profile &&
        widget.onProfileSelected != null) {
      widget.onProfileSelected!(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.multiSelect && _availableProfiles.isEmpty) {
      return const SizedBox.shrink();
    }

    if (widget.multiSelect && !_canSelectMore) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primarySwatch[200]!),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryTextSwatch[100],
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline,
                color: AppColors.primaryTextSwatch[400], size: 20),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                "Maximum ${widget.maxSelections} users selected",
                style: TextStyles.bodySmallStyle().copyWith(
                  color: AppColors.primaryTextSwatch[600],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () => _showProfileSelector(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primarySwatch[200]!),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryTextSwatch[50],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.primary, size: 20),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                widget.mode == SelectionMode.passenger
                    ? "Select traveler from saved profiles..."
                    : "Search users to add...",
                style: TextStyles.bodySmallStyle().copyWith(
                  color: AppColors.primaryTextSwatch[400],
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down,
                color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}
