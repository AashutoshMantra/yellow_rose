import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status_list.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/order_detail_card.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  bool _loading = true;
  final _airUseCase = getIt<AirUseCase>();
  List<OrderStatus> bookingLists = [];
  void getOrderStatus() async {
    try {
      var orderStatusListRequest = OrderStatusListRequest();
      var orders = await _airUseCase.getOrders(orderStatusListRequest);
      setState(() {
        _loading = false;
        bookingLists = orders;
      });
    } catch (e, s) {
      log("$e $s");
      WidgetUtil.showSnackBar("Error fetching booking details", context);
    }
  }

  @override
  void initState() {
    super.initState();
    getOrderStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 150.h,
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
            ),
          ],
        ),
        if (bookingLists.isEmpty && !_loading)
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 200.h),
                  child: Text(
                    "No Booking Found",
                    style: TextStyles.h4Style(),
                  ))),
        if (_loading)
          const Loader(
            color: Colors.transparent,
          ),
        Padding(
          padding: EdgeInsets.all(24.h),
          child: ListView.separated(
            itemCount: bookingLists.length,
            itemBuilder: (ctx, idx) {
              return OrderDetailCard(orderStatus: bookingLists[idx]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 24.h,
              );
            },
          ),
        )
      ],
    );
  }
}
