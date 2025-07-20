import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';

enum PassengerType {
  ADT("ADULT"),

  CHD("CHILD"),

  INFT("INFANT");

  final String description;

  const PassengerType(this.description);

  bool isInfant() {
    return this == PassengerType.INFT;
  }

  bool isChild() {
    return this == PassengerType.CHD;
  }

  bool isAdult() {
    return this == PassengerType.ADT;
  }

  String getDescription() {
    return description;
  }

  String get ageString {
    if (isAdult()) {
      return "12yr";
    }
    if (isChild()) {
      return "2-12yrs";
    }
    if (isInfant()) {
      return "15 days - 2 yrs";
    }
    return "";
  }

  PassengerTypeEnum get getPassengerTypeEnum {
    switch (this) {
      case PassengerType.ADT:
        return PassengerTypeEnum.ADT;
      case PassengerType.CHD:
        return PassengerTypeEnum.CHD;
      case PassengerType.INFT:
        return PassengerTypeEnum.INFT;
    }
  }
}
