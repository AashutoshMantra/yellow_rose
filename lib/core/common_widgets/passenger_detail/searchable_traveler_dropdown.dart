import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_booking_profile_extensions.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_type.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/traveler_profile_tile.dart';

class SearchableTravelerDropdown extends StatelessWidget {
  final List<UserBookingProfile> profiles;
  final Function(PassengerDetailsEntity) onSelected;
  final VoidCallback onAddNew;
  final List<String>? excludeProfileIds;
  final PassengerType passengerType;

  const SearchableTravelerDropdown({
    super.key,
    required this.profiles,
    required this.onSelected,
    required this.onAddNew,
    required this.passengerType,
    this.excludeProfileIds,
  });

  List<UserBookingProfile> get _availableProfiles {
    var filtered = profiles;

    // Filter by passenger type age requirements
    filtered = filtered
        .where((profile) => profile.matchesPassengerType(passengerType))
        .toList();

    // Filter out already selected profiles
    if (excludeProfileIds != null && excludeProfileIds!.isNotEmpty) {
      filtered = filtered.where((profile) {
        final profileId = profile.bookingProfileUuid ?? profile.userUid;
        return !excludeProfileIds!.contains(profileId);
      }).toList();
    }

    return filtered;
  }

  Future<void> _showProfileSelector(BuildContext context) async {
    final selected = await showModalBottomSheet<UserBookingProfile>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ProfileSelectorModal(
        profiles: _availableProfiles,
        passengerType: passengerType,
        onAddNew: () {
          Navigator.pop(context);
          onAddNew();
        },
      ),
    );

    if (selected != null) {
      onSelected(
          selected.toPassengerDetailsEntity(passengerType: passengerType));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hide if no matching profiles available
    if (_availableProfiles.isEmpty) {
      return const SizedBox.shrink();
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
                "Select traveler from saved profiles...",
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

class _ProfileSelectorModal extends StatefulWidget {
  final List<UserBookingProfile> profiles;
  final PassengerType passengerType;
  final VoidCallback onAddNew;

  const _ProfileSelectorModal({
    required this.profiles,
    required this.passengerType,
    required this.onAddNew,
  });

  @override
  State<_ProfileSelectorModal> createState() => _ProfileSelectorModalState();
}

class _ProfileSelectorModalState extends State<_ProfileSelectorModal> {
  final TextEditingController _searchController = TextEditingController();
  List<UserBookingProfile> _filteredProfiles = [];

  @override
  void initState() {
    super.initState();
    _filteredProfiles = widget.profiles;
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
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
                Text(
                  "Select Traveler",
                  style: TextStyles.h6Style().copyWith(
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppColors.primaryTextSwatch[600],
                ),
              ],
            ),
          ),

          // Search field
          Padding(
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
          ),

          // Profile list
          Expanded(
            child: _filteredProfiles.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    itemCount: _filteredProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = _filteredProfiles[index];
                      return InkWell(
                        onTap: () => Navigator.pop(context, profile),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 8.w),
                          child: TravelerProfileTile(
                            profile: profile,
                            isSelected: false,
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Add new button
          Container(
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
          ),
        ],
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
