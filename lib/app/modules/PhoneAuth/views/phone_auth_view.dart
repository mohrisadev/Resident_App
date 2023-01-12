import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mykommunity/shared/appconstants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controllers/phone_auth_controller.dart';

class PhoneAuthView extends GetView<PhoneAuthController> {
  Widget getPhoneNumberWidget() {
    return Container(
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 60,
                child: CountryCodePicker(
                  showDropDownButton: true,
                  textStyle: AppConstants.appStyles.frequentlytitleWhite,
                  onChanged: (c) => {controller.updateContryCode(c.toString())},
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: ['+91', 'IN'],
                  countryFilter: ['IN', 'AU', 'US'],
                  showFlagDialog: false,
                )),
            Expanded(
              child: TextFormField(
                style: AppConstants.appStyles.phoneNumberWhite,
                maxLength: 10,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Enter Your Mobile Number",
                  hintStyle: AppConstants.appStyles.hintTopbar,
                  counterText: '', // "Enter Registered Mobile Number",
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,),),
                  prefix: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(controller.countryCode,
                    style: AppConstants.appStyles.phoneNumberWhite,
                    ),
                  ),
                ),
                controller: controller.phone,
                onChanged: (text) {
                  controller.validate();
                },
              ),
            )
          ],
        ));
  }
  getMobileFormWidget(context) {
    return GetBuilder<PhoneAuthController>(builder: (controller) {
      return Column(
        children:<Widget> [
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("What's Your Mobile Number",
                style: AppConstants.appStyles.mediumPagetitle,
                textAlign: TextAlign.left,
              )),
          getPhoneNumberWidget(),
          SizedBox(height: 16),
          SizedBox(
            width: controller.sc_width * 0.75,
            child: FlatButton(
              color: !controller.isValid
                  ? Colors.grey[500]
                  : AppConstants.appcolors.appOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                !controller.isValid
                    ? "Enter 10 digit mobile number"
                    : "Send OTP",
                style: AppConstants.appStyles.buttonText,
              ),
              onPressed: () async {
                if (controller.isValid) {
                  controller.verifyNumber(context);
                } else {
                  controller.validate();
                }
              },
              padding: EdgeInsets.all(16.0),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Text(
          //     "We will send you a One Time Password",
          //     style: AppConstants.appStyles.medium,
          //   ),
          // ),
          // getTandCbutton(),
          // getAgreeWidget(),
          //  Spacer(),
        ],
      );
    });
  }

  getOtpFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            'Enter the OTP sent\n on ${controller.phone.text}',
            style: AppConstants.appStyles.titleStrongHead,
            textAlign: TextAlign.left,
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
        //   child: RichText(
        //     text: TextSpan(
        //         text:
        //             "Once you receive the verification code, enter it here to confirm your identity. Code sent to \n",
        //         children: [
        //           TextSpan(
        //               text: controller.phone.text,
        //               style: TextStyle(
        //                   color: Colors.black,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 14)),
        //         ],
        //         style: TextStyle(color: Colors.black54, fontSize: 15)),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        SizedBox(height: 10),
        Text(controller.errmsg,
          style: AppConstants.appStyles.smallTextwhite,
        ),

        Form(
          key: controller.formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.blueGrey.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                autoDisposeControllers: false,
                //obscureText: true,
                //obscuringCharacter: '*',
                // obscuringWidget: FlutterLogo(
                //   size: 24,
                // ),

                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 6) {
                    return "Please enter complete PIN";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeColor: controller.hasError
                      ? AppConstants.appcolors.primaryColor
                      : Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 100),
                enableActiveFill: true,
                errorAnimationController: controller.errorController,
                controller: controller.otpcontroller,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  controller.signinwithPCredentials();
                },
                onSaved: (v) {
                  controller.signinwithPCredentials();
                },
                onSubmitted: (v) {
                  controller.signinwithPCredentials();
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  //print(value);
                  controller.onPinchange(value);
                },
                // beforeTextPaste: (text) {
                //   print("Allowing to paste $text");
                //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
                //   return true;
                // },
              )),
        ),

        // FlatButton(
        //   onPressed: () async {
        //     PhoneAuthCredential phoneAuthCredential =
        //         PhoneAuthProvider.credential(
        //             verificationId: verificationId,
        //             smsCode: otpController.text);
        //     signInWithPhoneAuthCredential(phoneAuthCredential);
        //   },
        //   child: Text("VERIFY"),
        //   color: Colors.blue,
        //   textColor: Colors.white,
        // ),
        SizedBox(height: 2),
        Center(
          child: SizedBox(
              width: controller.sc_width * 0.75,
              child: FlatButton(
                color: AppConstants.appcolors.appOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  "Login",
                  style: AppConstants.appStyles.buttonText,
                ),
                onPressed: () async {
                  controller.signinwithPCredentials();
                },
                padding: EdgeInsets.all(16.0),
              )),
        ),

        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style: AppConstants.appStyles.smallTextwhite,
            ),
            TextButton(
                onPressed: () {
                  controller.setFormState();
                },
                child: Text(
                  "RESEND",
                  style: TextStyle(
                      color: AppConstants.appcolors.appOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
        SizedBox(height: 5,),
      ],
    );
  }

  Widget getUi(context) {
    return controller.showLoading
        ? Center(
          child: CircularProgressIndicator(),
          )
        : controller.currentState ==
                MobileVerificationState.SHOW_MOBILE_FORM_STATE
            ? getMobileFormWidget(context)
            : getOtpFormWidget(context);
      }

  getTandCbutton() {
    return Center(
        child: InkWell(
            child: Text(
              'Terms & Conditions',
              style: AppConstants.appStyles.smallTextred,
            ),
            onTap: () => {}));
  }

  Widget getAgreeWidget() {
    return ListTile(
      leading: Checkbox(
        value: controller.agree,
        onChanged: (value) {
          controller.updateAgree();
        },
      ),
      selected: true,
      title: Text('I have read and accept terms and conditions',
          style: AppConstants.appStyles.sidehead),
      subtitle: Text('(Please read the terms and conditiosn and tick ✓ this.)',
          style: AppConstants.appStyles.smallText),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.sc_width = MediaQuery.of(context).size.width;
    controller.sc_height = MediaQuery.of(context).size.height;

    return Scaffold(

        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(150.0), // here the desired height
        //     child: AppBar(
        //       automaticallyImplyLeading: false,
        //       backgroundColor: Colors.transparent,
        //       flexibleSpace: Image(
        //           image: AssetImage('assets/images/mainheader.png'),
        //           fit: BoxFit.cover),
        //       title: Text("\nLog In"),
        //     )),
        // key: controller.scaffoldKey,
        body: GetBuilder<PhoneAuthController>(builder: (controller) {
      return Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/mainheader.png"),
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          width: double.infinity,
          color: AppConstants.appcolors.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 220.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/mainheader.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "\n\n${controller.TitleText}",
                      style: AppConstants.appStyles.loginTitle,
                    )),
              ),

              //   backgroundColor: Colors.transparent,
              //   flexibleSpace: Image(
              //       width: double.infinity,
              //       image: AssetImage('assets/images/mainheader.png'),
              //       fit: BoxFit.cover),
              //   title: Text("\n\n\nLog In"),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SizedBox(
              //         height: controller.sc_width * .15,
              //       ),
              //       Text(
              //         "Login",
              //         style: AppConstants.appStyles.tileText,
              //       ),
              //       //Text("Welcome", style: AppConstants.appStyles.smallTextwhite,),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(

                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(30),
                    //         topRight: Radius.circular(30)),
                    //     image: DecorationImage(
                    //       colorFilter: ColorFilter.mode(
                    //           Colors.black.withOpacity(0.05),
                    //           BlendMode.dstATop),
                    //       image: AssetImage(AppConstants.appimages.app_logo),
                    //       fit: BoxFit.contain,
                    //     )),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child:
                            //getUi(context)

                            // controller.showLoading
                            //     ? Center(
                            //         child: CircularProgressIndicator(),
                            //       )
                            //     :
                            controller.currentState ==
                                MobileVerificationState.SHOW_MOBILE_FORM_STATE
                                ? getMobileFormWidget(context)
                                : getOtpFormWidget(context))),
              ),
            ],
          ));
    }));
  }
}
