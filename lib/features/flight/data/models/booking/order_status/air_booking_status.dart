import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

enum AirBookingStatusEnum {
  NEW("NEW", "N", "New"),
  PENDINGTICKET("PENDINGTICKET", "T", ""),
  INITIATED("INITIATED", "I", "Initiated"),
  BLOCKED("BLOCKED", "BL", "Blocked"),
  ABORTED("ABORTED", "A", "Aborted"),
  TO_CANCEL("TO_CANCEL", "TC", "To Cancel"),
  CANCELLED("CANCELLED", "C", "Cancelled"),
  RESCHEDULED("RESCHEDULED", "R", "Rescheduled"),
  PARTIALLYCANCELLED("PARTIALLYCANCELLED", "P", "Partially Cancelled"),
  BOOKED("BOOKED", "B", "Booked"),
  UNCONFIRMED("UNCONFIRMED", "U", "Unconfirmed"),
  FAILED("FAILED", "F", "Failed"),
  ERROR("ERROR", "E", "Error"),

  PARTIALlYRESCHEDULED("PARTIALlYRESCHEDULED", "PS", ""),
  PARTIALLYBOOKED("PARTIALLYBOOKED", "Z", "Partially Booked"),
  PARTIALLYCACELLED("PARTIALLYCACELLED", "X", "Partially Cancelled"),
  REQUESTED("REQUESTED", "R", ""),
  AMENDEDWITHSUPPLIER("AMENDED WITH SUPPLIER", "", ""),
  PROCESSED("PROCESSED", "PR", ""),
  REIMBURSED("REIMBURSED", "RI", ""),
  AWAITINGOPTIONS("AWAITING OPTIONS", "AO", ""),
  RECONSIDER("RECONSIDER", "RC", ""),
  SUBMITTED("SUBMITTED", "S", ""),
  NOTPERFORMED("NOT PERFORMED", "NP", ""),
  REOPEN("REOPEN", "RO", ""),
  COMPLETED("COMPLETED", "C", ""),
  PENDINGHOTELCONFIRMATION(
      "PENDINGHOTELCONFIRMATION", "HP", "Pending Confirmation");

  final String text;
  final String code;
  final String displayText;
  const AirBookingStatusEnum(this.text, this.code, this.displayText);

  static AirBookingStatusEnum getFromCode(String code) {
    return AirBookingStatusEnum.values.firstWhere(
      (d) => d.code.equalsIgnoreCase(code),
      orElse: () => AirBookingStatusEnum.NEW,
    );
  }

  Color get color {
    switch (this) {
      case NEW:
        return AppColors.primarySwatch[300]!; // Green
      case PENDINGTICKET:
        return const Color(0xFFFF9800); // Orange
      case INITIATED:
        return const Color(0xFF2196F3); // Blue
      case BLOCKED:
        return AppColors.error; // Red
      case ABORTED:
        return AppColors.error; // Grey

      case CANCELLED:
        return AppColors.errorSwatch[400]!; // Purple

      case PARTIALLYCANCELLED:
        return const Color.from(
            alpha: 1, red: 1, green: 0.875, blue: 0.431); // Cyan
      case PENDINGHOTELCONFIRMATION:
        return AppColors.warning; // Cyan
      case PARTIALLYCACELLED:
        return AppColors.warning; // Cyan
      case BOOKED:
        return AppColors.primaryGreen; // Light Green
      case UNCONFIRMED:
        return AppColors.warning; // Yellow
      case FAILED:
        return AppColors.error; // Pink
      case TO_CANCEL:
        return AppColors.error; // Pink

      case ERROR:
        return AppColors.error; // Dark Red
      case PARTIALLYBOOKED:
        return AppColors.warning;
      default:
        return Colors.grey; // Default color for others
    }
  }

  bool isTicketDownloadable() {
    return this == AirBookingStatusEnum.BOOKED ||
        this == AirBookingStatusEnum.PARTIALLYBOOKED ||
        this == AirBookingStatusEnum.PENDINGTICKET ||
        this == AirBookingStatusEnum.UNCONFIRMED ||
        this == AirBookingStatusEnum.PARTIALlYRESCHEDULED;
  }

  bool isTerminalState() {
    return this == AirBookingStatusEnum.BOOKED ||
        this == AirBookingStatusEnum.CANCELLED ||
        this == AirBookingStatusEnum.PARTIALLYCANCELLED ||
        this == AirBookingStatusEnum.FAILED ||
        this == AirBookingStatusEnum.ERROR;
  }
}
