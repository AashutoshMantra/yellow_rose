import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/utils/dio_client.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/data/models/billing_entity.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_request.dart';
import 'package:yellow_rose/features/auth/data/models/sign_in_response.dart';

abstract interface class AuthService {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
  Future<List<BillingEntity>> getBillingEntity(String uuid);
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
}
