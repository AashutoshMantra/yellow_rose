import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:yellow_rose/core/common_widgets/image_carousel.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';

class HotelDetailImageWidget extends StatelessWidget {
  final HotelSearchResponse hotelSearchResponse;
  const HotelDetailImageWidget({super.key, required this.hotelSearchResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 20,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.h),
        child: SizedBox(
          height: 400.h,
          child: Stack(
            children: [
              Builder(builder: (context) {
                var url = HotelMapperUtiity.getImageUrl(
                    hotelSearchResponse.media?.first);

                return CachedNetworkImage(
                  imageUrl: url ?? "",
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    height: double.infinity,
                  ),
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.h),
                    bottomRight: Radius.circular(12.h),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.8, sigmaY: 1.8),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: const BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if ((hotelSearchResponse.media?.length ?? 0) > 1)
                            GestureDetector(
                              onTap: () {
                                FullScreenImageCarousel.show(
                                  context,
                                  imageUrls: hotelSearchResponse.media!
                                      .map(HotelMapperUtiity.getImageUrl)
                                      .nonNulls
                                      .toList(),
                                  initialIndex: 0,
                                );
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(1.5.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.h),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.h),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 45.h,
                                          height: 45.h,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                HotelMapperUtiity.getImageUrl(
                                                      hotelSearchResponse.media
                                                          ?.elementAtOrNull(1),
                                                    ) ??
                                                    "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const SizedBox(),
                                          ),
                                        ),
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 1, sigmaY: 1),
                                          child: SizedBox(
                                            width: 45.h,
                                            height: 45.h,
                                          ),
                                        ),
                                        Text(
                                          "+ ${hotelSearchResponse.media?.length ?? 0 - 1}",
                                          style:
                                              TextStyles.bodyLargeMediumStyle()
                                                  .copyWith(
                                                      color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Text(
                            hotelSearchResponse.name ?? "N/A",
                            style: TextStyles.h5Style()
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            child: RatingStars(
                              value: hotelSearchResponse.starRating ?? 0.0,
                              starSize: 10.h,
                              maxValue: 5,
                              valueLabelVisibility: false,
                              starColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            
            
            
            ],
          ),
        ),
      ),
    );
  }
}
