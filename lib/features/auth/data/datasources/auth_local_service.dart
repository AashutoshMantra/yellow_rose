import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';

abstract interface class AuthLocalService {
  bool isSignedIn();
  UserDetails? getUserProfile();
}

class AuthLocalServiceImpl implements AuthLocalService {
  final Box airportBox = Hive.box('userProfile');

  @override
  bool isSignedIn() {
    try {
      if (airportBox.isEmpty) {
        return false;
      } else {
        var profile = jsonDecode(airportBox.get('profile') ?? '{}');
        if (profile != null && profile['token'] != null) {
          var isExpired = JwtDecoder.isExpired(profile['token']);
          if (isExpired) {
            airportBox.clear();
          }

          return !isExpired;
        } else {
          airportBox.clear();
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
      if (airportBox.isEmpty || !isSignedIn()) {
        return null;
      } else {
        var profile = airportBox.get('profile');
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
}
