import 'package:flutter/material.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:novi_test/utils/text_strings.dart';

class CountryCodeNumberWidget extends StatefulWidget {
  const CountryCodeNumberWidget({super.key,
  required this.countryCodeController,required this.phoneController});
  final TextEditingController countryCodeController ;
  final TextEditingController phoneController ;

  @override
  State<CountryCodeNumberWidget> createState() =>
      _CountryCodeNumberWidgetState();
}

class _CountryCodeNumberWidgetState extends State<CountryCodeNumberWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: TextFormField(
            controller:widget.countryCodeController,
            decoration: const InputDecoration(
              hintText: "+91",
              hintStyle: TextStyle(color: KColorConstants.loremColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            controller:widget.phoneController,
            decoration: const InputDecoration(
              hintText: TextStrings.enterYourNumber,
              hintStyle: TextStyle(color: KColorConstants.loremColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
