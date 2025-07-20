enum BookingChannelEnum {
  WEB("WEB", "Booked via Web Interface"),
  TERMINAL("TERM", "Booked via Terminal Interface"),
  APP("APP", "Booked via Mobile App");

  final String code;
  final String description;
  const BookingChannelEnum(this.code, this.description);
}
