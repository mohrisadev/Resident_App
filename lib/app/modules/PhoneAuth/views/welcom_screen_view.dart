import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:mykommunity/shared/appconstants.dart';
import '../../../widgets/sizeconfig.dart';

class WelcomScreenView extends GetView {
  const WelcomScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final introKey = GlobalKey<IntroductionScreenState>();
    return Center(
      child: Container(
      height: SizeConfig.screenHeight!,
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            titleWidget: Text(
              "Living Redifined",
              style: AppConstants.appStyles.onboardHead,
            ),
            bodyWidget: firstScreen(),
            image: _buildImage(AppConstants.appimages.vector1),
          ),
          PageViewModel(
            titleWidget: Text(
              "Kids",
              style: AppConstants.appStyles.onboardHead,
            ),
            bodyWidget: secondScreen(),
            image: _buildImage(AppConstants.appimages.vector2),
          ),
          PageViewModel(
              titleWidget: Text(
                "Visitors",
                style: AppConstants.appStyles.onboardHead,
              ),
              bodyWidget: thirdScreen(),
              image: _buildImage(AppConstants.appimages.vector3),
              footer: loginButton()),
        ],
        onDone: () => {}, //_login(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        skip: Text('Skip', style: AppConstants.appStyles.smallTextPrimary,),
        next: const Icon(Icons.arrow_forward, color: Colors.white),
        done: const Text('', style: TextStyle(fontWeight: FontWeight.w600)),
        showDoneButton: false,
        dotsDecorator: DotsDecorator(
        activeColor: AppConstants.appcolors.primaryColor,
        color: Colors.grey,
        ),
      ),
    ));
  }
}

Widget loginButton() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: RaisedButton(
            color: AppConstants.appcolors.appOrange,
            splashColor: AppConstants.appcolors.primaryColor,
            child: Text(
              "Login",
              style: AppConstants.appStyles.buttonText,
            ),
            onPressed: () {
              Get.toNamed(Routes.PHONE_AUTH);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: AppConstants.appcolors.appOrange,
                )),
          ),
        ),
      ),
    ],
  );
}

Widget firstScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Smarter Way of Peaceful\nLiving.",
        style: AppConstants.appStyles.onboardText,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget secondScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "No more worries for children.\nA proper check for In and Out of\nthe Premises.",
        style: AppConstants.appStyles.onboardText,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget thirdScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Smarter Way of approving\nVisitor at MyKommunity.",
        style: AppConstants.appStyles.onboardText,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _buildImage(String assetName) {
  return ClipPath(
    child: Padding(
        padding: EdgeInsetsDirectional.only(top: 75),
        child: Image.asset(
          assetName,
          fit: BoxFit.fitWidth,
          height: SizeConfig.screenHeight!,
        )),
  );
}
