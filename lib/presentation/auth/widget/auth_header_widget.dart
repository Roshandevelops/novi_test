import 'package:flutter/material.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:novi_test/utils/text_strings.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextStrings.enterYour,
          style: TextStyle(
            fontSize: 20,
            color: KColorConstants.whiteColor,
          ),
        ),
        Text(
          TextStrings.mobileNumber,
          style: TextStyle(
            fontSize: 20,
            color: KColorConstants.whiteColor,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          TextStrings.loremText,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: KColorConstants.loremColor,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
