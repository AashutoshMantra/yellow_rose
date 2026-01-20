import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/domain/entities/trip_type.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_booking_profile_extensions.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _authUseCase = getIt<IAuthUseCase>();

  bool shouldShowTripAsHome() {
    if (state is Authenticated) {
      return tripType != TripType.NoTrip;
    }
    throw Exception("User not authenticated");
  }

  Future<void> appStarted() async {
    if (_authUseCase.isLoggedIn()) {
      UserDetails? userDetails = _authUseCase.getUserDetails();
      var enitty =
          await _authUseCase.getBillingEntity(userDetails?.userUid ?? '');
      ApprovalWorkflow? approvalWorkflow;
      try {
        approvalWorkflow = await _authUseCase.getApprovalWorkflow();
      } catch (e) {
        log('No approval workflow found: $e');
      }
      if (userDetails != null) {
        UserBookingProfile userBookingProfile =
            await _authUseCase.getUserProfile();
        List<UserBookingProfile> corporateProfiles = [];
        if (approvalWorkflow?.tripType != TripType.NoTrip) {
          corporateProfiles =
              await _authUseCase.getGroupByCorporateUserProfiles();
        } else {
          corporateProfiles = await _authUseCase.getAllCorporateProfile();
        }
        corporateProfiles = corporateProfiles
            .where((profile) =>
                profile.firstName != null &&
                profile.firstName!.isNotEmpty &&
                profile.gender != null &&
                profile.contactNumber != null)
            .toList();

        emit(Authenticated(
            userDetails: userDetails,
            billingEntities: enitty,
            approvalWorkflow: approvalWorkflow,
            userBookingProfile: userBookingProfile,
            corporateProfiles: corporateProfiles));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  TripType get tripType {
    if (state is Authenticated &&
        (state as Authenticated).approvalWorkflow != null) {
      return (state as Authenticated).approvalWorkflow!.tripType;
    }
    throw Exception("User not authenticated");
  }

  bool get isTripAdmin {
    if (state is Authenticated &&
        (state as Authenticated).approvalWorkflow != null) {
      return (state as Authenticated).approvalWorkflow!.approvalAdmin == true;
    }
    throw Exception("User not authenticated");
  }

  List<UserBookingProfile> get allProfiles {
    if (state is Authenticated) {
      final authState = state as Authenticated;
      return getFilteredProfile(
          [authState.userBookingProfile, ...authState.corporateProfiles]);
    }
    return [];
  }

  List<UserBookingProfile> get corporateProfiles {
    if (state is Authenticated) {
      return getFilteredProfile((state as Authenticated).corporateProfiles);
    }
    return [];
  }

  UserBookingProfile? get userProfile {
    if (state is Authenticated) {
      return (state as Authenticated).userBookingProfile;
    }
    return null;
  }

  List<UserBookingProfile> getFilteredProfile(
      List<UserBookingProfile> profiles) {
    return profiles
        .where((profile) =>
            profile.firstName != null &&
            profile.firstName!.isNotEmpty &&
            profile.email != null &&
            profile.contactNumber != null &&
            profile.email!.isNotEmpty &&
            profile.contactNumber!.isNotEmpty &&
            profile.gender != null &&
            profile.gender!.isNotEmpty)
        .toList();
  }

  List<PassengerDetailsEntity> getfixedPassengerDetails({TripResponse? trip}) {
    if (state is Authenticated && trip != null) {
      final authState = state as Authenticated;
      if (trip.tripFor == TripFor.Self.value) {
        return [authState.userBookingProfile.toPassengerDetailsEntity()];
      } else {
        return corporateProfiles
            .where((profile) =>
                profile.userUid != null &&
                trip.tripDetails?.onBehalf?.contains(profile.userUid) == true)
            .map((profile) => profile.toPassengerDetailsEntity())
            .toList();
      }
    }
    return [];
  }
}
