import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';

class OrderInvoiceDownloader {
  OrderInvoiceDownloader._();

  static final DioClient _dioClient = getIt<DioClient>();

  static Future<void> download({
    required BuildContext context,
    required String orderId,
    String invoiceLabel = 'O',
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$orderId-$invoiceLabel.pdf');
      final response = await _dioClient.get(
        '${AppConfig.instance.apiBaseUrl}/order/invoice/v1?orderId=$orderId&invoiceLabel=$invoiceLabel',
        options: Options(responseType: ResponseType.bytes),
      );
      await file.writeAsBytes(response.data);
      final openResult = await OpenFile.open(file.path);
      if (openResult.type != ResultType.done) {
        WidgetUtil.showSnackBar('Saved to ${file.path}', context);
      }
    } catch (error, stackTrace) {
      log('Failed to download invoice: $error', stackTrace: stackTrace);
      WidgetUtil.showSnackBar('Error downloading document', context);
    }
  }
}
