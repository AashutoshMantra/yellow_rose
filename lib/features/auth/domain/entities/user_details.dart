import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_response.dart';

class UserDetails {
  final String? displayName;
  final String? username;
  final String token;
  String? type;
  String? userUid;
  int? whiteLabelId;
  int? loginDomainId;
  String? userType;
  String? platform;

  UserDetails({
    this.displayName,
    this.username,
    required this.token,
  }) {
    var decodedToken = JwtDecoder.decode(token);
    type = decodedToken['type']?.toString();
    userUid = decodedToken['userUid']?.toString();
    whiteLabelId = decodedToken['whiteLabelId']?.toInt();
    loginDomainId = decodedToken['loginDomainId']?.toInt();
    userType = decodedToken['userType']?.toString();
    platform = decodedToken['platform']?.toString();
  }

  UserDetails copyWith({
    String? displayName,
    String? username,
    String? token,
  }) {
    return UserDetails(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (displayName != null) {
      result.addAll({'displayName': displayName});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    result.addAll({'token': token});

    return result;
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      displayName: map['displayName'],
      username: map['username'],
      token: map['token'] ?? '',
    );
  }
  factory UserDetails.fromSignInResponse(SignInResponse response) {
    return UserDetails(
      displayName: response.displayName,
      username: response.username,
      token: response.token ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserDetails(displayName: $displayName, username: $username, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetails &&
        other.displayName == displayName &&
        other.username == username &&
        other.token == token;
  }

  @override
  int get hashCode => displayName.hashCode ^ username.hashCode ^ token.hashCode;
}
