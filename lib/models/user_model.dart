class UserModel {
  int? userId;
  final String userName;
  final String userEmail;
  final String userPassword;

  UserModel(
      {this.userId,
      required this.userName,
      required this.userEmail,
      required this.userPassword});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> parsJson) {
    return UserModel(
      userId: parsJson['userId'],
      userName: parsJson['userName'],
      userEmail: parsJson['userEmail'],
      userPassword: parsJson['userPassword'],
    );
  }
}
