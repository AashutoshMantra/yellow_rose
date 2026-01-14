import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/chip_button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_booking_profile_extensions.dart';

class SelectedUserTags extends StatelessWidget {
  final List<UserBookingProfile> selectedUsers;
  final Function(UserBookingProfile) onRemove;

  const SelectedUserTags({
    super.key,
    required this.selectedUsers,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedUsers.isEmpty) {
      return const SizedBox.shrink();
    }

    final shouldScroll = selectedUsers.length > 4;
    final maxHeight = shouldScroll ? 160.h : null;

    return Container(
      constraints:
          maxHeight != null ? BoxConstraints(maxHeight: maxHeight) : null,
      child: SingleChildScrollView(
        physics: shouldScroll
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 3,
          ),
          itemCount: selectedUsers.length,
          itemBuilder: (context, index) {
            final user = selectedUsers[index];
            return ChipButton(
              text: user.displayName,
              chipType: ChipType.primary,
              leadingIcon: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 16.h,
                  color: AppColors.primary,
                ),
              ),
              onRemove: () => onRemove(user),
            );
          },
        ),
      ),
    );
  }
}
