import 'dart:convert';

class SignInResponse {
  final String? displayName;
  final String? username;
  final String token;
  SignInResponse({
    this.displayName,
    this.username,
    required this.token,
  });

  SignInResponse copyWith({
    String? displayName,
    String? username,
    String? token,
  }) {
    return SignInResponse(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(displayName != null){
      result.addAll({'displayName': displayName});
    }
    if(username != null){
      result.addAll({'username': username});
    }
    result.addAll({'token': token});
  
    return result;
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      displayName: map['displayName'],
      username: map['username'],
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResponse.fromJson(String source) => SignInResponse.fromMap(json.decode(source));

  @override
  String toString() => 'SignInResponse(displayName: $displayName, username: $username, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SignInResponse &&
      other.displayName == displayName &&
      other.username == username &&
      other.token == token;
  }

  @override
  int get hashCode => displayName.hashCode ^ username.hashCode ^ token.hashCode;
}
