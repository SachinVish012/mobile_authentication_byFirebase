import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/res/app_localization_text/app_localization_text.dart';
import 'package:flutter_authentication/res/components/custom_button.dart';
import 'package:flutter_authentication/res/components/custom_text.dart';
import 'package:flutter_authentication/res/components/custom_textformfield.dart';
import 'package:flutter_authentication/res/toast_msg/toast_msg.dart';
import 'package:flutter_authentication/view_screen/dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import '../../provider/phone_authentication_provider.dart';
import '../../res/colors/app_color.dart';

class OTPVerifyScreen extends StatefulWidget {
  String verificationID;
  OTPVerifyScreen({super.key,required this.verificationID});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<PhoneVerifyProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextWidget(
                text: AppLocalizationText.otp_title,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
                fontSize: 18,
              ),
              const SizedBox(
                height: 20,
              ),

              CustomTextField(
                  controller: provider.otpController,
                  labelText: AppLocalizationText.otp_enter
              ),
              const SizedBox(
                height: 50,
              ),
              Consumer<PhoneVerifyProvider>(
                builder: (context, value, child) {
                  return value.isLoading?Center(child: CircularProgressIndicator()):
                  CustomElevatedButton(
                      text: AppLocalizationText.otp_btn,
                      backgroundColor: AppColors.btn_color,
                      onPressed: (){
                        if(value.otpController.text.isNotEmpty&&value.otpController.text.length==6)
                          {
                            verifyOTP();
                          }
                        else{
                          toastRedC("Enter Valid OTP");
                        }

                      }
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<void> verifyOTP() async{
    final provider=Provider.of<PhoneVerifyProvider>(context,listen: false);
    provider.loadingTrue();
    try {
      PhoneAuthCredential credential =
          await PhoneAuthProvider.credential(
          verificationId: widget.verificationID,
          smsCode: provider.otpController.text.toString());
      FirebaseAuth.instance.signInWithCredential(credential).then((value){
        log(value.toString());
        provider.loadingFalse();
        toastGreen("OTP Verified");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
      });
    }
    catch(ex){
      provider.loadingFalse();
      log(ex.toString());
    }
  }
}
