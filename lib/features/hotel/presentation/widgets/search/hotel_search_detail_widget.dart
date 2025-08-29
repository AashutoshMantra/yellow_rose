import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/data/models/review_rating.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';

String getRatingText(double? rating) {
  if (rating == null) return "";
  if (rating >= 4.5) return "Excellent";
  if (rating >= 4.0) return "Very Good";
  if (rating >= 3.0) return "Good";
  if (rating >= 2.0) return "Fair";
  return "";
}

class HotelSearchDetailWidget extends StatefulWidget {
  final HotelSearchResponse hotelSearchResponse;
  const HotelSearchDetailWidget({super.key, required this.hotelSearchResponse});

  @override
  State<HotelSearchDetailWidget> createState() =>
      _HotelSearchDetailWidgetState();
}

class _HotelSearchDetailWidgetState extends State<HotelSearchDetailWidget> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = widget.hotelSearchResponse.media ?? [];
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.h),
          border: Border.all(
            color: AppColors.primarySwatch[300]!,
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image gallery with pageview + overlay next button
            ClipRRect(
              borderRadius: BorderRadius.circular(10.h),
              child: SizedBox(
                height: 180.h,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: media.length,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (BuildContext context, int index) {
                        var url = HotelMapperUtiity.getImageUrl(media[index]);
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: url ?? '',
                          width: double.infinity,
                        );
                      },
                    ),
                    // left-side previous button
                    if (media.length > 1)
                      Positioned(
                        left: 8.w,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              final prev =
                                  (_currentPage - 1).clamp(0, media.length - 1);
                              _pageController.animateToPage(prev,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.h),
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_back_ios,
                                    size: 16.h, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    // right-side next button
                    if (media.length > 1)
                      Positioned(
                        right: 8.w,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              final next =
                                  (_currentPage + 1).clamp(0, media.length - 1);
                              _pageController.animateToPage(next,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.h),
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 16.h, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.h),
            // page indicator
            if (media.length > 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(media.length, (i) {
                    final active = i == _currentPage;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: active ? 10.w : 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primary
                            : AppColors.primaryTextSwatch[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  }),
                ),
              ),
            SizedBox(height: 6.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HotelUserRating(
                      reviewDetails: widget.hotelSearchResponse.reviewDetails),
                  SizedBox(height: 5.h),
                  Text(
                    widget.hotelSearchResponse.name ?? "N/A",
                    style: TextStyles.h6Style(),
                  ),
                  SizedBox(height: 2.h),
                  RatingStars(
                    value: widget.hotelSearchResponse.starRating ?? 0.0,
                    starSize: 10.h,
                    maxValue: 5,
                    valueLabelVisibility: false,
                    starColor: AppColors.primaryText,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.hotelSearchResponse.address ?? "N/A",
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: AppColors.primaryTextSwatch[500],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "₹ ${widget.hotelSearchResponse.rooms?.firstOrNull?.rate?.totalAmount.toStringAsFixed(1) ?? "N/A"}",
                    style: TextStyles.bodyLargeBoldStyle().copyWith(),
                  ),
                  Text("per night",
                      style: TextStyles.bodySmallStyle().copyWith(
                        color: AppColors.primaryTextSwatch[500],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelUserRating extends StatelessWidget {
  const HotelUserRating({
    super.key,
    this.reviewDetails,
  });

  final ReviewDetail? reviewDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
            child: Text(reviewDetails?.rating.toStringAsFixed(1) ?? "0.0",
                style: TextStyles.bodyMediumBoldStyle().copyWith(
                  color: Colors.white,
                )),
          ),
        ),
        SizedBox(width: 4.w),
        Text(getRatingText(reviewDetails?.rating),
            style: TextStyles.bodyMediumBoldStyle().copyWith(
              color: AppColors.primary,
            )),
        SizedBox(width: 3.w),
        Text(
          "(${reviewDetails?.totalRatingCount ?? 0} reviews)",
          style: TextStyles.bodySmallStyle().copyWith(
            color: AppColors.primaryTextSwatch[500],
          ),
        ),
      ],
    );
  }
}
