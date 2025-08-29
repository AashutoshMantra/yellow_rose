import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response_entoty.dart';

class HotelAmenitySection extends StatelessWidget {
  final List<HotelSearchResponseAmenity> amenities;
  final bool groupByName;
  final int previewCount;

  const HotelAmenitySection({
    super.key,
    required this.amenities,
    this.groupByName = false,
    this.previewCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    final itemsToShow = groupByName
        ? _extractTopUniqueGroups(amenities, previewCount)
        : amenities.take(previewCount).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primarySwatch[300]!,
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amenities",
              style: TextStyles.h6Style(),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: itemsToShow
                  .map((amenity) => Chip(
                        label: Text(amenity.displayName),
                        side: BorderSide.none,
                        backgroundColor: AppColors.primarySwatch[100],
                      ))
                  .toList(),
            ),
            TextButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => FullAmenityBottomSheet(
                  amenities: amenities,
                  groupByName: groupByName,
                ),
              ),
              child: const Text("View more"),
            )
          ],
        ),
      ),
    );
  }

  List<HotelSearchResponseAmenity> _extractTopUniqueGroups(
      List<HotelSearchResponseAmenity> items, int count) {
    final grouped = <String, HotelSearchResponseAmenity>{};
    for (var amenity in items) {
      if (!grouped.containsKey(amenity.name)) {
        grouped[amenity.name] = amenity;
        if (grouped.length == count) break;
      }
    }
    return grouped.values.toList();
  }
}

class FullAmenityBottomSheet extends StatelessWidget {
  final List<HotelSearchResponseAmenity> amenities;
  final bool groupByName;

  const FullAmenityBottomSheet({
    super.key,
    required this.amenities,
    this.groupByName = false,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = groupByName ? _groupByName(amenities) : {"All": amenities};

    return Container(
      padding: const EdgeInsets.all(16),
      height: 600.h,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: grouped.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (groupByName)
                      Text(
                        entry.key,
                        style: TextStyles.h6Style(),
                      ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: entry.value
                          .map((a) => Chip(
                                label: Text(a.displayName),
                                side:
                                    const BorderSide(color: AppColors.primary),
                                backgroundColor: AppColors.primarySwatch[100],
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<HotelSearchResponseAmenity>> _groupByName(
      List<HotelSearchResponseAmenity> items) {
    final map = <String, List<HotelSearchResponseAmenity>>{};
    for (var item in items) {
      map.putIfAbsent(item.name, () => []).add(item);
    }
    return map;
  }
}
