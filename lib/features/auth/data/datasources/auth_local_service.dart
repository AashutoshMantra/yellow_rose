import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';

abstract interface class AuthLocalService {
  bool isSignedIn();
  UserDetails? getUserProfile();
  void saveUserProfile(UserDetails userDetails);
  void clearUserProfile();
}

class AuthLocalServiceImpl implements AuthLocalService {
  final Box userProfileBox = Hive.box('userProfile');

  @override
  bool isSignedIn() {
    try {
      if (userProfileBox.isEmpty) {
        return false;
      } else {
        var profile = jsonDecode(userProfileBox.get('profile') ?? '{}');
        if (profile != null && profile['token'] != null) {
          var isExpired = JwtDecoder.isExpired(profile['token']);
          if (isExpired) {
            userProfileBox.clear();
          }

          return !isExpired;
        } else {
          userProfileBox.clear();
          return false;
        }
      }
    } catch (e) {
      print('Error accessing user profile box: $e');
      return false;
    }
  }

  @override
  UserDetails? getUserProfile() {
    try {
      if (userProfileBox.isEmpty || !isSignedIn()) {
        return null;
      } else {
        var profile = userProfileBox.get('profile');
        if (profile.isNotEmpty) {
          return UserDetails.fromJson(profile);
        } else {
          return null;
        }
      }
    } catch (e) {
      print('Error accessing user profile box: $e');
      return null;
    }
  }

  @override
  void saveUserProfile(UserDetails userDetails) {
    userProfileBox.put('profile', userDetails.toJson());
  }

  @override
  void clearUserProfile() {
    userProfileBox.clear();
  }
}
