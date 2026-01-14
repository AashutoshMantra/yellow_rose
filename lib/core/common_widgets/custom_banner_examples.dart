import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/custom_banner.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

/// Example implementations of the CustomBanner widget showing its versatility
class CustomBannerExamplesScreen extends StatelessWidget {
  const CustomBannerExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Banner Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Predefined Types'),

            // Info banner
            const CustomBanner(
              message: "This is an information banner with default styling",
              type: BannerType.info,
            ),
            SizedBox(height: 8.h),

            // Warning banner
            const CustomBanner(
              message: "Warning! Please check your details before proceeding",
              type: BannerType.warning,
            ),
            SizedBox(height: 8.h),

            // Error banner
            const CustomBanner(
              message: "Error: Failed to process your request",
              type: BannerType.error,
            ),
            SizedBox(height: 8.h),

            // Success banner
            const CustomBanner(
              message: "Success! Your booking has been confirmed",
              type: BannerType.success,
            ),
            SizedBox(height: 16.h),

            _buildSectionTitle('Customized Banners'),

            // Trip constraint banner (your original use case)
            CustomBanner(
              message: "Trip is for self - only 1 adult allowed",
              type: BannerType.info,
              icon: Icons.lock,
              backgroundColor: AppColors.primaryTextSwatch[50],
              borderColor: AppColors.primary,
              iconColor: AppColors.primary,
            ),
            SizedBox(height: 8.h),

            // Custom banner with no border
            CustomBanner(
              message: "Custom banner without border",
              type: BannerType.custom,
              showBorder: false,
              backgroundColor: Colors.blue[50],
              textColor: Colors.blue[800],
              iconColor: Colors.blue,
            ),
            SizedBox(height: 8.h),

            // Banner with custom icon
            CustomBanner(
              message: "Flight departure in 2 hours",
              type: BannerType.info,
              icon: Icons.flight_takeoff,
              backgroundColor: Colors.lightBlue[50],
              borderColor: Colors.lightBlue[200],
              textColor: Colors.lightBlue[800],
            ),
            SizedBox(height: 8.h),

            // Banner with trailing action
            CustomBanner(
              message: "Update available for your app",
              type: BannerType.info,
              trailing: TextButton(
                onPressed: () {},
                child: Text("Update", style: TextStyles.bodySmallMediumStyle()),
              ),
            ),
            SizedBox(height: 16.h),

            _buildSectionTitle('Interactive Banners'),

            // Clickable banner
            CustomBanner(
              message: "Tap to view more details about your trip",
              type: BannerType.info,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Banner tapped!')),
                );
              },
            ),
            SizedBox(height: 8.h),

            // Banner with custom content
            CustomBanner(
              message: "", // Empty message when using custom content
              type: BannerType.custom,
              customContent: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Updated",
                          style: TextStyles.bodyMediumSemiBoldStyle(),
                        ),
                        Text(
                          "Your profile information has been saved successfully",
                          style: TextStyles.bodySmallStyle(),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.close, color: AppColors.primaryTextSwatch[600]),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            _buildSectionTitle('Size & Padding Variants'),

            // Compact banner
            CustomBanner(
              message: "Compact banner with minimal padding",
              type: BannerType.info,
              padding: EdgeInsets.all(8.h),
              iconSize: 16,
              textStyle: TextStyles.bodySmallStyle(),
            ),
            SizedBox(height: 8.h),

            // Large banner
            CustomBanner(
              message: "Large banner with extra padding and bigger icon",
              type: BannerType.warning,
              padding: EdgeInsets.all(16.h),
              iconSize: 28,
              textStyle: TextStyles.bodyMediumSemiBoldStyle(),
              borderRadius: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 8.h),
      child: Text(
        title,
        style: TextStyles.bodyMediumSemiBoldStyle(),
      ),
    );
  }
}
