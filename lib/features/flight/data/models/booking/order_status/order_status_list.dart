class OrderStatusListRequest {
  String? invoiceStatus;
  String? fromDate;
  String? toDate;
  List<String>? status;
  String? orderId;
  int? size;
  int? strPage;
  String? pnr;
  String? product;
  String? ticketNumber;
  String? bookedFor;
  String? bookedBy;
  String? corporate;
  String? passenger;
  String? ticketIssuance;
  String? branchId;
  String? airline;
  String? segmentType;

  OrderStatusListRequest(
      {this.invoiceStatus = "",
      this.fromDate = "",
      this.toDate = "",
      List<String>? status,
      this.orderId = "",
      this.size = 10,
      this.strPage = 0,
      this.pnr = "",
      this.product = "AIR",
      this.ticketNumber = "",
      this.bookedFor = "",
      this.bookedBy = "",
      this.corporate = "",
      this.passenger = "",
      this.ticketIssuance = "",
      this.branchId = "",
      this.airline = "",
      this.segmentType = ""})
      : status = status ?? [];

  OrderStatusListRequest.fromJson(Map<String, dynamic> json) {
    invoiceStatus = json['invoiceStatus'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    if (json['status'] != null) {
      status = <String>[];
      json['status'].forEach((v) {
        status!.add(v);
      });
    }
    orderId = json['orderId'];
    size = json['size'];
    strPage = json['strPage'];
    pnr = json['pnr'];
    product = json['product'];
    ticketNumber = json['ticketNumber'];
    bookedFor = json['bookedFor'];
    bookedBy = json['bookedBy'];
    corporate = json['corporate'];
    passenger = json['passenger'];
    ticketIssuance = json['ticketIssuance'];
    branchId = json['branchId'];
    airline = json['airline'];
    segmentType = json['segmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoiceStatus'] = invoiceStatus;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    if (status != null) {
      data['status'] = status!.map((v) => v).toList();
    }
    data['orderId'] = orderId;
    data['size'] = size;
    data['strPage'] = strPage;
    data['pnr'] = pnr;
    data['product'] = product;
    data['ticketNumber'] = ticketNumber;
    data['bookedFor'] = bookedFor;
    data['bookedBy'] = bookedBy;
    data['corporate'] = corporate;
    data['passenger'] = passenger;
    data['ticketIssuance'] = ticketIssuance;
    data['branchId'] = branchId;
    data['airline'] = airline;
    data['segmentType'] = segmentType;
    return data;
  }
}
