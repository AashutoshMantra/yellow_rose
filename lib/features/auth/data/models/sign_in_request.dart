import 'dart:convert';

class SignInRequest {
  final String username;
  final String password;
  final String platform;
  SignInRequest({
    required this.username,
    required this.password,
    this.platform = "APP",
  });

  SignInRequest copyWith({
    String? username,
    String? password,
    String? platform,
  }) {
    return SignInRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      platform: platform ?? this.platform,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'platform': platform});

    return result;
  }

  factory SignInRequest.fromMap(Map<String, dynamic> map) {
    return SignInRequest(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      platform: map['platform'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInRequest.fromJson(String source) =>
      SignInRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'SignInRequest(username: $username, password: $password, platform: $platform)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignInRequest &&
        other.username == username &&
        other.password == password &&
        other.platform == platform;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ platform.hashCode;
}
