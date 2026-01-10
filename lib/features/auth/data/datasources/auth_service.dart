import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/policy/approval_workflow_request.dart';
import 'package:yellow_rose/features/auth/data/models/profile/user_booking_profile.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_response.dart';

abstract interface class AuthService {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
  Future<List<BillingEntity>> getBillingEntity(String uuid);
  Future<ApprovalWorkflow> getApprovalWorkflow();
  Future<List<UserBookingProfile>> getAllCorporateProfile();
  Future<UserBookingProfile> getUserProfile();
  Future<List<UserBookingProfile>> getGroupByCorporateUserProfiles();
}

class AuthServiceIml implements AuthService {
  final _dioClinet = getIt<DioClient>();
  @override
  Future<SignInResponse> signIn(SignInRequest signInRequest) async {
    var response = await _dioClinet.post(
      '${AppConfig.instance.apiBaseUrl}/auth/signin',
      data: signInRequest.toMap(),
    );
    return SignInResponse.fromMap(response.data);
  }

  @override
  Future<List<BillingEntity>> getBillingEntity(String uuid) async {
    try {
      var response = await _dioClinet.post(
        '${AppConfig.instance.apiBaseUrl}/crm/entity/list/$uuid',
      );
      final List<BillingEntity> billingList = (response.data ?? [])
          .map<BillingEntity>((d) => BillingEntity.fromMap(d))
          .toList();
      return billingList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ApprovalWorkflow> getApprovalWorkflow() async {
    var response = await _dioClinet.get(
      '${AppConfig.instance.apiBaseUrl}/approval/workflow/assigned',
    );
    return ApprovalWorkflow.fromMap(response.data);
  }

  @override
  Future<List<UserBookingProfile>> getAllCorporateProfile() async {
    var response = await _dioClinet.post(
        '${AppConfig.instance.apiBaseUrl}/crm/userProfile/list',
        data: {});
    final List<UserBookingProfile> profileList = (response.data ?? [])
        .map<UserBookingProfile>((d) => UserBookingProfile.fromMap(d))
        .toList();
    return profileList;
  }

  @override
  Future<UserBookingProfile> getUserProfile() async {
    var response = await _dioClinet
        .post('${AppConfig.instance.apiBaseUrl}/crm/userProfile', data: {});
    return UserBookingProfile.fromMap(response.data);
  }

  @override
  Future<List<UserBookingProfile>> getGroupByCorporateUserProfiles() async {
    var response = await _dioClinet.post(
        '${AppConfig.instance.apiBaseUrl}/crm/userBookProfile/list',
        data: {});
    final List<UserBookingProfile> profileList =
        (response.data ?? []).map<UserBookingProfile>((d) {
      var result = UserBookingProfile.fromMap(d["userBookingProfile"]);
      return result.copyWith(
          contactNumber: result.contactNumber ?? d["contactNumber"],
          email: result.email ?? d["email"]);
    }).toList();
    return profileList;
  }
}
