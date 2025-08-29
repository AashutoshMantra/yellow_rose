enum SpecialRequestEnum {
  smokingRoom,
  higherFloor,
  groundFloor,
  earlyCheckin,
  lateCheckout,
  others;

  String get displayName {
    switch (this) {
      case SpecialRequestEnum.smokingRoom:
        return "Smoking room";
      case SpecialRequestEnum.higherFloor:
        return "Room on higher floor";
      case SpecialRequestEnum.groundFloor:
        return "Room on ground floor";
      case SpecialRequestEnum.earlyCheckin:
        return "Early Check in";
      case SpecialRequestEnum.lateCheckout:
        return "Late Check out";
      case SpecialRequestEnum.others:
        return "Others";
    }
  }
}

class SpecialRequest {
  List<SpecialRequestEnum> selectedRequests;
  DateTime? earlyCheckinDateTime;
  DateTime? lateCheckoutDateTime;
  String? otherRequest;

  SpecialRequest({
    this.selectedRequests = const [],
    this.earlyCheckinDateTime,
    this.lateCheckoutDateTime,
    this.otherRequest,
  });

  bool isSelected(SpecialRequestEnum type) {
    return selectedRequests.contains(type);
  }

  SpecialRequest copyWith({
    List<SpecialRequestEnum>? selectedRequests,
    DateTime? earlyCheckinDateTime,
    DateTime? lateCheckoutDateTime,
    String? otherRequest,
  }) {
    return SpecialRequest(
      selectedRequests: selectedRequests ?? this.selectedRequests,
      earlyCheckinDateTime: earlyCheckinDateTime ?? this.earlyCheckinDateTime,
      lateCheckoutDateTime: lateCheckoutDateTime ?? this.lateCheckoutDateTime,
      otherRequest: otherRequest ?? this.otherRequest,
    );
  }

  @override
  String toString() {
    List<String> parts = [];

    for (var req in selectedRequests) {
      switch (req) {
        case SpecialRequestEnum.earlyCheckin:
          final dateStr = earlyCheckinDateTime != null
              ? " (Check in request time - ${earlyCheckinDateTime!.toString()})"
              : "";
          parts.add("${req.displayName}$dateStr");
          break;

        case SpecialRequestEnum.lateCheckout:
          final dateStr = lateCheckoutDateTime != null
              ? " (Checkout request time - ${lateCheckoutDateTime!.toString()})"
              : "";
          parts.add("${req.displayName}$dateStr");
          break;

        case SpecialRequestEnum.others:
          final otherStr =
              (otherRequest != null && otherRequest!.trim().isNotEmpty)
                  ? "-${otherRequest!.trim()}"
                  : "";
          parts.add("${req.displayName}$otherStr");
          break;

        default:
          parts.add(req.displayName);
          break;
      }
    }

    return parts.join(", ");
  }
}
