class RequiredNutritionData {
  static final RequiredNutritionData _instance = RequiredNutritionData._internal();

  factory RequiredNutritionData() {
    return _instance;
  }

  RequiredNutritionData._internal();

  double? requiredProtein;
  double? requiredCarbohydrates;
  double? requiredFat;
  double? requiredFiber;
  double? requiredvitaminB6;
  double? requiredIron;
  double? requiredCalcium;
  double? requiredVitaminA;
  double? requiredVitaminD;
  double? requiredVitaminE;
  double? requiredTotalNutrition;

  void updateData({
    required double requiredProtein,
    required double requiredCarbohydrates,
    required double requiredFat,
    required double requiredFiber,
    required double requiredvitaminB6,
    required double requiredIron,
    required double requiredCalcium,
    required double requiredVitaminA,
    required double requiredVitaminD,
    required double requiredVitaminE,
    required double requiredTotalNutrition,
  }) {
    this.requiredProtein = requiredProtein;
    this.requiredCarbohydrates = requiredCarbohydrates;
    this.requiredFat = requiredFat;
    this.requiredFiber = requiredFiber;
    this.requiredvitaminB6 = requiredvitaminB6;
    this.requiredIron = requiredIron;
    this.requiredCalcium = requiredCalcium;
    this.requiredVitaminA = requiredVitaminA;
    this.requiredVitaminD = requiredVitaminD;
    this.requiredVitaminE = requiredVitaminE;
    this.requiredTotalNutrition = requiredTotalNutrition;
  }
}