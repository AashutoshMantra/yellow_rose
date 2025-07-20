import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selected;
  final Function onClick;
  const CustomBottomNavigationBar(
      {super.key, required this.selected, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05), // adjust opacity as needed
          offset: const Offset(0, -10), // x = 0, y = -8 (upwards)
          blurRadius: 28,
          spreadRadius: 0, // optional
        ),
      ]),
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
      child: SalomonBottomBar(
        currentIndex: selected,
        selectedColorOpacity: 1,
        
        items: [
          SalomonBottomBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/home.png"),
              color: AppColors.primaryTextSwatch[500],
            ),
            title: Text(
              'Home',
              style:
                  TextStyles.bodySmallBoldStyle().copyWith(color: Colors.white),
            ),
            selectedColor: AppColors.primary,
            unselectedColor: Colors.transparent,
            activeIcon: const ImageIcon(
              AssetImage("assets/images/home.png"),
              color: Colors.white,
            ),
          ),
          SalomonBottomBarItem(
            icon: ImageIcon(const AssetImage("assets/images/ticket.png"),
                color: AppColors.primaryTextSwatch[500]),
            title: Text(
              'Bookings',
              style:
                  TextStyles.bodySmallBoldStyle().copyWith(color: Colors.white),
            ),
            selectedColor: AppColors.primary,
            unselectedColor: Colors.transparent,
            activeIcon: const ImageIcon(
              AssetImage("assets/images/ticket.png"),
              color: Colors.white,
            ),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.account_circle,
                color: AppColors.primaryTextSwatch[500]),
            title: Text(
              'Profile',
              style:
                  TextStyles.bodySmallBoldStyle().copyWith(color: Colors.white),
            ),
            selectedColor: AppColors.primary,
            unselectedColor: Colors.transparent,
            activeIcon: const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          onClick(index);
        },
      ),
    );
  }
}
