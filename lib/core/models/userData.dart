class UserData{
  final String userName;
  final String userEmail;

  UserData({
    required this.userName,
    required this.userEmail
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'email': userEmail,
  };

  static UserData fromJson(Map<String, dynamic> json) => UserData(
    userName: json['userName'],
    userEmail: json['email'],
  );

}