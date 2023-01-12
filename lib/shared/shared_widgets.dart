import 'package:flutter/material.dart';
import 'package:mykommunity/shared/appconstants.dart';

Widget getFormatedPhoneNumber(p) {
  if (p == null) {
    return Text(
      "na",
      style: AppConstants.appStyles.smallText,
    );
  }

  if (p.toString().length <= 10) {
    return Text(
      p,
      style: AppConstants.appStyles.smallText,
    );
  } else {
    String formattedPhoneNumber = p.substring(0, 3) +
        " " +
        p.substring(3, 8) +
        " " +
        p.substring(8, p.length);

    return Text(
      formattedPhoneNumber,
      style: AppConstants.appStyles.smallText,
    );
  }
}
