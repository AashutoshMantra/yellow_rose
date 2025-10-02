import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/domain/usecases/auth_use_case.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/auth/presentation/pages/sign_in_screen.dart';
// ... existing imports ...
import 'package:yellow_rose/core/common_widgets/custom_outline_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ...existing code...

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    String name = '';
    String username = '';
    if (authState is Authenticated) {
      name = authState.userDetails.displayName ?? '';
      username = authState.userDetails.username ?? '';
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 36.h,
                            backgroundColor:
                                AppColors.primary.withOpacity(0.15),
                            child: Icon(Icons.person,
                                size: 36.h, color: AppColors.primary),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name.isNotEmpty ? name : 'Profile',
                                    style: TextStyles.h4Style()),
                                SizedBox(height: 4.h),
                                Text(
                                    username.isNotEmpty
                                        ? username
                                        : 'No username',
                                    style: TextStyles.bodySmallStyle().copyWith(
                                        color:
                                            AppColors.primaryTextSwatch[500])),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Show user details
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.all(12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account', style: TextStyles.h5Style()),
                              SizedBox(height: 8.h),
                              if (authState is Authenticated) ...[
                                _detailRow('Display name',
                                    authState.userDetails.displayName),
                                _detailRow(
                                    'Username', authState.userDetails.username),
                                _detailRow(
                                    'User UID', authState.userDetails.userUid),
                                _detailRow('Type', authState.userDetails.type),
                                _detailRow(
                                    'Platform', authState.userDetails.platform),
                                _detailRow(
                                    'White label id',
                                    authState.userDetails.whiteLabelId
                                        ?.toString()),
                                _detailRow(
                                    'Login domain id',
                                    authState.userDetails.loginDomainId
                                        ?.toString()),
                              ] else ...[
                                Text('No account information available',
                                    style: TextStyles.bodySmallStyle()),
                              ]
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Billing entities
                      Text('Billing Entities', style: TextStyles.h5Style()),
                      SizedBox(height: 8.h),
                      if (authState is Authenticated &&
                          authState.billingEntities.isNotEmpty)
                        ...authState.billingEntities.map((be) => Card(
                              child: ListTile(
                                title: Text(be.entityName ??
                                    'Entity ${be.entityId ?? ''}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (be.address != null) Text(be.address!),
                                    if (be.phone != null)
                                      Text('Phone: ${be.phone}'),
                                    if (be.email != null)
                                      Text('Email: ${be.email}'),
                                  ],
                                ),
                              ),
                            ))
                      else
                        Text('No billing entities available',
                            style: TextStyles.bodySmallStyle()),
                    ],
                  ),
                ),
              ),

              // Logout button fixed at bottom
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                width: double.infinity,
                child: CustomOutlinedButton(
                  text: 'Logout',
                  buttonType: OutlinedButtonType.danger,
                  textStyleOverride: TextStyle(
                    fontWeight: TextStyles.bodyLargeBoldStyle().fontWeight,
                    fontSize: TextStyles.bodyLargeBoldStyle().fontSize,
                  ),
                  onPressed: () async {
                    // Capture objects that use BuildContext before any await
                    final authCubit = context.read<AuthCubit>();
                    final navigator = Navigator.of(context);
                    final authUseCase = getIt<IAuthUseCase>();

                    // Use the repository/usecase signOut flow
                    try {
                      await authUseCase.signOut();
                    } catch (_) {}

                    if (!mounted) return;

                    // Refresh auth state so app reacts accordingly
                    try {
                      authCubit.appStarted();
                    } catch (_) {}

                    if (!mounted) return;
                    navigator.pushReplacementNamed(SignInScreen.routeName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _detailRow(String title, String? value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Text(title,
                style: TextStyles.bodySmallStyle()
                    .copyWith(fontWeight: FontWeight.w600))),
        Expanded(
            flex: 5,
            child: Text(value ?? '-',
                style: TextStyles.bodySmallStyle()
                    .copyWith(color: AppColors.primaryTextSwatch[500]))),
      ],
    ),
  );
}
