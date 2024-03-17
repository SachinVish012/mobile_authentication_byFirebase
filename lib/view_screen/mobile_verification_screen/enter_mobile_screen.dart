import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/res/colors/app_color.dart';
import 'package:flutter_authentication/res/app_localization_text/app_localization_text.dart';
import 'package:flutter_authentication/res/components/custom_text.dart';
import 'package:flutter_authentication/res/toast_msg/toast_msg.dart';
import 'package:flutter_authentication/view_screen/mobile_verification_screen/widget/mobile_title_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/phone_authentication_provider.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/custom_textformfield.dart';
import '../otp_verification_screen/otp_verification_screen.dart';

class EnterMobileNumber extends StatefulWidget {
  const EnterMobileNumber({super.key});

  @override
  State<EnterMobileNumber> createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {


  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<PhoneVerifyProvider>(context,listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //---for title
              MobileTitileWidget(),
              const SizedBox(
                height: 20,
              ),

              //-----for enter mobile number---->+911000000010
              CustomTextField(
                controller: provider.numberController,
                labelText: AppLocalizationText.mobile_number,
                icon: Icons.phone_rounded,
              ),
              const SizedBox(
                height: 50,
              ),

              //-----for submit mobile number to get otp
              Consumer<PhoneVerifyProvider>(
                builder: (context, value, child) {
                  return
                    value.isLoading?Center(child: CircularProgressIndicator()):CustomElevatedButton(
                    text: AppLocalizationText.continue_btn,
                    backgroundColor: AppColors.btn_color,
                    onPressed: (){
                      if(value.numberController.text.isEmpty){
                        toastRedC("Please Enter Valid Number");
                      }
                      else  if(value.numberController.text.startsWith("+91")&& value.numberController.text.length==13){
                        print(value.numberController.text);
                        SendOtp();
                      }
                      else
                        {
                          toastRedC("Enter valid 10 digit number with Country Code(+91)");
                        }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> SendOtp() async{
    final provider=Provider.of<PhoneVerifyProvider>(context,listen: false);
    provider.loadingTrue();
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted:
            (PhoneAuthCredential credential) {
          provider.loadingFalse();
            },
        verificationFailed: (FirebaseAuthException ex) {
          provider.loadingFalse();
        },
        codeSent: (String verificationid, int? resendToken) {
          provider.loadingFalse();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerifyScreen(verificationID: verificationid,)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          provider.loadingFalse();
        },
        phoneNumber: provider.numberController.text.toString());
  }
}
