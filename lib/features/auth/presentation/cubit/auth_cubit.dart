import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/domain/entities/trip_type.dart';
import 'package:yellow_rose/features/auth/domain/entities/user_details.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';

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
      UserDetails? userDetails = _authUseCase.getUserProfile();
      var enitty =
          await _authUseCase.getBillingEntity(userDetails?.userUid ?? '');
      ApprovalWorkflow? approvalWorkflow;
      try {
        approvalWorkflow = await _authUseCase.getApprovalWorkflow();
      } catch (e) {
        log('No approval workflow found: $e');
      }
      if (userDetails != null) {
        emit(Authenticated(
            userDetails: userDetails,
            billingEntities: enitty,
            approvalWorkflow: approvalWorkflow));
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
      var policyType = (state as Authenticated).approvalWorkflow!.policyApplied;
      if (policyType == "1") {
        return TripType.PreBooking;
      }
      return TripType.PostBooking;
    }
    throw Exception("User not authenticated");
  }
}
