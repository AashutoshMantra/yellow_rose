import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';

class TravelerProfileTile extends StatelessWidget {
  final UserBookingProfile profile;
  final bool isSelected;

  const TravelerProfileTile({
    super.key,
    required this.profile,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color:
            isSelected ? AppColors.primaryGreen.withOpacity(0.1) : Colors.white,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryGreen
              : AppColors.primarySwatch[200]!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Avatar icon with checkmark overlay for selected profiles
          Stack(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primarySwatch[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getGenderIcon(),
                  color: AppColors.primary,
                  size: 20.w,
                ),
              ),
              if (isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10.w,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),

          // Profile details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  "${profile.firstName ?? ""} ${profile.lastName ?? " "}"
                      .trim(),
                  style: TextStyles.bodyLargeSemiBoldStyle().copyWith(
                    color: AppColors.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Gender and Email
                Row(
                  children: [
                    Text(
                      _getGenderText(),
                      style: TextStyles.bodySmallStyle().copyWith(
                        color: AppColors.primaryTextSwatch[600],
                      ),
                    ),
                    if (profile.email != null && profile.email!.isNotEmpty) ...[
                      Text(
                        ' • ',
                        style: TextStyles.bodySmallStyle().copyWith(
                          color: AppColors.primaryTextSwatch[600],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          profile.email!,
                          style: TextStyles.bodySmallStyle().copyWith(
                            color: AppColors.primaryTextSwatch[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),

                // Phone
                if (profile.primaryPhone != null ||
                    profile.contactNumber != null) ...[
                  Text(
                    '📞 ${profile.primaryPhone ?? profile.contactNumber}',
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: AppColors.primaryTextSwatch[600],
                    ),
                  ),
                ],

                // Department (optional)
                if (profile.department != null &&
                    profile.department!.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '🏢 ${profile.department}${profile.designation != null ? ' | ${profile.designation}' : ''}',
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: AppColors.primaryTextSwatch[400],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // Selection indicator
          if (isSelected) ...[
            SizedBox(width: 8.w),
            Icon(
              Icons.check_circle,
              color: AppColors.primaryGreen,
              size: 20.w,
            ),
          ],
        ],
      ),
    );
  }

  IconData _getGenderIcon() {
    switch (profile.gender?.toLowerCase()) {
      case 'female':
      case 'f':
        return Icons.person;
      case 'male':
      case 'm':
      default:
        return Icons.person;
    }
  }

  String _getGenderText() {
    switch (profile.gender?.toLowerCase()) {
      case 'female':
      case 'f':
        return 'Female';
      case 'male':
      case 'm':
        return 'Male';
      default:
        return 'N/A';
    }
  }
}
