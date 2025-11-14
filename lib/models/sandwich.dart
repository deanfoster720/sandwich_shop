enum BreadType { white, wheat, wholemeal }

enum SandwichType {
  veggieDelight,
  chickenTeriyaki,
  tunaMelt,
  meatballMarinara,
}

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;

  Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
  });

  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.chickenTeriyaki:
        return 'Chicken Teriyaki';
      case SandwichType.tunaMelt:
        return 'Tuna Melt';
      case SandwichType.meatballMarinara:
        return 'Meatball Marinara';
    }
  }

  String get image {
    final String baseName;
    switch (type) {
      case SandwichType.veggieDelight:
        baseName = 'veggieDelight';
        break;
      case SandwichType.chickenTeriyaki:
        baseName = 'chickenTeriyaki';
        break;
      case SandwichType.tunaMelt:
        baseName = 'tunaMelt';
        break;
      case SandwichType.meatballMarinara:
        baseName = 'meatballMarinara';
        break;
    }

    final String sizeSegment = isFootlong ? 'footlong' : 'six_inch';
    return 'assets/images/${baseName}_$sizeSegment.png';
  }
}
