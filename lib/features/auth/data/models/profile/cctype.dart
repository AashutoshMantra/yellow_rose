enum CCType {
  VISA(1, "VISA", "VISA", "Visa", "V", "VI", "VISA", "Visa", true, false),

  MASTERCARD(2, "Mastercard", "MC", "Mastercard", "M", "CA", "MASTER",
      "Master Card", true, false),

  AMEX(3, "American Express", "AE", "Amex", "AE", "AX", "AMEX",
      "American Express", false, false),
  //
  // DINERS(4, "DINERS", "DINERS", "Diners", "DC", "DC", "DINERS", "Diners",
  // false, false),
  //
  // BTA(5, "BTA", "BTA", "BTA", "BTA", "AX", "AMEX", "American Express",
  // false, true),
  //
  // CTA_VISA(6, "CTA Visa", "CTA", "CTA", "CTA", "VI", "VISA", "Visa", false,
  // true),
  //
  // CTA_MASTER(7, "CTA Master", "CTA", "CTA", "CTA", "CA", "Master", "Master
  // Card", false, true),
  //
  // UNION_PAY(8, "Union Pay", "Union Pay", "Union Pay", "CU", "CU", "Union
  // Pay", "Union Pay", false, false),
  //
  // DISCOVER_CARD(9, "Discover Card", "Discover Card", "Discover Card", "DS",
  // "DS", "Discover Card", "Discover Card",
  // false, false),
  //
  // JAPAN_CREDIT(10, "Japan Credit Bureau International", "Japan Credit
  // Bureau International",
  // "Japan Credit Bureau International", "JC", "JC", "Japan Credit Bureau
  // International",
  // "Japan Credit Bureau International", false, false),

  // UATP(11, "UATP", "UATP", "UATP", "TP", "TP", "UATP", "UATP", false,
  // false),
  ;

  final int ccTypeId;
  final String ccTypeName;
  final String ccTypeShortName;
  final String ccTypeDisplayName;
  final String ccTypeFirstChar;
  final String gdsCCType;
  final String gdsCCTypeName;
  final String gdsCCTypeDisplayName;
  final bool allowSaveCard;
  final bool isCorporateCard;
  const CCType(
      this.ccTypeId,
      this.ccTypeName,
      this.ccTypeShortName,
      this.ccTypeDisplayName,
      this.ccTypeFirstChar,
      this.gdsCCType,
      this.gdsCCTypeName,
      this.gdsCCTypeDisplayName,
      this.allowSaveCard,
      this.isCorporateCard);

  static CCType? getCardTypeFromNumber(String ccNumber) {
    int? firstDigit = int.tryParse(ccNumber.substring(0, 1));

    if (ccNumber.length == 16) {
      switch (firstDigit) {
        case 4:
          return CCType.VISA;
        case 5:
          return CCType.MASTERCARD;
      }
    }
    return null;
  }

  static CCType getCCType(String ccTypeFirstChar) {
    switch (ccTypeFirstChar) {
      case 'V':
        return CCType.VISA;
      case 'M':
        return CCType.MASTERCARD;
      // case 'A':
      // ccType = CCType.AMEX;
      // break;
      // case 'D':
      // ccType = CCType.DINERS;
      // break;
      // case 'B':
      // ccType = CCType.BTA;
      // break;
      default:
        break;
    }
    throw Exception("CC Type did not match.");
  }

  static CCType getGdsCCType(String gdsCCType) {
    if ("VI" == gdsCCType) {
      return CCType.VISA;
    }
    // else if ("AX".equals(gdsCCType)) {
    // return CCType.AMEX;
    // } else if ("DC".equals(gdsCCType)) {
    // return CCType.DINERS;
    // }
    //
    else if ("MC" == gdsCCType || "IK" == gdsCCType || "CA" == gdsCCType) {
      return CCType.MASTERCARD;
    }
    // else if ("CU".equals(gdsCCType)) {
    // return CCType.UNION_PAY;
    // } else if ("DS".equals(gdsCCType)) {
    // return CCType.DISCOVER_CARD;
    // } else if ("JC".equals(gdsCCType)) {
    // return CCType.JAPAN_CREDIT;
    // } else if ("TP".equals(gdsCCType)) {
    // return CCType.UATP;
    // }
    else {
      throw Exception("GDS CC Type did not match.");
    }
  }

  static CCType getCCTypeById(int id) {
    for (CCType ccType in values) {
      if (id == ccType.ccTypeId) {
        return ccType;
      }
    }
    throw Exception("CC Type Id did not match.");
  }
}
