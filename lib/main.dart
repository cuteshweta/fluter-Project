import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haritashr/src/core/utils/shared_preference/app_shared_preference.dart';
import 'package:haritashr/src/features/presentation/attendance/logic/attendance_bloc.dart';
import 'package:haritashr/src/features/presentation/leave/logic/leave_bloc.dart';
import 'package:haritashr/src/features/presentation/login/logic/login_bloc.dart';
import 'package:haritashr/src/features/presentation/login/logic/verify_otp/verify_otp_bloc.dart';
import 'package:haritashr/src/features/presentation/login/view/login_screen.dart';
import 'package:haritashr/src/features/presentation/login/view/otp_verification_screen.dart';
import 'package:haritashr/src/presentation/views/dashboard_screen.dart';
import 'package:haritashr/src/features/presentation/attendance/view/home_screen.dart';
import 'package:haritashr/src/features/presentation/leave/view/leave_request_screen.dart';
import 'package:haritashr/src/shared/app_injection.dart';

void main() async {
  // init injection
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  runApp(
    DevicePreview(
      builder: (context) {
        return const MyApp();
      },
      enabled: false,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (_) => BlocProvider(
          create: (_) => LoginBloc(sl()),
          child: AppSharedPreference.instance?.getIsUserLogin() ?? false
              ? const DashboardScreen()
              : LoginScreen(),
        ),
        '/otpVerification': (_) => BlocProvider(
          create: (_) => VerifyOtpBloc((sl())),
          child: const OtpVerificationScreen(),
        ),
        '/homeScreen': (_) => BlocProvider(
          create: (_) => AttendanceBloc(sl()),
          child: HomeScreen(),
        ),
        '/leaveRequest': (_) => BlocProvider(
          create: (_) => LeaveBloc(sl()),
          child: LeaveRequestScreen(),
        ),
        '/dashboard': (_) => const DashboardScreen(),
      },
    );
  }
}
