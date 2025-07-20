import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:yellow_rose/core/common_widgets/ImageIcon.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_text_form_field.dart';
import 'package:yellow_rose/core/common_widgets/form_title_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/sign_in_form_cubit.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/dashboard.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = "/signInScreen";
  SignInScreen({super.key});
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  onSubmit(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        _btnController.start();
        await context.read<SignInFormCubit>().signIn();
        context.read<AuthCubit>().appStarted();
        Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
        _btnController.successReset();
      }
    } catch (e) {
      _btnController.errorReset();
      WidgetUtil.showSnackBar("Sign in failed", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Sign in",
        subTitle:
            "Sign in with your email and password to access your account.",
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyles.h4Style(),
                        ),
                        SizedBox(width: 8.w),
                        CustomImageIcon(
                          image: const AssetImage("assets/images/hi.png"),
                          size: 24.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                        "We happy to see you again! to use your account, you should sign in first.",
                        style: TextStyles.bodyMediumStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[500])),
                  ],
                ),
              ),
              SizedBox(
                height: 34.h,
              ),
              BlocProvider(
                create: (context) => SignInFormCubit(),
                child: BlocBuilder<SignInFormCubit, SignInFormState>(
                  builder: (context, state) {
                    return Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormTitle(title: "Email"),
                          CustomTextFormField(
                            text: "Enter your email",
                            type: TextInputType.emailAddress,
                            validator: (_) {
                              if (state.userName == null ||
                                  state.userName!.isEmpty) {
                                return 'Please enter your email';
                              }
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                              if (!emailRegex.hasMatch(state.userName ?? '')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onchange: (email) {
                              context
                                  .read<SignInFormCubit>()
                                  .onEmailChange(email);
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          const FormTitle(title: "Password"),
                          CustomTextFormField(
                            text: "Enter your Password",
                            type: TextInputType.visiblePassword,
                            obs: state.showPassword,
                            maxLines: 1,
                            validator: (_) {
                              if (state.password == null ||
                                  state.password!.isEmpty) {
                                return 'Please enter your password';
                              }

                              return null;
                            },
                            onchange: (password) {
                              context
                                  .read<SignInFormCubit>()
                                  .onPasswordChange(password);
                            },
                            suffixicon: GestureDetector(
                              onTap: () {
                                context
                                    .read<SignInFormCubit>()
                                    .toggleShowPasswordChange();
                              },
                              child: Icon(
                                !state.showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryTextSwatch[400],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 34.h,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Forgot password?")),
                          SizedBox(
                            height: 34.h,
                          ),
                          CustomButton(
                            buttonController: _btnController,
                            text: "Sign In",
                            onPressed: () => onSubmit(context),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
