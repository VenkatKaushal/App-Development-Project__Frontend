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

   double getWeeklyTotal() {
    // Define weights for each nutrient
    double a = 1.0;  // Weight for protein
    double b = 0.5;  // Weight for carbohydrates
    double c = 0.5;  // Weight for fat
    double d = 0.2;  // Weight for fiber
    double e = 0.3;  // Weight for vitamin B6
    double f = 0.7;  // Weight for iron
    double g = 0.8;  // Weight for calcium
    double h = 0.4;  // Weight for vitamin A
    double i = 0.4;  // Weight for vitamin D
    double j = 0.4;  // Weight for vitamin E

    // Calculate weekly total based on required data
    return (a * (requiredProtein ?? 0) +
            b * (requiredCarbohydrates ?? 0) +
            c * (requiredFat ?? 0) +
            d * (requiredFiber ?? 0) +
            e * (requiredvitaminB6 ?? 0) +
            f * (requiredIron ?? 0) +
            g * (requiredCalcium ?? 0) +
            h * (requiredVitaminA ?? 0) +
            i * (requiredVitaminD ?? 0) +
            j * (requiredVitaminE ?? 0)); // Multiply by 7 to get weekly total
   }
}