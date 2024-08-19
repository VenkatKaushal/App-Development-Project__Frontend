class NutritionData {
  static final NutritionData _instance = NutritionData._internal();

  factory NutritionData() {
    return _instance;
  }

  NutritionData._internal();

  double? calories;
  double? dailyProtein;
  double? dailyCarbohydrates;
  double? dailyFat;
  double? dailyFiber;
  double? dailyVitaminB6;
  double? dailyIron;
  double? dailyCalcium;
  double? dailyVitaminA;
  double? dailyVitaminD;
  double? dailyVitaminE;
  double? dailyTotalNutrition;

  void updateData({
    required double calories,
    required double dailyProtein,
    required double dailyCarbohydrates,
    required double dailyFat,
    required double dailyFiber,
    required double dailyVitaminB6,
    required double dailyIron,
    required double dailyCalcium,
    required double dailyVitaminA,
    required double dailyVitaminD,
    required double dailyVitaminE,
    required double dailyTotalNutrition,

  }) {
    this.calories = calories;
    this.dailyProtein = dailyProtein;
    this.dailyCarbohydrates = dailyCarbohydrates;
    this.dailyFat = dailyFat;
    this.dailyFiber = dailyFiber;
    this.dailyVitaminB6 = dailyVitaminB6;
    this.dailyIron = dailyIron;
    this.dailyCalcium = dailyCalcium;
    this.dailyVitaminA = dailyVitaminA;
    this.dailyVitaminD = dailyVitaminD;
    this.dailyVitaminE = dailyVitaminE;
    this.dailyTotalNutrition = dailyTotalNutrition;
  }
}

