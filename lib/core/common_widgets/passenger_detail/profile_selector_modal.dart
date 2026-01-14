import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_booking_profile_extensions.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/searchable_traveler_dropdown.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/traveler_profile_tile.dart';

class ProfileSelectorModal extends StatefulWidget {
  final List<UserBookingProfile> profiles;
  final PassengerType? passengerType;
  final VoidCallback onAddNew;
  final SelectionMode mode;
  final bool multiSelect;
  final int? maxSelections;
  final List<String> selectedProfileIds;
  final Function(UserBookingProfile)? onProfileTap;

  const ProfileSelectorModal({
    super.key,
    required this.profiles,
    required this.onAddNew,
    required this.mode,
    required this.selectedProfileIds,
    this.passengerType,
    this.multiSelect = false,
    this.maxSelections,
    this.onProfileTap,
  });

  @override
  State<ProfileSelectorModal> createState() => _ProfileSelectorModalState();
}

class _ProfileSelectorModalState extends State<ProfileSelectorModal> {
  final TextEditingController _searchController = TextEditingController();
  List<UserBookingProfile> _filteredProfiles = [];
  late List<String> _localSelectedIds;

  @override
  void initState() {
    super.initState();
    _filteredProfiles = widget.profiles;
    _localSelectedIds = List.from(widget.selectedProfileIds);
    _searchController.addListener(_filterProfiles);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProfiles() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProfiles = widget.profiles;
      } else {
        _filteredProfiles = widget.profiles
            .where((profile) => profile.searchableText.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerTitle = widget.mode == SelectionMode.passenger
        ? "Select Traveler"
        : "Select Users";

    final headerSubtitle = widget.multiSelect && widget.maxSelections != null
        ? "${_localSelectedIds.length}/${widget.maxSelections} selected"
        : null;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(headerTitle, headerSubtitle),
          _buildSearchField(),
          Expanded(
            child: _filteredProfiles.isEmpty
                ? _buildEmptyState()
                : _buildProfileList(),
          ),
          _buildAddNewButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, String? subtitle) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primarySwatch[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.h6Style().copyWith(
                  color: AppColors.primary,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyles.bodySmallStyle().copyWith(
                    color: AppColors.primaryTextSwatch[600],
                  ),
                ),
              ],
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            color: AppColors.primaryTextSwatch[600],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primary,
          ),
          hintText: "Search by name, email, or phone...",
          hintStyle: TextStyles.bodySmallStyle().copyWith(
            color: AppColors.primaryTextSwatch[400],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primarySwatch[200]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppColors.primaryTextSwatch[50],
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      itemCount: _filteredProfiles.length,
      itemBuilder: (context, index) {
        final profile = _filteredProfiles[index];
        final profileId = profile.bookingProfileUuid ?? profile.userUid ?? '';
        final isSelected = _localSelectedIds.contains(profileId);

        return InkWell(
          onTap: () => _handleProfileTap(profile, isSelected),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            child: TravelerProfileTile(
              profile: profile,
              isSelected: isSelected,
            ),
          ),
        );
      },
    );
  }

  void _handleProfileTap(UserBookingProfile profile, bool isSelected) {
    if (widget.multiSelect) {
      final profileId = profile.bookingProfileUuid ?? profile.userUid ?? '';
      setState(() {
        if (isSelected) {
          _localSelectedIds.remove(profileId);
        } else {
          _localSelectedIds.add(profileId);
        }
      });
      widget.onProfileTap?.call(profile);
    } else {
      Navigator.pop(context, profile);
    }
  }

  Widget _buildAddNewButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.primarySwatch[200]!,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: widget.onAddNew,
          icon: const Icon(Icons.add),
          label: const Text("ADD NEW TRAVELER MANUALLY"),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 64,
            color: AppColors.primaryTextSwatch[300],
          ),
          SizedBox(height: 16.h),
          Text(
            "No profiles found",
            style: TextStyles.bodyLargeStyle().copyWith(
              color: AppColors.primaryTextSwatch[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Try a different search term",
            style: TextStyles.bodySmallStyle().copyWith(
              color: AppColors.primaryTextSwatch[400],
            ),
          ),
        ],
      ),
    );
  }
}
