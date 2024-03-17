import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/provider/dashboard_provider.dart';
import 'package:flutter_authentication/provider/phone_authentication_provider.dart';
import 'package:flutter_authentication/view_screen/dashboard/dashboard.dart';
import 'package:flutter_authentication/view_screen/mobile_verification_screen/enter_mobile_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>PhoneVerifyProvider()),
        ChangeNotifierProvider(create: (_)=>DashboardProvider()),
      ],
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
    home: EnterMobileNumber(),
      // home: DashboardScreen(),
      );
    },
    );
  }
}
