import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_screen/otp_verification_screen/otp_verification_screen.dart';

class PhoneVerifyProvider with ChangeNotifier{
  TextEditingController _numberController=TextEditingController();
  TextEditingController get numberController=>_numberController;
  TextEditingController _otpController=TextEditingController();
  TextEditingController get otpController=>_otpController;
   bool _isLoading=false;
   bool get isLoading=>_isLoading;

   void loadingTrue(){
     _isLoading=true;
     notifyListeners();
   }
  void loadingFalse(){
    _isLoading=false;
    notifyListeners();
  }


}