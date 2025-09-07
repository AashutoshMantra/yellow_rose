import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/ticket_details/air_ticekt_widget.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/air_order_detail_card.dart';

class FlightTicketScreen extends StatefulWidget {
  static const String routeName = "/eTicektScreen";
  final OrderStatus orderStatus;

  const FlightTicketScreen({super.key, required this.orderStatus});

  @override
  State<FlightTicketScreen> createState() => _FlightTicketScreenState();
}

class _FlightTicketScreenState extends State<FlightTicketScreen> {
  bool _loading = false;
  final _dioClient = getIt<DioClient>();
  void _downloadTicket() async {
    setState(() {
      _loading = true;
    });
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/downloaded.pdf');
      var result = await _dioClient.get(
          '${AppConfig.instance.apiBaseUrl}/order/invoice/v1?orderId=${widget.orderStatus.uuid}&invoiceLabel=O',
          options: Options(responseType: ResponseType.bytes));
      await file.writeAsBytes(result.data);
      OpenFile.open(file.path);
    } catch (e, s) {
      log("$e $s");
      WidgetUtil.showSnackBar(
        "Error downloading ticket",
        context,
      );
    }
    setState(() {
      _loading = false;
    });
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
          widget.orderStatus.status?.isTicketDownloadable() == true
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
