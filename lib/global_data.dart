class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() {
    return _instance;
  }

  UserData._internal();

  String? userName;
  int? age;
  String? gender;
  double? weight;
  double? height;

  void updateData({
    required String userName,
    required int age,
    required String gender,
    required double weight,
    required double height,
  }) {
    this.userName = userName;
    this.age = age;
    this.gender = gender;
    this.weight = weight;
    this.height = height;
  }
}