import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/order_invoice_downloader.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/ticket_details/air_ticekt_widget.dart';

class FlightTicketScreen extends StatefulWidget {
  static const String routeName = "/eTicektScreen";
  final OrderStatus orderStatus;
  final bool readonly;

  const FlightTicketScreen({
    super.key,
    required this.orderStatus,
    this.readonly = false,
  });

  @override
  State<FlightTicketScreen> createState() => _FlightTicketScreenState();
}

class _FlightTicketScreenState extends State<FlightTicketScreen> {
  bool _loading = false;
  void _downloadTicket() async {
    final orderId = widget.orderStatus.uuid;
    if (orderId == null) {
      WidgetUtil.showSnackBar('Order id missing', context);
      return;
    }
    setState(() {
      _loading = true;
    });
    try {
      await OrderInvoiceDownloader.download(
        context: context,
        orderId: orderId,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "E-Ticket",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      bottomNavigationBar:
          widget.orderStatus.status?.isTicketDownloadable() == true &&
                  !widget.readonly
              ? Container(
                  margin: EdgeInsets.only(bottom: 32.h),
                  child: CustomButton(
                      text: "Download Ticket",
                      onPressed: !_loading ? _downloadTicket : null))
              : null,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ticket Details", style: TextStyles.bodyMediumBoldStyle()),
                SizedBox(height: 6.h),
                Text.rich(
                  TextSpan(
                    text: "Cart ID: ",
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                    children: [
                      TextSpan(
                        text: widget.orderStatus.uuid ?? '',
                        style: TextStyles.bodySmallBoldStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (ctx, idx) {
                      return AirTicektWidget(
                        airOrderItinerary:
                            widget.orderStatus.airItineraries![idx],
                        orderStatus: widget.orderStatus,
                        orderId: widget.orderStatus.uuid!,
                        readonly: widget.readonly,
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return const SizedBox(height: 1);
                    },
                    itemCount: widget.orderStatus.airItineraries?.length ?? 0,
                  ),
                ),
              ],
            ),
          ),
          if (_loading) const Loader()
        ],
      ),
    );
  }
}
