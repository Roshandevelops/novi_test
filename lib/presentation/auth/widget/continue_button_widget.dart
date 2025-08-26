import 'package:flutter/material.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:novi_test/utils/text_strings.dart';

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: KColorConstants.borderColor,
            ),
          ),
          width: 130,
          height: 55,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                TextStrings.continueText,
                style: TextStyle(
                  color: KColorConstants.whiteColor,
                ),
              ),
              CircleAvatar(
                backgroundColor: KColorConstants.continueIconColor,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
