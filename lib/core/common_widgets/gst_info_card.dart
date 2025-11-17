import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/key_value_row.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';

class GstInfoCard extends StatefulWidget {
  final BillingEntity billingEntity;
  final bool initiallyExpanded;
  final String title;
  final String collapsedMessage;

  const GstInfoCard({
    super.key,
    required this.billingEntity,
    this.initiallyExpanded = false,
    this.title = 'Billing & GST',
    this.collapsedMessage = 'Tap to view saved GST details',
  });

  @override
  State<GstInfoCard> createState() => _GstInfoCardState();
}

class _GstInfoCardState extends State<GstInfoCard> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final billing = widget.billingEntity;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10.w,
            offset: Offset(0, 4.h),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyles.bodyLargeSemiBoldStyle()),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: _toggle,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(8.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                children: [
                  Text('GST Information',
                      style: TextStyles.bodySmallBoldStyle()
                          .copyWith(color: Colors.white)),
                  const Spacer(),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 200),
            firstChild: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KeyValueRow(
                    label: 'GST Number',
                    value: billing.entityGST ?? '--',
                  ),
                  KeyValueRow(
                    label: 'Entity Name',
                    value: billing.entityName ?? '--',
                  ),
                  if ((billing.email ?? '').isNotEmpty)
                    KeyValueRow(label: 'Email', value: billing.email!),
                  if ((billing.phone ?? '').isNotEmpty)
                    KeyValueRow(label: 'Phone', value: billing.phone!),
                ],
              ),
            ),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                widget.collapsedMessage,
                style: TextStyles.bodySmallMediumStyle()
                    .copyWith(color: AppColors.primaryTextSwatch[500]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
