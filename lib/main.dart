import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/app_routes.dart';
import 'package:yellow_rose/core/app_config.dart';
import 'package:yellow_rose/core/storage/hive_setup.dart';
import 'package:yellow_rose/core/theme/theme.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/app_update/app_update_cubit.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/home_screen_cubit.dart';
import 'package:yellow_rose/features/home_screen/presentation/pages/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup.init();
  await Future.wait(
      [AppConfig.instance.loadConfig(), setupDependencyInjection()]);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(
      errorDetails,
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenCubit>(
          create: (BuildContext context) => HomeScreenCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()..appStarted(),
        ),
        BlocProvider<AppUpdateCubit>(
          create: (context) => AppUpdateCubit()..checkForUpdates(),
        ),
      ],
      child: LayoutBuilder(builder: (context, constratints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constratints, orientation);

          return MaterialApp(
            title: 'Gilpin Travels',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightThemeData(context),
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return const Dashboard();
                } else if (state is Unauthenticated) {
                  return SignInScreen();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        });
      }),
    );
  }
}
