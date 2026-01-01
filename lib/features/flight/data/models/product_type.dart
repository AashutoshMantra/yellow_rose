enum ProductTypeEnum {
  ALL("All", "L"),
  AIR("Air", "A"),
  HOTEL("Hotel", "H"),
  INSURANCE("Insurance", "I"),
  BUS("Bus", "B");

  final String title;
  final String code;
  const ProductTypeEnum(this.title, this.code);
}
