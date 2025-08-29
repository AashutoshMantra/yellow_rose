import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/hotel_metadata_policy.dart';

class MmtHotelPolicy extends StatelessWidget {
  final List<MMTHotelMetadataPolicy> policies;
  const MmtHotelPolicy({super.key, required this.policies});
  void showPolicyBottomSheet(
      BuildContext context, List<MMTHotelMetadataPolicy> policies) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Header with Close Icon
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Policies", style: TextStyles.h6Style()),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: policies.length,
                    itemBuilder: (context, index) {
                      final item = policies[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.category != null)
                              Text(item.category!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            SizedBox(height: 6.h),
                            ...?item.policyList?.map((p) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text("• $p"),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visiblePolicies = policies.take(2).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primarySwatch[300]!,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Policies', style: TextStyles.h6Style()),
                SizedBox(height: 8.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visiblePolicies.length,
                    itemBuilder: (context, index) {
                      final category = visiblePolicies[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category.category ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4.h),
                          ...?category.policyList
                              ?.take(1)
                              .map((p) => Text("• $p")),
                          SizedBox(height: 12.h),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white.withAlpha(1), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 0,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => showPolicyBottomSheet(context, policies),
              icon: const Icon(Icons.expand_more),
              label: const Text("View more"),
            ),
          )
        ],
      ),
    );
  }
}
