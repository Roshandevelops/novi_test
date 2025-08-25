import 'package:flutter/material.dart';
import 'package:novi_test/infrastructure/auth_controller.dart';
import 'package:novi_test/utils/colors.dart';
import 'package:novi_test/utils/text_strings.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthController authProvider;
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    authProvider = Provider.of<AuthController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
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
                  "Lorem ipsum dolor sit amet consecteur.porta at id hac\nvitae.Et tortor at vehicula euismod mi viverra.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: KColorConstants.loremColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        controller: countryCodeController,
                        decoration: InputDecoration(
                          hintText: "+91",
                          hintStyle:
                              TextStyle(color: KColorConstants.loremColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: "Enter  Mobile Number",
                          hintStyle:
                              TextStyle(color: KColorConstants.loremColor),
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 2,
                ),
                InkWell(
                  onTap: () {
                    login(context);
                  },
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Continue",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    await authProvider.login(
      countryCodeController.text,
      phoneController.text,
      context,
    );
  }
}
