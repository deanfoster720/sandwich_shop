class PricingRepository {
  final double sixInchPrice;
  final double footlongPrice;

  const PricingRepository({
    this.sixInchPrice = 7.0,
    this.footlongPrice = 11.0,
  });

  double calculateTotalPrice({
    required int quantity,
    required bool isFootlong,
  }) {
    if (quantity <= 0) return 0.0;

    final double unitPrice = isFootlong ? footlongPrice : sixInchPrice;
    return quantity * unitPrice;
  }
}
